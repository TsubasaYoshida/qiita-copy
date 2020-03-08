class Draft < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  has_one :item, dependent: :destroy
  has_and_belongs_to_many :tags

  attr_writer :tag_names
  attr_accessor :type

  after_create :attach_tags
  after_create :make_copy_to_item

  TYPE = {'Ciita に投稿': :post, '下書き保存': :save}

  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :body,
            presence: true,
            length: {maximum: 100_000}
  validates :type,
            inclusion: {in: %w(post save)}
  validates :tag_names,
            presence: true,
            # 最大50文字のタグが5つまで＝250文字、スペースで区切るためそのスペース分＝4文字
            length: {maximum: 254}
  validate :cannot_have_more_than_6_tags
  validate :cannot_have_duplicate_tags

  def tag_names
    # createする時、writerだけじゃなくgetterも呼ばれているため、「@tag_names || 」を使う必要がある。
    # こう書かないと、バリデーションで引っかかって投稿できない。
    @tag_names || self.tags.pluck(:name).join(' ')
  end

  def get_update_message
    self.item ? '記事を編集しました。' : '記事を投稿しました。'
  end

  def update_draft(draft_params)
    self.transaction do
      self.update!(draft_params)
      attach_tags
      if self.type == 'post'
        make_copy_to_item
        self.update!(edit_after_posting: false)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
  end

  def destroy_draft
    if self.item
      self.transaction do
        # item の内容に戻す
        self.assign_attributes(title: self.item.title, body: self.item.body, edit_after_posting: false)
        self.save!(validate: false)
        attach_tags_from_item
      end
    else
      self.destroy
    end
  end

  # TODO 関連先のitemを取得できないので用意したが、なぜ取得できないのかわからない
  def item_url
    Rails.application.routes.url_helpers.url_for(controller: :items, action: :show, screen_name: self.user.screen_name, id: self.hashid, only_path: true)
  end

  private

  def cannot_have_more_than_6_tags
    errors.add(:tag_names, 'を6つ以上紐付けることはできません。') if tag_names.split.size > 5
  end

  def cannot_have_duplicate_tags
    errors.add(:tag_names, 'を重複して紐付けることはできません。') if (tag_names.split.count - tag_names.split.uniq.count) > 0
  end

  def attach_tags
    self.tags.clear
    self.tag_names.split.each do |tag_name|
      Tag.find_or_create_by(name: tag_name).drafts << self
    end
  end

  def make_copy_to_item
    Item.make_copy(self) if self.type == 'post'
  end

  def attach_tags_from_item
    self.tags.clear
    self.item.tags.each {|tag| tag.drafts << self}
  end
end

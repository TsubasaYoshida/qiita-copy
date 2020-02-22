class Draft < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  has_one :item, dependent: :destroy
  has_and_belongs_to_many :tags

  attr_accessor :tag_names
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

  def restore_tag_names
    self.tag_names = self.tags.pluck(:name).join(' ')
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

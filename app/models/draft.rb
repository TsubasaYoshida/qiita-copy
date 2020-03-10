class Draft < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  has_one :item, dependent: :destroy
  has_and_belongs_to_many :tags

  attr_writer :tag_names
  attr_accessor :type

  after_save :attach_tags
  after_save :copy_to_item

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

  def post?
    type == 'post'
  end

  def tag_names
    # createする時、writerだけじゃなくgetterも呼ばれているため、「@tag_names || 」を使う必要がある。
    # こう書かないと、バリデーションで引っかかって投稿できない。
    @tag_names || tags.pluck(:name).join(' ')
  end

  def get_update_message
    item ? '記事を編集しました。' : '記事を投稿しました。'
  end

  def destroy_draft
    if item
      # item の内容に戻す(updated_at も揃えないと、下書き一覧にまた表示されてしまう)
      assign_attributes(
          title: item.title,
          body: item.body,
          updated_at: item.updated_at,
      )
      # type 指定していないので、バリデーション引っかかる -> validate: false を使う
      save!(validate: false)
      copy_tags_from_item
    else
      destroy
    end
  end

  private

  def cannot_have_more_than_6_tags
    errors.add(:tag_names, 'を6つ以上紐付けることはできません。') if tag_names.split.size > 5
  end

  def cannot_have_duplicate_tags
    errors.add(:tag_names, 'を重複して紐付けることはできません。') if (tag_names.split.count - tag_names.split.uniq.count) > 0
  end

  def copy_to_item
    if post?
      item = Item.find_or_initialize_by(draft_id: id)
      item.update(
          title: title,
          body: body,
          user_id: user_id,
      )
      copy_tags_to_item
    end
  end

  def attach_tags
    tags.clear
    tag_names.split.each do |tag_name|
      Tag.find_or_create_by(name: tag_name).drafts << self
    end
  end

  def copy_tags_from_item
    tags.clear
    item.tags.each {|tag| tag.drafts << self}
  end

  def copy_tags_to_item
    item.tags.clear
    # tags.each だと動かない。tags.all.each なら動く。
    tags.all.each {|tag| tag.items << item}
  end
end

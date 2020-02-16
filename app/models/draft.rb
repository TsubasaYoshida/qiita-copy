class Draft < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  has_one :item, dependent: :destroy
  has_and_belongs_to_many :tags

  attr_accessor :tag_names
  attr_accessor :type

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

  def attach_tags
    # 毎回タグをデタッチしてからアタッチし直す(タグ削除やタグ更新のため)
    self.tags.clear
    self.tag_names.split.each do |tag_name|
      Tag.find_or_create_by(name: tag_name).drafts << self
    end
  end

  def restore_tag_names
    self.tag_names = self.tags.pluck(:name).join(' ')
  end

  def destroy_draft
    if self.item
      # バリデーションスキップする必要がある
      self.assign_attributes(title: self.item.title, body: self.item.body, edit_after_posting: false)
      self.save(validate: false)

      self.tags.clear
      self.item.tags.each do |tag|
        tag.drafts << self
      end

    else
      self.destroy
    end
  end
end

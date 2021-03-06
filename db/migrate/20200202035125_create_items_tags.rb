class CreateItemsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :items_tags, id: false do |t|
      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end

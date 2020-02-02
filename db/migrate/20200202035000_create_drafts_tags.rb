class CreateDraftsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :drafts_tags, id: false do |t|
      t.references :draft, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end

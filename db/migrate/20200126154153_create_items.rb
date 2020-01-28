class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end

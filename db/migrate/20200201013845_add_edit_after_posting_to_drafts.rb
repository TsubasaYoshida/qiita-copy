class AddEditAfterPostingToDrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :drafts, :edit_after_posting, :boolean, default: false, null: false
  end
end

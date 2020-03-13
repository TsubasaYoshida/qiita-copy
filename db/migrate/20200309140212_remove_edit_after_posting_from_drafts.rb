class RemoveEditAfterPostingFromDrafts < ActiveRecord::Migration[6.0]
  def change

    remove_column :drafts, :edit_after_posting, :boolean
  end
end

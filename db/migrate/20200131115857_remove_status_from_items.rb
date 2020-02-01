class RemoveStatusFromItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :items, :status, :string
  end
end

class RemoveUnusedTables2 < ActiveRecord::Migration[5.2]
  def change
      remove_column :users, :awaiting_creator_approval?
  end
end

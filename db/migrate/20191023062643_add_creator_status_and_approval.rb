class AddCreatorStatusAndApproval < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :creator?, :boolean, default: false
      add_column :users, :awaiting_creator_approval?, :boolean, default: false
  end
end

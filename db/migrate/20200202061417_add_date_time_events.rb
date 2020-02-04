class AddDateTimeEvents < ActiveRecord::Migration[5.2]
  def change
      add_column :articles, :start_time, :datetime
      add_column :articles, :start_date, :datetime
  end
end

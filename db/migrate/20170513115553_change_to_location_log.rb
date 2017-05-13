class ChangeToLocationLog < ActiveRecord::Migration[5.1]
  def up
    change_column :location_logs, :lat, :decimal, precision: 8, scale: 6, null: false
    change_column :location_logs, :lon, :decimal, precision: 9, scale: 6, null: false
    change_column :location_logs, :accuracy, :decimal, precision: 10, scale: 6
  end
  
  def down
    change_column :location_logs, :lat, :decimal, precision: 10, null: false
    change_column :location_logs, :lon, :decimal, precision: 10, null: false
    change_column :location_logs, :accuracy, :decimal, precision: 10
  end
end

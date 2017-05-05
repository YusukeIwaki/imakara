class CreateLocationLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :location_logs do |t|
      t.references :tracking, foreign_key: true, null: false
      t.decimal :lat, null: false
      t.decimal :lon, null: false
      t.decimal :accuracy
      t.datetime :created_at, index: true
    end
  end
end

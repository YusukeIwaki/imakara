class CreateTrackings < ActiveRecord::Migration[5.1]
  def change
    create_table :trackings do |t|
      t.string :code, null: false, unique: true, limit: 64
      t.references :owner, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end

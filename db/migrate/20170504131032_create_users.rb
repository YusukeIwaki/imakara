class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gcm_token, unique: true, null: false

      t.timestamps
    end
  end
end

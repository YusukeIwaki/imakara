class ChangeUsersGcmToken < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :gcm_token, :string, null: false
  end

  def down
    change_column :users, :gcm_token, :string, unique: true, null: false
  end
end

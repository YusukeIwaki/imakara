class ChangeTrackingsCode < ActiveRecord::Migration[5.1]
  def change
    change_column :trackings, :code, :string, limit: 64, null: false, unique: true
  end
end

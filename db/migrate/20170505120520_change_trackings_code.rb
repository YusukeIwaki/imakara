class ChangeTrackingsCode < ActiveRecord::Migration[5.1]
  def up
    change_column :trackings, :code, :string, limit: 64, null: false, unique: true
    rename_column :trackings, :code, :id_code
  end

  def down
    rename_column :trackings, :id_code, :code
    change_column :trackings, :code, :string, null: false, unique: true
  end
end

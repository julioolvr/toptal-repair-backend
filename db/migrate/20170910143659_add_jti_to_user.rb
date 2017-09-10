class AddJtiToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :jti, :string
    change_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end

  def down
    remove_index :users, :jti
    remove_column :users, :jti
  end
end

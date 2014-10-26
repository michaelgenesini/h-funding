class RemovePassword < ActiveRecord::Migration
  def change
    add_column :users, :password
  end
end

class RemoveUse < ActiveRecord::Migration
  def up
    drop_table :use
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end


end

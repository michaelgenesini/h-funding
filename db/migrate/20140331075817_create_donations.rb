class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.datetime :date
      t.references :campaign, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

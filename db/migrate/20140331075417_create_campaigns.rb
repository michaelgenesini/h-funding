class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.text :description
      t.datetime :date_start
      t.datetime :date_end
      t.string :type
      t.boolean :status
      t.integer :collected
      t.boolean :goal
      t.string :items
      t.references :user, index: true

      t.timestamps
    end
  end
end

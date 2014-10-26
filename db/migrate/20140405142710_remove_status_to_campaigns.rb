class RemoveStatusToCampaigns < ActiveRecord::Migration
  def change
  	remove_column :campaigns, :status
  end
end

class RemoveItemsAndTypeInCampaigns < ActiveRecord::Migration
  def change
  	remove_column :campaigns, :type
  	remove_column :campaigns, :items
  end
end

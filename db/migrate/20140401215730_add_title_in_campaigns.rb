class AddTitleInCampaigns < ActiveRecord::Migration
  def change
  	add_column :campaigns, :title, :string
  end
end

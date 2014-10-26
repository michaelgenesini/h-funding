class ChangeGoalFormatInCampaigns < ActiveRecord::Migration
  def self.up
   change_column :campaigns, :goal, :integer
  end

  def self.down
   change_column :campaigns, :goal, :boolean
  end
end

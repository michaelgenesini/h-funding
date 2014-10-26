class Donation < ActiveRecord::Base
  
	attr_accessible :description, :user_id, :date, :amount, :campaign_id

	validates :amount, presence: true,
			   numericality: { only_integer: true,
					   greater_than: 0,
					   less_than: 10000
				         }
	validates :user_id, presence: true
	validates :campaign_id, presence: true


	belongs_to 	:campaign
	belongs_to 	:user
	has_many 	:uses


	def self.mine(user_id)
	  where('user_id = ?', user_id)
	end
	
end

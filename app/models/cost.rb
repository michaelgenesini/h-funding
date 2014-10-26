class Cost < ActiveRecord::Base

	attr_accessible :name, :amount, :goal, :campaign_id


	validates :name, presence: true,
			 length: { in: 0..40 }
	validates :amount, presence: true,
			  numericality: { only_integer: true,
					  greater_than: 0,
					  less_than: 100000
				        }
	validates :campaign_id, presence: true


	belongs_to	 :campaign
	has_many	 :uses
	
end

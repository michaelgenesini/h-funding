module CampaignsHelper

	def campaign_status(campaign)
		if Campaign.campaign_status(campaign)
			return "Open"
		else
			return "Closed"
		end
	end

	def number_of_donations(campaign)
		Campaign.number_of_donations(campaign)
	end

	def number_of_costs(campaign)
		Campaign.number_of_costs(campaign)
	end

	def amount_of_donations(campaign)
		Campaign.amount_of_donations(campaign)
	end

	def amount_of_costs(campaign)
		Campaign.amount_of_costs(campaign)
	end

	def perc_of_complete(campaign)
		totale = Campaign.amount_of_donations(campaign)
    	@perc = (totale*1.0 / campaign.goal * 100).round(0)
	end

	def days_left(campaign)
		Campaign.days_left(campaign)
	end

	def campaign_complete?(campaign)
		Campaign.campaign_complete?(campaign)
	end

	def started?(campaign)
		Campaign.started?(campaign)
	end

	def terminated?(campaign)
		Campaign.terminated?(campaign)
	end

	def campaign_owner_name(campaign)
		User.campaign_owner_name(campaign)
	end

	def donation_owner_name(donation)
		User.donation_owner_name(donation)
	end

	def get_data_for_areachart(campaign)
		Campaign.get_data_for_areachart(campaign)
	end

end

module UsersHelper

	def number_of_campaigns(user)
		User.number_of_campaigns(user)
	end

	def number_of_donations_for_user(user)
		User.number_of_donations_for_user(user)
	end

	def name_of_campaign_for_donation(donation)
		Campaign.name_of_campaign_for_donation(donation)
	end
end

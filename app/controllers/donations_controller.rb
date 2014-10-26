class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

	def index
		# poi lo tolgo
		@donations = Donation.all
	end

	def mine
		if not signed_in?
			redirect_to signin_path
		else
			@donations = Donation.mine(current_user.id)
			render 'mine'
		end
	end

	def show
		@donation = Donation.new
	end

	def new
		if not signed_in? 
			flash['alert alert-warning'] = 'Please signin before donate.'
			redirect_to signin_path
		else
			if Campaign.all.count > 0
				@donation = Donation.new
				if params[:campaign_id]
					@campaign = Campaign.find(params[:campaign_id])
				end
			end
		end
	end

	def edit
		redirect_to root_path
	end

	def create
		
		@campaign = Campaign.find(params[:campaign_id])

		if (current_user.money.to_i > params[:donation][:amount].to_i)

			if  Campaign.campaign_status(@campaign)

				@donation = Donation.new(donation_params)
				@donation.user_id = current_user.id    
				
				@donation.campaign_id = params[:campaign_id]
				@donation.date = Time.now

				current_user.money = current_user.money - params[:donation][:amount].to_i
				current_user.save

				if @donation.save
					flash['alert alert-success'] = 'Thanks for your donation.'
					redirect_to @campaign
				else
					flash['alert alert-danger'] = 'Sorry! Server error.'
					redirect_to @campaign
				end
			else
				flash['alert alert-danger'] = 'This campaign is closed.'
				redirect_to @campaign
			end
		else
			flash['alert alert-danger'] = 'You don t have money.'
			redirect_to @campaign
		end
	end

	def update
		if @donation.update(donation_params)
			redirect_to @donation, notice: 'Donation was successfully updated.'
		else
			render action: 'edit'
		end
	end

	def destroy
		@donation.destroy
		redirect_to donations_url
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_donation
			@donation = Donation.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def donation_params
			params.require(:donation).permit(:amount, :campaign_id, :date)
		end
end

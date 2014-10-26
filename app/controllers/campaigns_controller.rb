class CampaignsController < ApplicationController
  
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  helper CampaignsHelper

  def index
    @campaigns = Campaign.all
  end

   def discover
    @campaigns = Campaign.open.order('date_end')
    render 'discover'
  end

  def mine
    if not signed_in?
     redirect_to signin_path
    else
      @campaigns = Campaign.mine(current_user.id)
      render 'mine'
    end
  end

  def new
    if not signed_in?
      flash['alert alert-warning'] = 'You must to be signed in to create a new campaign.'
      redirect_to signin_path
    end
    @users = User.all
    @campaign = Campaign.new
  end

  def show
    @donations = Donation.where(campaign_id: params[:id])
    @campaign = Campaign.find(params[:id])
    totale = Campaign.amount_of_donations(@campaign)
    @perc = totale*1.0 / @campaign.goal * 100
  end

  def edit
    is_owner
    @campaign
  end

  def create
    
      @campaign = Campaign.new(campaign_params)

      @campaign.user_id = current_user.id

      if @campaign.save
        flash['alert alert-success'] = 'Campaign was successfully created.'
        redirect_to @campaign
      else
        flash['alert alert-danger'] = 'Campaign creation error.'
        render action: 'new'
      end
  end

  def update
    if @campaign.update(campaign_params)
      flash['alert alert-success'] = 'Campaign was successfully updated.'
      redirect_to @campaign
    else
      flash['alert alert-danger'] = 'Campaign update error.'
      render action: 'edit'
    end
  end

  def destroy
    is_owner
    @campaign.destroy
    flash['alert alert-success'] = 'Campaign was successfully deleted.'
    redirect_to mine_campaigns_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:user_id, :title, :description, :date_start, :date_end, :goal)
    end

    def is_owner
      if not(signed_in?) or not(@campaign.user_id == current_user.id)
        flash['alert alert-danger'] = 'You must to be the owner of this campaign.'
        redirect_to @campaign
      end
    end

end

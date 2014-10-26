class CostsController < ApplicationController

  before_action :set_costs, only: [:show, :edit, :update, :destroy]

  def index
    
  end

  def show
   
  end

  def new
    
  end

  def edit
    
  end

  def create
    @cost = Cost.new(cost_params)
    @campaign = Campaign.find(@cost.campaign_id)

    unless params[:cost][:amount].to_i > (Campaign.amount_of_donations(Campaign.find(@cost.campaign_id)) - Campaign.amount_of_costs(Campaign.find(@cost.campaign_id)))
      
      if @cost.save
        flash.now['alert alert-success'] = 'Cost was successfully created.'
    		redirect_to @campaign
    	else
        flash.now['alarm alarm-danger'] = 'Errore nel server!'
    		redirect_to @campaign
    	end
    else
      flash['alert alert-danger'] = 'Costs are more than donations.' 
      redirect_to @campaign
    end
  end

  def update
    if @cost.update(cost_params)
      flash.now['alarm alarm-success'] = 'Cost was successfully updated.'
		  redirect_to @cost
	else
		render action: 'edit'
    end
  end

 def destroy
    @cost.destroy
    flash.now['alarm alarm-success'] = 'Cost was successfully destroyed.'
    redirect_to costs_url
  end


	private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_cost
	      @cost = Cost.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def cost_params
	      params.require(:cost).permit(:name, :amount, :campaign_id)
	    end
end

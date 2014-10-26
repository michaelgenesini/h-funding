class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  helper UsersHelper

  def index
    @users = User.all
  end

  def show

    if not current_user.nil? and current_user.id == params[:id].to_i
      @campaigns = Campaign.mine(current_user.id).order('date_end')
      @donations = Donation.mine(current_user.id).order('created_at')
    else
      @campaigns = Campaign.where(user_id: params[:id].to_i)
      @donations = Donation.where(user_id: params[:id].to_i)
    end
  end

  def new
    @user = User.new
  end

  def charge
    if not signed_in?
     redirect_to signin_path
    else
      @user = User.new
      render 'charge'
    end
  end

  def edit
    if not signed_in? or not (@user.id==current_user.id)
      flash.now['alert alert-danger'] = 'You don`t have permission'
      render 'new'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      redirect_to root_url, :notice => "Signed up!"
    else
      render 'new'
    end
  end

  def update_money
    user = User.find(current_user.id)
    charge = params[:user][:money].to_i
    money = user.money.to_i + charge
    if user.update_attribute(:money,money)
      redirect_to user, notice: 'User was successfully updated.'
    else
      render action: 'show'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if not signed_in? or not (@user.id==current_user.id)
      flash.now['alert alert-danger'] = 'You don`t have permission to delete this account.'
      redirect_to @user
    end
    @user.destroy
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :mail, :password, :password_confirmation, :money)
    end
end

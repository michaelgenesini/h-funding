module SessionsHelper

  def sign_in(user)
    p user
    session[:user_id] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
		cookies.delete(:remember_token)
	end

end

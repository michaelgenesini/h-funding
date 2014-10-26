class UserMailer < ActionMailer::Base
  default from: "notification@h-funding.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.mail, subject: 'Welcome to My Awesome Site')
  end

end

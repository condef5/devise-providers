class UserMailer < ApplicationMailer
  default from: 'lucia@fakeflix.com'

  def user_registered
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome New User")
  end

end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Facebook")
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub')
    else
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Twitter')
    else
      session['devise.twitter_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def instagram
    nickname = request.env['omniauth.auth'].info.nickname
    request.env['omniauth.auth']["info"]["email"] = "#{nickname}@gmail.com"
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Instagram')
    else
      session['devise.instagram_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
end

  def failure
    redirect_to root_path
  end
end

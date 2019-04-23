class SerieMailer < ApplicationMailer
  default from: 'lucia@fakeflix.com'

  def serie_created
    @user = params[:user]
    @serie = params[:serie]
    mail(to: @user.email, subject: 'New serie created')
  end

  def serie_updated
    @user = params[:user]
    @serie = params[:serie]
    mail(to: @user.email, subject: 'serie updated')
  end

  def serie_deleted
    @user = params[:user]
    @serie = params[:serie]
    mail(to: @user.email, subject: 'serie deleted')
  end
end

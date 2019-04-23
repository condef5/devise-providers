class User < ApplicationRecord
  has_many :providers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github twitter google_oauth2 instagram]

  after_create :send_mail
  
  def send_mail
    UserMailer.with(user: self).user_registered.deliver_now
  end

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.role = "regular"
      user.password = Devise.friendly_token[0, 20]
    end
    provider = Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user.id)
    user
  end

  def admin?
    self.role == "admin"
  end

  def regular?
    self.role == "regular"
  end
  
end

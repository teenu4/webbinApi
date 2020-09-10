class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  devise :database_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  self.skip_session_storage = [:http_auth, :params_auth]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data['name'],
                         email: data['email'],
                         # password: Devise.friendly_token[0, 20],
                         platform: 'GOOGLE'
      )
    end
    user
  end

  def token
    headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
    }
    scope ||= Devise::Mapping.find_scope!(self)
    aud ||= headers[Warden::JWTAuth.config.aud_header]
    token, payload = Warden::JWTAuth::UserEncoder.new.call(
        self, scope, aud
    )
    token
  end
end

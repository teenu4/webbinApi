class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in(:user, @user)
      user_data = {
          token: @user.token,
          name: @user.name,
          email: @user.email
      }
      messages = Rails.application.credentials.front_urls.
          map { |url| "window.opener.postMessage('#{user_data.to_json}','#{url}');" }.join
      render inline: "<script>#{messages}window.close();</script>", content_type: 'text/html'
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      render inline: '<script>alert("Can\'t login!");window.close();</script>', content_type: 'text/html'
    end

  end
end
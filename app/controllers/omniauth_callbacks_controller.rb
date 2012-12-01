class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(request.env["omniauth.auth"])
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    user.token = token
    user.secret = secret
    # raise user.to_yaml
    # raise request.env["omniauth.auth"].to_yaml
    
    
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all
end

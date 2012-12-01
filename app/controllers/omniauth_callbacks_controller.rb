class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(request.env["omniauth.auth"])
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    current_user.token = token
    current_user.secret = secret
    # raise user.to_yaml
    # raise request.env["omniauth.auth"].to_yaml
    
    if current_user.save
    else
      raise user.to_yaml
    end
    
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

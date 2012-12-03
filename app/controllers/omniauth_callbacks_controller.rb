class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(request.env["omniauth.auth"])
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    current_user.token = token
    current_user.secret = secret
    #different cases when already logged in
    # raise secret
    # raise token
    # raise request.env["omniauth.auth"].to_yaml
    puts "in oauth secret: " + current_user.secret
    if current_user.save!
    else
      raise user.to_yaml
    end
    
    # if user.persisted?
      flash.notice = "Signed in!"
      # redirect_to 'localhost:3000/home'
      # sign_in_and_redirect user
    # else
    #   session["devise.user_attributes"] = user.attributes
      # redirect_to new_user_registration_url
      redirect_to 'home/index'
    # end
  end
  alias_method :twitter, :all
end

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    
    auth = request.env['omniauth.auth']
    # raise (current_user.twitter_id).to_yaml
    if current_user.twitter_id != auth['uid']
      Tweet.delete_all
      current_user.twitter_id = auth['uid']
    end
    user = User.from_omniauth(request.env["omniauth.auth"])
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    current_user.token = token
    current_user.secret = secret
    if current_user.save!
    else
      raise user.to_yaml
    end
    
      flash.notice = "Signed in!"
      redirect_to '/home/index'
  end
  
  #This would allow adding of other accounts (Facebook etc.)
  #Might need changing though, all is too specific
  alias_method :twitter, :all
end

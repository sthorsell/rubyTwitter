class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    
    auth = request.env['omniauth.auth']
    auth.token = auth['credentials']['token']
    auth.secret = auth['credentials']['secret']
    if current_user.twitter_id != auth['uid']
      current_user.tweets.delete_all
      current_user.twitter_id = auth['uid']
    end
    user = User.from_omniauth(request.env["omniauth.auth"])
    current_user.token = auth.token
    current_user.secret = auth.secret
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

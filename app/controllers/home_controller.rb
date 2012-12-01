class HomeController < ApplicationController
  def index
    
    if user_signed_in?
    consumer = OAuth::Consumer.new("rRySeVVxnS5hxxXE3KmoQ", "TXFQGdof1swkt1gsohwlW0KwwGloA9YgWiUv7i770",
        { :site => "http://api.twitter.com",
          :scheme => :header
        })
      # now create the access token object from passed values
      token_hash = { :oauth_token => current_user.token,
                     :oauth_token_secret => current_user.secret
                   }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      
      response = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")
      current_user.tweets = response.body
    end 
  end
end

class HomeController < ApplicationController
  @@period = 'all'
 
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
      # raise current_user.tweets.past_week.to_yaml
      
      response = access_token.request(:get, "http://api.twitter.com/1.1/statuses/user_timeline.json")
      # raise response.body.to_yaml
      if response.code != '401' && response.code != '400'

      JSON.parse(response.body).each do |i|
        if !Tweet.exists?(["twitter_id = ?", i['id_str']])
        t = Tweet.new
        t.description = i['text']
        t.twitter_id = i['id_str']
        t.date_tweeted =  Time.parse(i['created_at'])
        current_user.tweets << t
        # current_user.current_tweets << t
        # current_user.stereo_info << t
      end
        # raise current_user.tweets.to_yaml
        
      end
      if @@period == 'all'
        # raise 'here'.to_yaml
        @tweetsToDisplay = current_user.tweets
       else
         methodName = 'past_' + @@period
          @tweetsToDisplay = current_user.tweets.send(methodName)
       end
       
      current_user.save!
    end
    end 
  end
  
  def display
     value = params[:time_id]
     @@period  = value
     redirect_to '/home/index'
       # raise current_user.current_tweets.to_yaml
  end
end

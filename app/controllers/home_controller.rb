class HomeController < ApplicationController
  @@period = 'all'
  
  class CreateConsumers
    include HomeHelper
    #Could easily generate consumer methods for Facebook, LinkedIn, etc here
      consumer([['twitter', 'http://api.twitter.com']])
  end
  def index

    if user_signed_in?
      m = CreateConsumers.new
      consumer = m.get_consumer_from_twitter
      # now create the access token object from passed values
      token_hash = { :oauth_token => current_user.token,
        :oauth_token_secret => current_user.secret
      }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      
        #Good opporunity for MetaProgramming, pass hash of parameters
        url = ''
        if current_user.tweets.count > 0
          url = "http://api.twitter.com/1.1/statuses/user_timeline.json?since_id=#{Tweet.first.twitter_id}"
        else
          url = "http://api.twitter.com/1.1/statuses/user_timeline.json"
        end
        response = access_token.request(:get, url)
        if response.code != '401' && response.code != '400'

          JSON.parse(response.body).each do |i|
            if !current_user.tweets.exists?(["twitter_id = ?", i['id_str']])
              t = Tweet.new
              t.description = i['text']
              t.twitter_id = i['id_str']
              t.date_tweeted =  Time.parse(i['created_at'])
              current_user.tweets << t
            end

          end
          if @@period == 'all'
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
    end
  end

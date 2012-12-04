class Tweet < ActiveRecord::Base
  attr_accessible :date, :description, :twitter_id, :date_tweeted
  belongs_to :user

  #MetaProgramming example, create method for each time period and return tweets from it. 
  
  TIMES = [['week' , Time.now() - (2*24*60*60)],['month' , Time.now() - (4*7*24*60*60)], ['year' , Time.now() - (12*4*7*24*60*60)]]

  class << self
    TIMES.each do |time|
      define_method "past_#{time[0]}" do
        # define_method "all_week" do
        find(:all, :conditions => ["date_tweeted between ? AND ?", time[1], Time.now()])
      end
    end
  end

end

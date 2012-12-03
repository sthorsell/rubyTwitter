class Tweet < ActiveRecord::Base
  attr_accessible :date, :description, :twitter_id
  belongs_to :user
end

class Tweet < ActiveRecord::Base
  attr_accessible :date, :description
  belongs_to :user
end

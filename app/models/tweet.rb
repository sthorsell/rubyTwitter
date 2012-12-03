class Tweet < ActiveRecord::Base
  attr_accessible :date, :description, :twitter_id, :date_tweeted
  belongs_to :user
  
  STATUSES = [['week' , Time.now() - (7*24*60*60)],['month' , Time.now() - (4*7*24*60*60)], ['year' , Time.now() - (12*4*7*24*60*60)]]
   # validate_inclusion_of :status, :in => STATUSES

   class <<self
     STATUSES.each do |status_name|
       define_method "past_#{status_name[0]}" do
       # define_method "all_week" do
         find(:all, :conditions => ["date_tweeted between ? AND ?", status_name[1], Time.now()])
       end
     end
   end
   
end

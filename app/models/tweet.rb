class Tweet < ActiveRecord::Base
  attr_accessible :date, :description, :twitter_id
  belongs_to :user
  
  STATUSES = [Time.now() - (7*24*60*60)]
   # validate_inclusion_of :status, :in => STATUSES

   class <<self
     STATUSES.each do |status_name|
       # define_method "all_#{status_name}" do
       define_method "all_week" do
         find(:all, :conditions => [" created_at between ? AND ?", status_name, Time.zone.now])
       end
     end
   end
   
end

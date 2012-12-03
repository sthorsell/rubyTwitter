class AddDateTweetedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :date_tweeted, :string
  end
end

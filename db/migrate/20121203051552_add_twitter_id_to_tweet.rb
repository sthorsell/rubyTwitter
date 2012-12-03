class AddTwitterIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_id, :integer
  end
end

class ChangeTweetIdFormatInTweet < ActiveRecord::Migration
  def up
	change_column :tweets, :twitter_id, :string
  end

  def down
  end
end

class AddCurrentTweetsToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_tweets, :string
  end
end

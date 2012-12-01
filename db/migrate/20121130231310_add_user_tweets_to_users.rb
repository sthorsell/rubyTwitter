class AddUserTweetsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tweets, :string
  end
end

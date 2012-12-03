class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :date
      t.string :description

      t.timestamps
    end
  end
end

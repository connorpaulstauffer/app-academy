class AddUpvotesAndDownvotesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :upvotes, :integer
    add_column :comments, :downvotes, :integer
  end
end

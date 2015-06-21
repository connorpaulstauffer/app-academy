class AddUpvotesAndDownvotesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :upvotes, :integer
    add_column :articles, :downvotes, :integer
  end
end

class ChangeDefaultVoteValuesForArticles < ActiveRecord::Migration
  def change
    change_column :articles, :upvotes, :integer, default: 0
    change_column :articles, :downvotes, :integer, default: 0
  end
end

class RemoveAuthorNameFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :author_name, :string
  end
end

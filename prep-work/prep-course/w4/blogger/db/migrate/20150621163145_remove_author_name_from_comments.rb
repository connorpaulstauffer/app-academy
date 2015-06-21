class RemoveAuthorNameFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :author_name, :string
  end
end

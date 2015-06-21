class AddAuthorRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :author, index: true
  end
end
class AddParentRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :parent, index: true
  end
end

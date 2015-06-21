class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :course, index: true, foreign_key: true
      t.integer :block
      t.string :day
    end
  end
end

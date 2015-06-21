class Session < ActiveRecord::Base
  belongs_to :course
  validates :course, presence: true
  validates :block, presence: true
  validates :day, presence: true
end

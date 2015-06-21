class Course < ActiveRecord::Base
  has_many :sessions
  validates :name, presence: true
  validates :department, presence: true
  validates :credits, presence: true
end

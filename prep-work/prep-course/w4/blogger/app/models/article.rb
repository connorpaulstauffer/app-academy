class Article < ActiveRecord::Base

  acts_as_taggable

  has_many :comments
  belongs_to :author

  default_scope -> { order(created_at: :desc) }

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => [
                                                               "image/jpg",
                                                               "image/jpeg",
                                                               "image/png"
                                                              ]

  def root_comments
    self.comments.select { |comment| comment.parent.nil? }
  end

end

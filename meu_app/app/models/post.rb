class Post < ApplicationRecord
  validates :title, uniqueness:  true
  has_many :comments, dependent: :destroy
end

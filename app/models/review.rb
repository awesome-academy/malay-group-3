class Review < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :content, presence: true

  has_rich_text :content
end

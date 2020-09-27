class Course < ApplicationRecord
  enum status: { opening: 0, started: 1, finished: 2 }
  
  has_many :reviews, dependent: :destroy
  has_many :registers, dependent: :destroy
  
  scope :recent_courses, ->{order created_at: :desc}

  after_initialize do
    self.status ||= :opening if self.new_record?
  end

  validates :name, presence: true,
    length: { maximum: Settings.validations.course.course_name_max_length },
    uniqueness: true

  has_rich_text :description
end

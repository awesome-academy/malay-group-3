class AddCourseIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :course_id, :integer
  end
end

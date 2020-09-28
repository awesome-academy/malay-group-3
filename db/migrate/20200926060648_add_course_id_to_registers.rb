class AddCourseIdToRegisters < ActiveRecord::Migration[6.0]
  def change
    add_column :registers, :course_id, :integer
  end
end

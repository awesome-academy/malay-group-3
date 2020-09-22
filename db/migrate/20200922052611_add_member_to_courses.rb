class AddMemberToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :member, :integer
  end
end

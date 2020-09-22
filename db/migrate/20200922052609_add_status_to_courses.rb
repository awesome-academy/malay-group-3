class AddStatusToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :status, :integer
  end
end

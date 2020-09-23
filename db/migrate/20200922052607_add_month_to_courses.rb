class AddMonthToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :total_month, :integer
  end
end

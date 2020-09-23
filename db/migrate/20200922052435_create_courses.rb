class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.datetime :started_at

      t.timestamps
    end
  end
end

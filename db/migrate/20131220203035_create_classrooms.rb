class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :course_id
      t.integer :teacher_id
      t.text :description
      t.integer :period

      t.timestamps
    end
  end
end

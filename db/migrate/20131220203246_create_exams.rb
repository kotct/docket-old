class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.integer :classroom_id

      t.timestamps
    end
  end
end

class ChangeDateToDateInExams < ActiveRecord::Migration
	def change
		change_column :exams, :date, :date
	end
end

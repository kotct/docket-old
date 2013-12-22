class ChangeDueDateToDateInAssignments < ActiveRecord::Migration
	def change
		change_column :assignments, :due_date, :date
	end
end

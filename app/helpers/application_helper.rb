module ApplicationHelper
	PRINT_DEBUG_STRINGS = true

	def relevant_date(thing)
		case
		when thing.class == Assignment
			thing.due_date
		when thing.class == Exam
			thing.date
		when thing.class == Event
			thing.date
		else
			throw "That's not a assignment or exam, its a " + thing.class.to_s
			Date.new(1970, 1, 1)
		end
	end

	def current_user
		if session["current_user_id"]
			begin
				user_find = User.find session["current_user_id"]
			rescue Exception => e
				puts "Exception occurred (#{e.message})"

				nil
			end

			user_find
		else
			nil
		end
	end

	def generate_glyphicon(spclass = "", glyphicon_name)
		content_tag(:span, :class => "#{spclass} glyphicon glyphicon-#{glyphicon_name}") do
		end
	end

	def get_day_array(start_date = Date.today, expanse_of_time = :week)
		puts "Starting day string get (start_date = #{start_date}, expanse_of_time = #{expanse_of_time})" if PRINT_DEBUG_STRINGS

		desired_number_of_days = 0

		case expanse_of_time
		when :week
			desired_number_of_days = 7
		when :month
			desired_number_of_days = (6 * 7)
		when :day
			desired_number_of_days = 1
		end

		puts "Desired number of days: #{desired_number_of_days}" if PRINT_DEBUG_STRINGS

		days = []

		for i in (0..(desired_number_of_days - 1))
			day = start_date + i.days

			puts "Adding date: #{start_date + i.days}" if PRINT_DEBUG_STRINGS

			days << day
		end

		puts "Returning array with length #{days.count}" if PRINT_DEBUG_STRINGS

		return days
	end
end

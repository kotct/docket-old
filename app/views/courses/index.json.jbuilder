json.array!(@courses) do |course|
  json.extract! course, :id, :name, :description, :course_number
  json.url course_url(course, format: :json)
end

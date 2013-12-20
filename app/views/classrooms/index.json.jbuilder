json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :course_id, :teacher_id, :description, :period
  json.url classroom_url(classroom, format: :json)
end

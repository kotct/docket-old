json.array!(@exams) do |exam|
  json.extract! exam, :id, :name, :description, :date, :classroom_id
  json.url exam_url(exam, format: :json)
end

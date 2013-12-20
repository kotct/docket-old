json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name, :description, :due_date, :classroom_id
  json.url assignment_url(assignment, format: :json)
end

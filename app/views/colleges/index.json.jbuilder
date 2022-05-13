json.array!(@colleges) do |college|
  json.id college.id
  json.name college.name
  json.neighborhood college.neighborhood
end
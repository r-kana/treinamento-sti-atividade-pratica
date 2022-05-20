json.array!(@users) do |user|
  json.name user.name
  json.iduff user.iduff
end
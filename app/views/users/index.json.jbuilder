json.array!(@users) do |user|
  json.name user.name
  json.cpf user.cpf
end
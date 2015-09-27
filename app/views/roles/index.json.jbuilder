json.array!(@roles) do |role|
  json.extract! role, :id, :name, :roleType, :race, :description
  json.url role_url(role, format: :json)
end

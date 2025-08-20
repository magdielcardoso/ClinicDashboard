json.extract! client, :id, :first_name, :last_name, :email, :phone, :created_at, :updated_at
json.url client_url(client, format: :json)

json.extract! appointment, :id, :client_id, :procedure_id, :user_id, :scheduled_at, :status, :notes, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)

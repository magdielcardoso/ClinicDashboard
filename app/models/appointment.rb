class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :procedure
  belongs_to :user
end

class DashboardController < ApplicationController
  def index
  end

  def calendar
    @appointments = Appointment.includes(:client, :procedure).order(created_at: :desc)
  end
end

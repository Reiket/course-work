class Doctor::StatisticsController < Doctor::ApplicationController
  def index
    @doctor = Doctor.find_by(user_id: current_user.id)
    @doctor.refresh_satisfied_clients
    @ratings = @doctor.ratings
  end
end

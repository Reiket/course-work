class Doctor::ProfilesController < Doctor::ApplicationController
  def index
    @doctor = Doctor.find_by(user_id: current_user.id)
  end
end

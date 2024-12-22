class Doctor::AppointmentsController < Doctor::ApplicationController
  def index
    doctor = Doctor.find_by(user_id: current_user.id)
    @appointments = Appointment.where(doctor_id: doctor.id)
    @appointments.each do |appointment|
      appointment.timeout_check
    end

    @appointments_pending = @appointments.unvisited.where(status: 'pending')
    @appointments_confirmed = @appointments.unvisited.where(status: 'confirmed')
  end

  def confirm_appointment
    @appointment = Appointment.find(params[:id])
    if @appointment.working_hour.nil?
      @appointment.destroy

      respond_to do |format|
        format.html { redirect_to doctor_appointments_path, notice: 'Ви видалили таку робочу годину, щось пішло не так!' }
      end
      else
      @appointment.update(status: 'confirmed')

      respond_to do |format|
        format.html { redirect_to doctor_appointments_path, notice: 'Ви успішно підтвердили запит!' }
      end
    end
  end
end

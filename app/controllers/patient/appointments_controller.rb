class Patient::AppointmentsController < Patient::ApplicationController
  def index
    patient = Patient.find_by(user_id: current_user.id)
    @appointments = Appointment.where(patient_id: patient.id)
    @appointments.each do |appointment|
      appointment.timeout_check
    end

    @appointments_pending = @appointments.unvisited.where(status: 'pending')
    @appointments_confirmed = @appointments.unvisited.where(status: 'confirmed')
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to patient_appointments_path, notice: 'Ви скасували запис!' }
    end
  end
end

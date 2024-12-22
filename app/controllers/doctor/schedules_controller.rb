class Doctor::SchedulesController < Doctor::ApplicationController
  def index
    doctor = Doctor.find_by(user_id: current_user.id)
    @schedule = Schedule.find_by(doctor_id: doctor.id)
    @working_days = WorkingDay.where(schedule_id: @schedule.id).order(:priority)
    @working_hour = WorkingHour.new
  end

  def change_status_day
    working_day = WorkingDay.find(params[:id])
    working_day.toggle_status

    respond_to do |format|
      format.html { redirect_to doctor_schedules_path, notice: 'Ви успішно змінили статус дня!' }
    end
  end
end

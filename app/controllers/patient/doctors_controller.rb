class Patient::DoctorsController < Patient::ApplicationController
  before_action :set_variables!, only: %i[show]
  before_action :update_schedule, only: %i[show]
  before_action :set_doctor_for_rating, only: %i[create_rating edit_rating]

  def index
    @doctors = Doctor.all
    @most_reviewed_doctor = Doctor.joins(:ratings).group('doctors.id').order('COUNT(ratings.id) DESC').first
    @best_rated_doctor = Doctor.joins(:ratings).group('doctors.id').order('AVG(ratings.score) DESC').first
  end

  def show; end

  def create_appointment
    patient = Patient.find_by(user_id: current_user.id)
    working_hour = WorkingHour.find(params[:working_hour_id])

    appointment_params = {
      doctor_id: params[:doctor_id],
      patient_id: patient.id,
      working_hour_id: working_hour.id,
      status: 'pending',
      time: working_hour.hour
    }
    appointment = Appointment.new(appointment_params)

    if appointment.save
      respond_to do |format|
        format.html { redirect_to patient_appointments_path, notice: 'Ви успішно записались на прийом!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to patient_doctor_path(params[:doctor_id]),
                                  alert: 'Вам не вдалось записатись на прийом!' }
      end
    end
  end

  def create_rating
    @rating = Rating.new(rating_params)

    if @rating.save
      respond_to do |format|
        format.html { redirect_to patient_doctor_path(@doctor.id), notice: 'Дякую вам, що оцінили лікаря!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to patient_doctor_path(p@doctor.id),
                                  alert: 'Вибачте, щось пішло не так! Перевірте дані!' }
      end
    end
  end

  def edit_rating
    @rating = Rating.find(params[:id])

    if @rating.update(rating_params)
      respond_to do |format|
        format.html {
          redirect_to patient_doctor_path(@doctor.id), notice: 'Ви успішно змінили свою оцінку про лікаря!'
        }
      end
    else
      respond_to do |format|
        format.html {
          redirect_to patient_doctor_path(@doctor.id), alert: 'Вибачте, щось пішло не так! Перевірте дані!'
        }
      end
    end
  end

  private

  def set_variables!
    @doctor = Doctor.find(params[:id])
    @schedule = Schedule.find_by(doctor_id: @doctor.id)
    @working_days = WorkingDay.where(schedule_id: @schedule.id).order(:priority)
    @rating = Rating.new
    @own_rating = Rating.find_by(doctor_id: @doctor.id, patient_id: current_user.patient.id)
    @ratings = @doctor.ratings
  end

  def update_schedule
    @working_days.each do |day|
      day.working_hours.each do |hour|
        hour.hour_passed
      end
    end
  end

  def set_doctor_for_rating
    @doctor = Doctor.find(params[:rating][:doctor_id])
  end

  def rating_params
    params.require(:rating).permit(:doctor_id, :patient_id, :score, :review).merge(patient_id: current_user.patient.id)
  end
end

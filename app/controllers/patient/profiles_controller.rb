class Patient::ProfilesController < Patient::ApplicationController
  before_action :set_patient, only: %i[index update]

  def index; end

  def update
    if @patient.update(patient_params)
      respond_to do |format|
        format.html { redirect_to patient_profiles_path, notice: 'Профіль успішно оновлено!' }
        format.turbo_stream do
          flash.now[:notice] = 'Профіль успішно оновлено!'
          render turbo_stream: [
            turbo_stream.replace(@patient, partial: 'patient/profiles/form'),
            turbo_stream.append('flash_message', partial: 'shared/flash')
          ]
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to patient_profiles_path, alert: 'Профіль не оновлено! Перевірте ваші дані!' }
        flash.now[:alert] = 'Профіль не оновлено! Перевірте ваші дані!'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@patient, partial: 'patient/profiles/form'),
          ]
        end
      end
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :surname, :photo, :birthday, :residence, :phone_number, :gender, :user_id)
  end

  def set_patient
    @patient = Patient.find_by(user_id: current_user.id)
  end
end

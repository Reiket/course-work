class PatientRegistrationController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patient_profiles_path, notice: 'Ви успішно зареєструвались!'
    else
      redirect_to new_patient_registration_path, alert: 'Не правильно введено дані!'
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :surname, :photo, :birthday,
                                    :residence, :phone_number, :gender, :user_id).merge(user_id: current_user.id)
  end
end

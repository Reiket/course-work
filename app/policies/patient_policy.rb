class PatientPolicy < ApplicationPolicy
  def access_patient_panel?
    user.patient_role?
  end
end

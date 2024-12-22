class DoctorPolicy < ApplicationPolicy
  def access_doctor_panel?
    user.doctor_role?
  end
end

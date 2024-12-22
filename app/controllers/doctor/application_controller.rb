class Doctor
  class ApplicationController < ActionController::Base
    before_action :authorize_doctor_panel!
    add_flash_types :success, :info, :error, :warning
    layout 'doctor/layouts/application'

    include Pundit

    private

    def authorize_doctor_panel!
      if current_user.nil?
        flash[:alert] = "Доступ заборонений! Будь ласка, авторизуйтесь!"
        redirect_to root_path
      else
        if current_user.doctor_role?
          authorize :doctor, :access_doctor_panel?
        else
          flash[:alert] = "Доступ заборонений! Будь ласка, авторизуйтесь!"
          redirect_to root_path
        end
      end
    end
  end
end

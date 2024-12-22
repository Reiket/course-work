# frozen_string_literal: true

class Patient
  class ApplicationController < ActionController::Base
    before_action :authorize_patient_panel!
    add_flash_types :success, :info, :error, :warning

    layout 'patient/layouts/application'

    include Pundit

    private

    def authorize_patient_panel!
      if current_user.nil?
        flash[:alert] = "Доступ заборонений! Будь ласка, авторизуйтесь або пройдіть реєстрацію для користувача!"
        redirect_to root_path
      else
        if current_user.patient_role?
          authorize :patient, :access_patient_panel?
        else
          flash[:alert] = "Доступ заборонений! Будь ласка, авторизуйтесь або пройдіть реєстрацію для користувача!"
          redirect_to root_path
        end
      end
    end
  end
end

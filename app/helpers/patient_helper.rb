module PatientHelper
  def doctor_photo(doctor)
    doctor.photo.url
  end

  def get_doctor_name(app)
    app.doctor.name + ' ' + app.doctor.surname
  end

  def get_patient_name(app)
    app.patient.name + ' ' + app.patient.surname
  end

  def get_status_appointment(app)
    if app.status == 'pending'
      'Очікуємо підтвердження запису!'
    elsif app.status == 'confirmed'
      "Запис підтверджений! Чекаємо вас об #{app.time.strftime("%H:%M")}!"
    elsif app.status == 'completed'
      'Запис завершений!'
    end
  end

  def image_present?(object)
    object&.photo&.file.nil?
  end

  def image_present(object)
    object.photo.url
  end
end

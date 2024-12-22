module DoctorHelper
  def schedule_status(schedule)
    schedule.status == 'active' ? 'Активний' : 'Не активний'
  end
end

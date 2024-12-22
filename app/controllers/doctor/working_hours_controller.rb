class Doctor::WorkingHoursController < Doctor::ApplicationController
  def create
    @working_hour = WorkingHour.new(working_hour_params)

    respond_to do |format|
      if @working_hour.save
        format.html { redirect_to doctor_schedules_path, notice: 'Нову робочу годину було успішно додано!' }
      else
        format.html {
          redirect_to doctor_schedules_path,
                      alert: "Годину не було додано! Перевірте ваші дані! Можливо, у вас уже існує ця година!"
        }
        format.turbo_stream do
          flash.now[:alert] = "Годину не було додано! Перевірте ваші дані! Можливо, у вас уже існує ця година!"
          render turbo_stream: [turbo_stream.append('flash', partial: 'shared/flash')]
        end
      end
    end
  end

  def destroy
    @working_hour = WorkingHour.find(params[:id])
    @working_hour.destroy

    respond_to do |format|
      format.html { redirect_to doctor_schedules_path, notice: 'Ваша робоча година була успішно видалена!' }
    end
  end

  private

  def working_hour_params
    params.require(:working_hour).permit(:hour, :status, :working_day_id)
  end
end

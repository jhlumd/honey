class AppointmentsController < ApplicationController
  def update
    appointment = Appointment.find(params[:id])

    if appointment.update(adv_accepted: false)
      redirect_to worker_bee_path(appointment.worker_bee_id)
    else
      # fixme add errors
      render worker_bee_path(appointment.worker_bee_id)
    end
  end

  # private
  #   def appointment_params
  #     params.require(:appointment).permit(:appt_id)
  #   end
end

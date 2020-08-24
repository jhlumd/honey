class AppointmentsController < ApplicationController
  def update
    appointment = Appointment.find(params[:id])

    if appointment.update(adv_accepted: false)
      redirect_to worker_bee_path(appointment.worker_bee_id)
    else
      render worker_bee_path(appointment.worker_bee_id)
    end
  end

  # DevNote: Decided that update just changes true/false (Accepted/Overruled)
  #          status, not past nectar or advisement amounts.

  # private
  #   def appointment_params
  #     params.require(:appointment).permit(:nectar, :advisement)
  #   end
end

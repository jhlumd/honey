class AppointmentsController < ApplicationController
  def update
    # @worker_bee = WorkerBee.find()
    # @appointment = Appointment.find()

    # if @appointment.update(appointment_params)
    #   redirect_to worker_bee_path(@worker_bee)
    # else
    #   render worker_bee_path(@worker_bee)
    # end
  end

  private
    def appointment_params
      params.require(:appointment).permit(:adv_accepted)
    end
end

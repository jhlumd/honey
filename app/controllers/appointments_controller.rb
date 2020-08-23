class AppointmentsController < ApplicationController
  def update
    # @worker_bee = WorkerBee.find()

    # redirect_to worker_bee_path(@worker_bee)
  end

  private
    def appointment_params
      params.require(:appointment).permit(:adv_accepted)
    end
end

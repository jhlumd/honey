class AppointmentsController < ApplicationController
  def update
  
  end

  private
    def appointment_params
      params.require(:appointment).permit(:adv_accepted)
    end
end

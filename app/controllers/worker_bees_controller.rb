class WorkerBeesController < ApplicationController
  def index
    @worker_bees = WorkerBee.all.includes(:appointments)
    @hive_info = {
      num_combs: Comb.count,
      total_pg: Appointment.sum(:pollen_globs),
      total_nectar: Appointment.sum(:nectar)
    }
  end

  def show
    @worker_bee = WorkerBee.find(params[:id])
    gon.push({ appointments: @worker_bee.appointments })
    @combs = Comb.all
  end

  def update
    @worker_bee = WorkerBee.find(params[:id])
    old_comb_id = @worker_bee.comb_id.to_s

    if @worker_bee.update(worker_bee_params)
      flash[:notice] = worker_bee_params[:comb_id] == old_comb_id ?
        "Already assigned to this comb" : "Successfully reassigned!"

      redirect_to @worker_bee
    else
      flash.now[:error] = "Could not assign to comb"
      render :show, status: 422
    end
  end

  private
    def worker_bee_params
      params.require(:worker_bee).permit(:comb_id)
    end
end

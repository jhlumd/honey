class WorkerBeesController < ApplicationController
  def index
    @worker_bees = WorkerBee.all
  end

  def show
    @worker_bee = WorkerBee.find(params[:id])
  end

  def update
    @worker_bee = WorkerBee.find(params[:id])

    if @worker_bee.update(worker_bee_params)
      redirect_to @worker_bee
    else
      render @worker_bee
      # fixme render for error?
    end
  end

  private
    def worker_bee_params
      params.require(:worker_bee).permit(:comb_id)
    end
end

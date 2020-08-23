class WorkerBeesController < ApplicationController
  def index
    @worker_bees = WorkerBee.all
  end

  def show
    @worker_bee = WorkerBee.find(params[:id])
  end

  def update
  
  end

  private
    def worker_bee_params
      params.require(:worker_bee).permit(:comb_id)
    end
end

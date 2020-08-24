class WorkerBeesController < ApplicationController
  def index
    @worker_bees = WorkerBee.all
  end

  def show
    @worker_bee = WorkerBee.find(params[:id])
  end

  def update
    @worker_bee = WorkerBee.find(params[:id])

    if worker_bee_params[:comb_id].to_i == @worker_bee.comb_id
      @worker_bee.errors.add(:comb_id, "Already assigned to this comb")
      # @worker_bee.errors[:base] << "Already assigned to this comb"

      debugger
      render 'show'
      return
    end

    if @worker_bee.update(worker_bee_params)
      redirect_to @worker_bee
    else
      render 'show'
    end
  end

  private
    def worker_bee_params
      params.require(:worker_bee).permit(:comb_id)
    end
end

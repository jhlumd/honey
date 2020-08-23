class WorkerBeesController < ApplicationController
  def index
  
  end

  def show
  
  end

  def update
  
  end

  private
    def worker_bee_params
      params.require(:worker_bee).permit(:comb_id)
    end
end

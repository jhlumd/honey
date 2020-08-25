class WorkerBeesController < ApplicationController
  def index
    @worker_bees = WorkerBee.all.includes(:appointments)
    @hive_metrics = {
      num_combs: Comb.count,
      total_pg: Appointment.sum(:pollen_globs),
      total_nectar: Appointment.sum(:nectar)
    }
  end

  def show
    @worker_bee = WorkerBee.find(params[:id])
    @combs = Comb.all # need combs for comb reassignment select dropdown

    gon.push({
      appointments: @worker_bee.appointments
    })

    bee_ne = @worker_bee.appointments.sum(:nectar)
    bee_pg = @worker_bee.appointments.sum(:pollen_globs)
    bee_ne_pg = (bee_ne / bee_pg).round()

    hive_ne = Appointment.sum(:nectar)
    hive_pg = Appointment.sum(:pollen_globs)
    hive_ne_pg = (hive_ne / hive_pg).round()
    vs_hive = bee_ne_pg - hive_ne_pg
    vs_hive = "+#{vs_hive}" if vs_hive > 0

    comb_appts = Appointment.joins(:worker_bee).where("worker_bees.comb_id = ?", @worker_bee.comb_id)
    comb_ne = comb_appts.sum(:nectar)
    comb_pg = comb_appts.sum(:pollen_globs)
    comb_ne_pg = (comb_ne / comb_pg).round()
    vs_comb = bee_ne_pg - comb_ne_pg
    vs_comb = "+#{vs_comb}" if vs_comb > 0

    gon.push({
      vs_hive: vs_hive,
      vs_comb: vs_comb
    })

    @bee_metrics = {
      days_since_last: (DateTime.current.to_date - @worker_bee.appointments.first.date).to_s[0..-3],
      bee_pg: bee_pg,
      bee_ne: bee_ne,
      bee_ne_pg: bee_ne_pg,
      vs_hive: vs_hive,
      vs_comb: vs_comb
    }
  end

  def update
    @worker_bee = WorkerBee.find(params[:id])
    old_comb_id = @worker_bee.comb_id.to_s

    if @worker_bee.update(worker_bee_params)
      flash[:notice] = worker_bee_params[:comb_id] == old_comb_id ?
        "Already in this comb" : "Reassigned!"

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

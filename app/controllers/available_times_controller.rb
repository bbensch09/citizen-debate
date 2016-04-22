class AvailableTimesController < ApplicationController
  before_action :set_available_time, only: [:show, :edit, :update, :destroy, :confirm]

  # GET /available_times
  # GET /available_times.json
  def index
    @available_times = AvailableTime.all
  end

  # GET /available_times/1
  # GET /available_times/1.json
  def show
  end

  # GET /available_times/new
  def new
    @available_time = AvailableTime.new
  end

  # GET /available_times/1/edit
  def edit
  end

  #confirm available time
  # POST /available_times/1
  def confirm
    @available_time.status = "confirmed"
    @available_time.save
    @available_time.debate.start_time = @available_time.proposed_time
    @available_time.debate.status = "Active"
    @available_time.debate.save
    UserMailer.schedule_confirmed(@available_time.debate).deliver_now
    redirect_to @available_time.debate, notice: 'Thanks! Your debate schedule is now confirmed. You and your opponent will receive confirmation emails with further instructions.'
  end

  # POST /available_times
  # POST /available_times.json
  def create
    @available_time = AvailableTime.new(available_time_params)
    respond_to do |format|
      if @available_time.save
        format.html { redirect_to schedule_debate_path(@available_time.debate), notice: 'Available time added. Please add at least 2 options before notifying your opponent.' }
        format.json { render :show, status: :created, location: @available_time }
      else
        format.html { render :new }
        format.json { render json: @available_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /available_times/1
  # PATCH/PUT /available_times/1.json
  def update
    respond_to do |format|
      if @available_time.update(available_time_params)
        format.html { redirect_to @available_time, notice: 'Available time was successfully updated.' }
        format.json { render :show, status: :ok, location: @available_time }
      else
        format.html { render :edit }
        format.json { render json: @available_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /available_times/1
  # DELETE /available_times/1.json
  def destroy
    @available_time.destroy
    respond_to do |format|
      format.html { redirect_to available_times_url, notice: 'Available time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_available_time
      @available_time = AvailableTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def available_time_params
      params.require(:available_time).permit(:debate_id, :proposed_by, :proposed_to, :proposed_time, :status)
    end
end

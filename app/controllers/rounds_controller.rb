class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  after_action :update_debate_status, only: [:update]

  # def start_first_round
  #   @round = Round.find(params[:id])
  #   @round.start_time = Time.now
  #   @round.status = "Active"
  #   @round.save
  #   redirect_to @round.debate
  # end

  def update_debate_status
    Round.last.debate.update_status
  end

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round.debate }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params) && @round.debate.rounds.count == 3
        format.html { redirect_to @round.debate, notice: 'Your debate is now over. Share with friends and check back later for results.' }
        format.json { render :show, status: :ok, location: @round }
      elsif @round.update(round_params) && @round.debate.rounds.count < 3
        format.html { redirect_to @round.debate, notice: 'The previous round is now complete.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { redirect_to @round.debate, notice: "Unable to finish round. #{@round.errors.full_messages.first}"}
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:debate_id, :round_number, :start_time, :end_time, :status)
    end
end

class DebatersController < ApplicationController
  before_action :set_debater, only: [:show, :edit, :update, :destroy]

  # GET /debaters
  # GET /debaters.json
  def index
    @debaters = Debater.all
  end

  # GET /debaters/1
  # GET /debaters/1.json
  def show
  end

  # GET /debaters/new
  def new
    @debater = Debater.new
  end

  # GET /debaters/1/edit
  def edit
  end

  # POST /debaters
  # POST /debaters.json
  def create
    @debater = Debater.new(debater_params)

    respond_to do |format|
      if @debater.save
        format.html { redirect_to @debater, notice: 'Debater was successfully created.' }
        format.json { render :show, status: :created, location: @debater }
      else
        format.html { render :new }
        format.json { render json: @debater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debaters/1
  # PATCH/PUT /debaters/1.json
  def update
    respond_to do |format|
      if @debater.update(debater_params)
        format.html { redirect_to @debater, notice: 'Debater was successfully updated.' }
        format.json { render :show, status: :ok, location: @debater }
      else
        format.html { render :edit }
        format.json { render json: @debater.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debaters/1
  # DELETE /debaters/1.json
  def destroy
    @debater.destroy
    respond_to do |format|
      format.html { redirect_to debaters_url, notice: 'Debater was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debater
      @debater = Debater.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debater_params
      params.require(:debater).permit(:user_id, :debate_record)
    end
end

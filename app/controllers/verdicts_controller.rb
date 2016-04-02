class VerdictsController < ApplicationController
  before_action :set_verdict, only: [:show, :edit, :update, :destroy]

  # GET /verdicts
  # GET /verdicts.json
  def index
    @verdicts = Verdict.all
  end

  # GET /verdicts/1
  # GET /verdicts/1.json
  def show
  end

  # GET /verdicts/new
  def new
    @verdict = Verdict.new
  end

  # GET /verdicts/1/edit
  def edit
  end

  # POST /verdicts
  # POST /verdicts.json
  def create
    @verdict = Verdict.new(verdict_params)

    respond_to do |format|
      if @verdict.save
        format.html { redirect_to @verdict, notice: 'Verdict was successfully created.' }
        format.json { render :show, status: :created, location: @verdict }
      else
        format.html { render :new }
        format.json { render json: @verdict.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verdicts/1
  # PATCH/PUT /verdicts/1.json
  def update
    respond_to do |format|
      if @verdict.update(verdict_params)
        format.html { redirect_to @verdict, notice: 'Verdict was successfully updated.' }
        format.json { render :show, status: :ok, location: @verdict }
      else
        format.html { render :edit }
        format.json { render json: @verdict.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verdicts/1
  # DELETE /verdicts/1.json
  def destroy
    @verdict.destroy
    respond_to do |format|
      format.html { redirect_to verdicts_url, notice: 'Verdict was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verdict
      @verdict = Verdict.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verdict_params
      params.require(:verdict).permit(:status, :opinion_left, :opinion_right, :winner, :confirmed_judges, :confirmed_public)
    end
end

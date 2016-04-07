class OpeningStatementsController < ApplicationController
  before_action :set_opening_statement, only: [:show, :edit, :update, :destroy]

  # GET /opening_statements
  # GET /opening_statements.json
  def index
    @opening_statements = OpeningStatement.all
  end

  # GET /opening_statements/1
  # GET /opening_statements/1.json
  def show
  end

  # GET /opening_statements/new
  def new
    @opening_statement = OpeningStatement.new
  end

  # GET /opening_statements/1/edit
  def edit
  end

  # POST /opening_statements
  # POST /opening_statements.json
  def create
    @opening_statement = OpeningStatement.new(opening_statement_params)

    respond_to do |format|
      if @opening_statement.save
        format.html { redirect_to @opening_statement.debate notice: 'Opening statement was successfully created.' }
        format.json { render :show, status: :created, location: @opening_statement }
      else
        format.html { render :new }
        format.json { render json: @opening_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opening_statements/1
  # PATCH/PUT /opening_statements/1.json
  def update
    respond_to do |format|
      if @opening_statement.update(opening_statement_params)
        format.html { redirect_to @opening_statement.debate notice: 'Opening statement was successfully created.' }
        format.json { render :show, status: :ok, location: @opening_statement }
      else
        format.html { render :edit }
        format.json { render json: @opening_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opening_statements/1
  # DELETE /opening_statements/1.json
  def destroy
    @opening_statement.destroy
    respond_to do |format|
      format.html { redirect_to opening_statements_url, notice: 'Opening statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opening_statement
      @opening_statement = OpeningStatement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opening_statement_params
      params.require(:opening_statement).permit(:author_id, :content, :round_id, :debate_id, :unread)
    end
end

class ClosingStatementsController < ApplicationController
  before_action :set_closing_statement, only: [:show, :edit, :update, :destroy]

  # GET /closing_statements
  # GET /closing_statements.json
  def index
    @closing_statements = ClosingStatement.all
  end

  # GET /closing_statements/1
  # GET /closing_statements/1.json
  def show
  end

  # GET /closing_statements/new
  def new
    @closing_statement = ClosingStatement.new
  end

  # GET /closing_statements/1/edit
  def edit
  end

  # POST /closing_statements
  # POST /closing_statements.json
  def create
    @closing_statement = ClosingStatement.new(closing_statement_params)

    respond_to do |format|
      if @closing_statement.save
        format.html { redirect_to @closing_statement.debate notice: 'closing statement was successfully created.' }
        format.json { render :show, status: :created, location: @closing_statement }
      else
        format.html { render :new }
        format.json { render json: @closing_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /closing_statements/1
  # PATCH/PUT /closing_statements/1.json
  def update
    respond_to do |format|
      if @closing_statement.update(closing_statement_params)
        format.html { redirect_to @closing_statement.debate notice: 'closing statement was successfully updated.' }
        format.json { render :show, status: :ok, location: @closing_statement }
      else
        format.html { render :edit }
        format.json { render json: @closing_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /closing_statements/1
  # DELETE /closing_statements/1.json
  def destroy
    @closing_statement.destroy
    respond_to do |format|
      format.html { redirect_to closing_statements_url, notice: 'Closing statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closing_statement
      @closing_statement = ClosingStatement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def closing_statement_params
      params.require(:closing_statement).permit(:author_id, :content, :round_id, :debate_id, :unread)
    end
end

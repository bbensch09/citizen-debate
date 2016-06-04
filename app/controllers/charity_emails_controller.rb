class CharityEmailsController < ApplicationController
  before_action :set_charity_email, only: [:show, :edit, :update, :destroy]

  # GET /charity_emails
  # GET /charity_emails.json
  def index
    @charity_emails = CharityEmail.all
  end

  # GET /charity_emails/1
  # GET /charity_emails/1.json
  def show
  end

  # GET /charity_emails/new
  def new
    @charity_email = CharityEmail.new
  end

  # GET /charity_emails/1/edit
  def edit
  end

  # POST /charity_emails
  # POST /charity_emails.json
  def create
    @charity_email = CharityEmail.new(charity_email_params)

    respond_to do |format|
      if @charity_email.save
        format.html { redirect_to root_path, notice: 'Thanks for signing up. Check your email and stay tuned.' }
        format.json { render :show, status: :created, location: @charity_email }
      else
        format.html { render :new }
        format.json { render json: @charity_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charity_emails/1
  # PATCH/PUT /charity_emails/1.json
  def update
    respond_to do |format|
      if @charity_email.update(charity_email_params)
        format.html { redirect_to @charity_email, notice: 'Charity email was successfully updated.' }
        format.json { render :show, status: :ok, location: @charity_email }
      else
        format.html { render :edit }
        format.json { render json: @charity_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charity_emails/1
  # DELETE /charity_emails/1.json
  def destroy
    @charity_email.destroy
    respond_to do |format|
      format.html { redirect_to charity_emails_url, notice: 'Charity email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charity_email
      @charity_email = CharityEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charity_email_params
      params.require(:charity_email).permit(:email)
    end
end

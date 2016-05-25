class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :confirm_debater_exists, only: [:create, :update]

  def confirm_debater_exists
    if current_user.debater
      return true
    else
      Debater.create!({
        user_id: current_user.id
        })
    end
  end

  # HACKY SHIT --> ADMIN VIEW TO SEE ALL SNIPPETS
  def admin_index
    if current_user.email == "citizen.debate.16@gmail.com"
      @profiles = Profile.all
      respond_to do |format|
          format.html
          format.csv { send_data @profiles.to_csv, filename: "profiles-#{Date.today}.csv" }
        end
    else
      @profiles = Profile.where(user_id:current_user.id)
      render 'index'
    end
  end

  def admin_users
    if current_user.email == "citizen.debate.16@gmail.com"
      @users = User.all
      respond_to do |format|
          format.html
          format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
        end
    else
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def verify
    profile = Profile.find(params[:id])
    profile.verification_status = "verified"
    profile.save
    redirect_to(profile_path, notice: 'Profile has been verified.')
  end

  # GET /profiles
  # GET /profiles.json
  def index
    non_admin_profiles = Profile.where("id != 1")
    @profiles = non_admin_profiles.sort { |a,b| b.points <=> a.points}
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    puts "trying to load /profiles/new"
    if current_user.profile
      redirect_to "/profiles/#{current_user.profile.id}"
    else
    @profile = Profile.new
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    if current_user.profile
      #ERROR: kick user back to their profile page & tell them they can only create one profile.
      respond_to do |format|
        format.html { redirect_to "/profiles/#{current_user.id}", notice: 'Cannot create more than one profile. Your profile already exists.' }
      end
    else
      @profile.user_id = current_user.id
      respond_to do |format|
        if @profile.save
          format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
          format.json { render :show, status: :created, location: @profile }
        @profile.update_points
        @profile.update_rank
        else
          format.html { render :new }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
        @profile.update_points
        @profile.update_rank
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :city, :state, :age, :about_me, :display_name, :political_affiliation, :avatar, :snippets, :nps, :pmf, :linkedin_profile)
    end
end

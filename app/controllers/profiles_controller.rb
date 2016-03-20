class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # HACKY SHIT
  def test_page
  end

  # HACKY SHIT --> ADMIN VIEW TO SEE ALL SNIPPETS
  def admin_index
    if current_user.email == "bbensch@gmail.com"
      @profiles = Profile.all
      render 'index'
    else
      @profiles = Profile.where(user_id:current_user.id)
      render 'index'
    end
  end

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all.sort { |a,b| a.rank <=> b.rank}
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    puts "trying to load /profiles/new"
    if current_user.profile
      redirect_to "/profiles/#{current_user.id}"
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
      params.require(:profile).permit(:first_name, :last_name, :city, :state, :age, :about_me, :display_name, :political_affiliation, :avatar, :snippets, :nps, :pmf)
    end
end

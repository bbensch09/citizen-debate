class DebatesController < ApplicationController
  before_action :set_debate, only: [:show, :edit, :update, :destroy, :accept_challenge, :schedule]
  before_action :authenticate_user!, except: [:show, :index, :launch]
  before_action :confirm_new_challengers, only: [:index]
  # after_action :create_first_round, only: [:create]

  def launch
    redirect_to '/debates/1'
  end

  def confirm_new_challengers
        puts "confirming new challengers"
        confirmable_debates = Debate.where("challenger_id IS NULL")
        confirmable_debates.each do |debate|
            if User.where("email = ?",debate.challenger_email).count >=1
                debate.challenger_id = User.where("email = ?",debate.challenger_email).first.id
                  if debate.affirmative_id.nil?
                    debate.affirmative_id = debate.challenger_id
                  elsif debate.negative_id.nil?
                    debate.negative_id = debate.challenger_id
                  end
                debate.update_status
                debate.save
                puts "challenger confirmed & appropriate ids now set."
            end
        end
    end

  # GET /debates
  # GET /debates.json
  def index
    @completed_debates = Debate.where("status = 'Completed'")
    @active_debates = Debate.where("status = 'Active'")
    if current_user
      current_user_public_challenges = Debate.where("public_challenge=true AND creator_id =?",current_user.id)
      all_pending_debates = Debate.where("challenge_accepted = false AND challenger_id = ? OR challenger_email=? OR public_challenge=true",current_user.id,current_user.email)
      @pending_debates = all_pending_debates - current_user_public_challenges
      current_user_debates = current_user.debater.debates
      all_debates = Debate.where("status != 'Scheduling'")
      @debates_to_schedule = current_user_debates - all_debates
    else
      @pending_debates = []
    end
  end

  # GET /debates/1
  # GET /debates/1.json
  def show
    @current_user = current_user
    @message = Message.new
    @messages = @debate.cross_ex_messages
    @opening_statement = OpeningStatement.new
    @closing_statement = ClosingStatement.new
    if current_user && current_user.eligible_after_votes.include?(@debate.id)
        @debate_vote = DebateVote.where("debate_id =? AND user_id = ?",@debate.id,current_user.id).first
      else
        @debate_vote = DebateVote.new
    end
    @civility_vote = CivilityVote.new

    render 'show_debate'
  end

  # GET /debates/new
  def new
    @debate = Debate.new
  end

  # GET /debates/1/edit
  def edit
  end

  # POST /debates
  # POST /debates.json
  def create
    @debate = Debate.new(debate_params)

        respond_to do |format|
          if @debate.save
            create_first_round
            if @debate.challenger_id
              UserMailer.challenge_existing_user(@debate).deliver_now
              format.html { redirect_to @debate, notice: 'Your debate challenge has successfully been created and an invitation has been sent to the challenger.' }
              format.json { render :show_debate, status: :created, location: @debate }
            elsif @debate.challenger_email.length > 5
              UserMailer.challenge_new_user(@debate).deliver_now
              format.html { redirect_to @debate, notice: 'Your debate challenge has been created and your challenger has been invited to join Citizen Debate and accept your challenge.' }
              format.json { render :show_debate, status: :created, location: @debate }
            else
              format.html { redirect_to @debate, notice: 'Your debate challenge has successfully been created. You will be notified when another user accepts your public challenge.' }
              format.json { render :show_debate, status: :created, location: @debate }
            end

          else
            format.html { render :new }
            format.json { render json: @debate.errors, status: :unprocessable_entity }
          end
        end

  end

  def create_first_round
    Round.create!({
        debate_id: Debate.last.id,
        round_number: 1,
        status: "Pending"
      })
  end

  def accept_challenge
    puts "logging challenge accepted action"
    @debate.challenge_accepted = true
    @debate.challenger_id = current_user.id
    if @debate.affirmative_id
        @debate.negative_id = current_user.id
      elsif @debate.negative_id
        @debate.affirmative_id = current_user.id
    end
    @debate.status = "Scheduling"
    @debate.save
    UserMailer.challenge_accepted(@debate).deliver_now
    puts "opponent has been sent notification of statement submission."
    redirect_to schedule_debate_path(@debate), notice: "You've accepted the debate challenge. Now please propose a few times that you are available."
  end

  def schedule
    cu_array = []
    cu_array << current_user.id
    opponent_id = (@debate.participants - cu_array).first
    @opponent = User.find(opponent_id)
    @current_user_proposed_times = AvailableTime.where("debate_id=? AND proposed_by=?",@debate.id,current_user.id)
    @opponent_proposed_times = AvailableTime.where("debate_id=? AND proposed_by=?",@debate.id,@opponent.id)
    @available_time = AvailableTime.new
  end

  # PATCH/PUT /debates/1
  # PATCH/PUT /debates/1.json
  def update
    respond_to do |format|
      if @debate.update(debate_params)
        format.html { redirect_to @debate, notice: 'Debate was successfully updated.' }
        format.json { render :show, status: :ok, location: @debate }
      else
        format.html { render :edit }
        format.json { render json: @debate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debates/1
  # DELETE /debates/1.json
  def destroy
    @debate.destroy
    respond_to do |format|
      format.html { redirect_to debates_url, notice: 'Debate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debate
      @debate = Debate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debate_params
      params.require(:debate).permit(:affirmative_id, :negative_id, :creator_id, :challenger_id, :challenger_email, :status, :start_date, :start_time, :topic_id, :public_challenge)
    end
end

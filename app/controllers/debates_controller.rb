class DebatesController < ApplicationController
  before_action :set_debate, only: [:show, :edit, :update, :destroy, :accept_challenge]
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
      @upcoming_debates = Debate.where("challenge_accepted = false AND challenger_id = ? OR challenger_email=?",current_user.id,current_user.email)
    else
      @upcoming_debates = []
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
    @debate.start_date = Date.today

    if @debate.challenger_id
        respond_to do |format|
          if @debate.save
            create_first_round
            UserMailer.challenge_existing_user(@debate).deliver_now
            format.html { redirect_to @debate, notice: 'Your debate challenge has successfully been created and an invitation has been sent to the challenger.' }
            format.json { render :show_debate, status: :created, location: @debate }
          else
            # format.html { render :new }
            # format.json { render json: @debate.errors, status: :unprocessable_entity }
          end
        end
    end

    if @debate.challenger_email.length > 5
        respond_to do |format|
          if @debate.save
            create_first_round
            UserMailer.challenge_new_user(@debate).deliver_now
            format.html { redirect_to @debate, notice: 'Your debate challenge has successfully been created and an invitation has been sent to the challenger.' }
            format.json { render :show_debate, status: :created, location: @debate }
          else
            format.html { render :new }
            format.json { render json: @debate.errors, status: :unprocessable_entity }
          end
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
    @debate.negative_id = current_user.id
    @debate.status = "Active"
    @debate.save
    UserMailer.challenge_accepted(@debate).deliver_now
    puts "opponent has been sent notification of statement submission."
    redirect_to @debate, notice: "You've accepted the debate challenge."
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
      params.require(:debate).permit(:affirmative_id, :negative_id, :creator_id, :challenger_id, :challenger_email, :status, :start_date, :start_time, :topic_id)
    end
end

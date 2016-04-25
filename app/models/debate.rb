class Debate < ActiveRecord::Base
    belongs_to :judge_left, class_name: "Judge", foreign_key: "judge_left_id"
    belongs_to :judge_right, class_name: "Judge", foreign_key: "judge_right_id"
    belongs_to :affirmative_debater, class_name: "Debater", foreign_key: "affirmative_id"
    belongs_to :negative_debater, class_name: "Debater", foreign_key: "negative_id"
    belongs_to :topic
    belongs_to :creator, class_name: "User", foreign_key: "creator_id"
    belongs_to :challenger, class_name: "User", foreign_key: "challenger_id"
    has_many :rounds
    has_one :verdict
    has_many :civility_votes
    has_many :debate_votes
    has_many :opening_statements
    has_many :closing_statements
    has_many :available_times
    validate :confirm_challenge_inputs, on: [:create]

    def to_param
        [id, title.parameterize].join("-")
    end


    def confirm_challenge_inputs
        if self.affirmative_id && self.negative_id
            puts "both affirmative & negative options selected"
            errors.add(:status, "You may only select one side of the debate. Please go back and try again.")
        end
        if self.affirmative_id.nil? && self.negative_id.nil?
            puts "both affirmative & negative options left blank"
            errors.add(:status, "You must select one side of the debate. Please try again.")
        end
        challenger_types_count = 0
        if not self.challenger_id.nil?
            challenger_types_count += 1
        end
        if self.challenger_email.length > 1
            challenger_types_count += 1
        end
        if self.public_challenge == true
            challenger_types_count += 1
        end
        puts "The user has selected #{challenger_types_count} challenger inputs."
        if challenger_types_count != 1
            errors.add(:status, "You must only select one challenger type, please refresh and try again.")
        end
    end

    def challenge_type
        if self.public_challenge == true
            return "public challenge"
        else
            return "private challenge"
        end
    end

    def participants
        debaters = Debater.where("id = ? OR id = ? OR id = ?", self.affirmative_id, self.negative_id, self.challenger_id)
        participant_user_ids = []
        debaters.each do |debater|
            participant_user_ids << debater.user_id
        end
        participant_user_ids
    end

    def title
        self.topic.title
    end

    def judges
        Judge.where("id = ? OR id = ?", self.judge_left_id, self.judge_right_id)
    end

    def cross_ex_messages
        Message.where("debate_id = ?",self.id)
    end

    def opening_affirmative
        OpeningStatement.where("author_id = ? AND debate_id = ?",self.affirmative_debater.user_id, self.id).first
    end

    def opening_negative
        OpeningStatement.where("author_id = ? AND debate_id = ?",self.negative_debater.user_id, self.id).first
    end

    def closing_affirmative
        ClosingStatement.where("author_id = ? AND debate_id = ?",self.affirmative_debater.user_id, self.id).first
    end

    def closing_negative
        ClosingStatement.where("author_id = ? AND debate_id = ?",self.negative_debater.user_id, self.id).first
    end

    def update_status
        if self.rounds.count == 1 && self.rounds.first.status =="Pending"
            return "This debate has not yet started."
        elsif self.rounds.count >=3 && self.rounds.last.status =="Completed"
            self.status = "Completed"
            self.save
            return "Completed"
        else
            self.status = "Active"
            self.save
            return "This debate is still on-going."
        end
    end

    def time_since_updated
        days_elapsed = ((Time.now - updated_at.to_time) / (60*60*24)).round
        hours_elapsed = ((Time.now - updated_at.to_time) / (60*60)).round
        minutes_elapsed = ((Time.now - updated_at.to_time) / (60)).round
        if minutes_elapsed < 60
            return "#{minutes_elapsed} minutes ago."
        elsif hours_elapsed < 24
            return "#{hours_elapsed} hours ago."
        else
            return "#{days_elapsed} days ago."
        end
    end

end

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

    def confirm_challenge_inputs
        if self.affirmative_id && self.negative_id
            puts "both affirmative & negative options selected"
            errors.add(:status, "You may only select one side of the debate. Please refresh and try again.")
        end
        if self.challenger_id && (self.challenger_email || self.public_challenge == true)
            errors.add(:status, "You may only select one challenger type, please refresh and try again.")
        elsif self.challenger_id
            type = "existing user"
        end
        if self.challenger_email && (self.challenger_id || self.public_challenge == true)
            errors.add(:status, "You may only select one challenger type, please refresh and try again.")
        elsif self.challenger_email
            type = "invite by email"
        end
        if self.public_challenge == true && (self.challenger_id || self.challenger_email)
            errors.add(:status, "You may only select one challenger type, please refresh and try again.")
        elsif self.public_challenge == true
            type = "public challenge"
        end
        puts "the challenge_method is #{type}"
    end

    def participants
        debaters = Debater.where("id = ? OR id = ? OR id = ?", self.affirmative_id, self.negative_id, self.challenger_id)
        participant_user_ids = []
        debaters.each do |debater|
            participant_user_ids << debater.user_id
        end
        participant_user_ids
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

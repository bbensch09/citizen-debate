class Debate < ActiveRecord::Base
    belongs_to :judge_left, class_name: "Judge", foreign_key: "judge_left_id"
    belongs_to :judge_right, class_name: "Judge", foreign_key: "judge_right_id"
    belongs_to :affirmative_debater, class_name: "Debater", foreign_key: "affirmative_id"
    belongs_to :negative_debater, class_name: "Debater", foreign_key: "negative_id"
    belongs_to :topic
    has_many :rounds
    has_one :verdict
    has_many :civility_votes
    has_many :debate_votes
    has_many :opening_statements
    has_many :closing_statements

    def participants
        Debater.where("id = ? OR id = ?", self.affirmative_id, self.negative_id)
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
            return "This debate has ended."
        else
            self.status = "Active"
            self.save
            return "This debate is still on-going."
        end
    end

end

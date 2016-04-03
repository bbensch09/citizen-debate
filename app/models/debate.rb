class Debate < ActiveRecord::Base
    belongs_to :judge_left, class_name: "Judge", foreign_key: "judge_left_id"
    belongs_to :judge_right, class_name: "Judge", foreign_key: "judge_right_id"
    belongs_to :affirmative_debater, class_name: "User", foreign_key: "affirmative_id"
    belongs_to :negative_debater, class_name: "User", foreign_key: "negative_id"
    belongs_to :topic
    has_many :rounds
    has_one :verdict
    has_many :civility_votes
    has_many :debate_votes

    def participants
        Debater.where("id = ? OR id = ?", self.affirmative_id, self.negative_id)
    end

    def judges
        Judge.where("id = ? OR id = ?", self.judge_left_id, self.judge_right_id)
    end

end

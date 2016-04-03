class Judge < ActiveRecord::Base
    belongs_to :user
    has_many :left_debates, class_name: "Debate", foreign_key: "judge_left_id"
    has_many :right_debates, class_name: "Debate", foreign_key: "judge_right_id"

      def debates
          Debate.where("judge_left_id = ? OR judge_right_id = ?", self.id, self.id)
      end
end

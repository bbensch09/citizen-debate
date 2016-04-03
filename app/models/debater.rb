class Debater < ActiveRecord::Base
      belongs_to :user
      has_many :affirmative_debates, class_name: "Debate", foreign_key: "affirmative_id"
      has_many :negative_debates, class_name: "Debate", foreign_key: "negative_id"
      has_many :civility_votes
      has_many :messages, foreign_key: "author_id"

      def debates
          Debate.where("affirmative_id = ? OR negative_id = ?", self.id, self.id)
      end
end

class CreateDebateVotes < ActiveRecord::Migration
  def change
    create_table :debate_votes do |t|
      t.integer :user_id
      t.integer :vote_for
      t.integer :debate_id

      t.timestamps null: false
    end
  end
end

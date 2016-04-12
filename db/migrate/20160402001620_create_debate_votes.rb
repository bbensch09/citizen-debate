class CreateDebateVotes < ActiveRecord::Migration
  def change
    create_table :debate_votes do |t|
      t.integer :user_id
      t.integer :debate_id
      t.string :vote_before
      t.string :vote_after

      t.timestamps null: false
    end
  end
end

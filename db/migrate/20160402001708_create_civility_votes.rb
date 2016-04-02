class CreateCivilityVotes < ActiveRecord::Migration
  def change
    create_table :civility_votes do |t|
      t.integer :voter_id
      t.integer :debate_id
      t.integer :debater_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end

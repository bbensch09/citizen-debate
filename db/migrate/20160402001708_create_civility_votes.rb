class CreateCivilityVotes < ActiveRecord::Migration
  def change
    create_table :civility_votes do |t|
      t.integer :voter_id
      t.integer :debate_id
      t.integer :affirmative_id
      t.integer :negative_id
      t.integer :affirmative_rating
      t.integer :negative_rating

      t.timestamps null: false
    end
  end
end

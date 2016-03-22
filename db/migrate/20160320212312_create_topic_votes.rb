class CreateTopicVotes < ActiveRecord::Migration
  def change
    create_table :topic_votes do |t|
      t.integer :value
      t.integer :voter_id, null: false
      t.integer :topic_id, null: false
      t.timestamps null: false
    end
  end
end

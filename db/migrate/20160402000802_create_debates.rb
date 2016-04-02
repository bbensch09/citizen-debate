class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.integer :affirmative_id
      t.integer :negative_id
      t.integer :judge_left_id
      t.integer :judge_right_id
      t.string :status
      t.date :start_date
      t.datetime :start_time
      t.integer :verdict_id
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end

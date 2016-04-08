class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.integer :affirmative_id
      t.integer :negative_id
      t.integer :creator_id
      t.integer :challenger_id
      t.string :challenger_email
      t.string :status
      t.date :start_date
      t.datetime :start_time
      t.integer :topic_id
      t.timestamps null: false
    end
  end
end

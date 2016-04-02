class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :debate_id
      t.integer :round_number
      t.datetime :start_time
      t.datetime :end_time
      t.string :status

      t.timestamps null: false
    end
  end
end

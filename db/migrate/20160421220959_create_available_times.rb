class CreateAvailableTimes < ActiveRecord::Migration
  def change
    create_table :available_times do |t|
      t.integer :debate_id
      t.integer :proposed_by
      t.integer :proposed_to
      t.datetime :proposed_time
      t.string :status

      t.timestamps null: false
    end
  end
end

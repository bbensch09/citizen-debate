class CreateVerdicts < ActiveRecord::Migration
  def change
    create_table :verdicts do |t|
      t.string :status
      t.string :opinion_left
      t.string :opinion_right
      t.integer :winner
      t.string :confirmed_judges
      t.string :confirmed_public

      t.timestamps null: false
    end
  end
end

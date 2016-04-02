class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.integer :user_id
      t.string :slant_profile
      t.float :slant_historical

      t.timestamps null: false
    end
  end
end

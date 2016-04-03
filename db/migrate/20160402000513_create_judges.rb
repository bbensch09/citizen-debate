class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string :slant_profile
      t.float :slant_historical
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

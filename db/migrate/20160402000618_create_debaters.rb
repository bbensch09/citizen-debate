class CreateDebaters < ActiveRecord::Migration
  def change
    create_table :debaters do |t|
      t.float :debate_record
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

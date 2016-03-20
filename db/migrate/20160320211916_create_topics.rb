class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :description
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

class CreateTopicTags < ActiveRecord::Migration
  def change
    create_table :topic_tags do |t|
      t.integer :debate_id
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end

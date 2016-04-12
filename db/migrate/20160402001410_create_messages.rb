class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.string :message_content
      t.integer :debate_id
      t.integer :round_id
      t.boolean :unread

      t.timestamps null: false
    end
  end
end

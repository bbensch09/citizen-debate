class CreateClosingStatements < ActiveRecord::Migration
  def change
    create_table :closing_statements do |t|
      t.integer :author_id
      t.string :content
      t.integer :round_id
      t.integer :debate_id
      t.boolean :unread

      t.timestamps null: false
    end
  end
end

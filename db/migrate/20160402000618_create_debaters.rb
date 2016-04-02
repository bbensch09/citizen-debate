class CreateDebaters < ActiveRecord::Migration
  def change
    create_table :debaters do |t|
      t.integer :user_id
      t.float :record

      t.timestamps null: false
    end
  end
end

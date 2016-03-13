class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.integer :age
      t.string :about_me
      t.string :display_name
      t.string :political_affiliation
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

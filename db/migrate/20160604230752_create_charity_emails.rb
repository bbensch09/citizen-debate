class CreateCharityEmails < ActiveRecord::Migration
  def change
    create_table :charity_emails do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end

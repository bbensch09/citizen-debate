class RemoveStartdateFromDebatesAddPublicChallenge < ActiveRecord::Migration
  def change
    remove_column :debates, :start_date, :date
    add_column :debates, :public_challenge, :boolean, default:false
  end
end

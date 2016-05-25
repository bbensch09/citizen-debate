class AddTrackOpensToDebates < ActiveRecord::Migration
  def change
        add_column :debates, :track_opens, :boolean, default: false
  end
end

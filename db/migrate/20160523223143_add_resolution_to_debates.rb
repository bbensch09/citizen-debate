class AddResolutionToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :resolution, :string
    add_column :debates, :affirmative_confirmed, :boolean
  end
end

class MoveScoreFromEventsToNeeds < ActiveRecord::Migration
  def change
    remove_column :events, :score, :integer
    add_column :needs, :score, :integer
  end
end

class AddDefaultToRequestCompleted < ActiveRecord::Migration
  def change
		change_column :requests, :complete, :boolean, :default => false
  end
end

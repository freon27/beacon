class AddColumnCompletedToRequest < ActiveRecord::Migration
  def change
		add_column :requests, :complete, :boolean
  end
end

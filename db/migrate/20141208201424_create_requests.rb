class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.text :details
      t.integer :urgency
      t.integer :relevance_period
      t.integer :requestor_id
      t.integer :assigned_to

      t.timestamps
    end
  end
end

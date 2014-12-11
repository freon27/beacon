class Request < ActiveRecord::Base
  
  URGENCY = []
  
  validates_presence_of :title, :details, :requestor_id
  belongs_to :requestor, class_name: "User"
  belongs_to :assignee, class_name: "User", foreign_key: "assigned_to"
  
  default_scope { order(:created_at => :desc) }
end

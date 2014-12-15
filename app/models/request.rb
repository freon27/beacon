class Request < ActiveRecord::Base
  
  URGENCY = []
  
  validates_presence_of :title, :details, :requestor_id
  belongs_to :requestor, class_name: "User"
  belongs_to :assignee, class_name: "User", foreign_key: "assigned_to"
  has_many :attachments, dependent: :destroy
  default_scope { order(:urgency => :asc, :created_at => :asc) }
end

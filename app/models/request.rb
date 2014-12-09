class Request < ActiveRecord::Base
  validates_presence_of :title, :details, :requestor_id
  belongs_to :requestor, class_name: "User"
end

class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  attr_accessible :event_id, :intention, :user_id, :owner_id

  validates :user_id, :presence => {:message =>'is blank'}, :uniqueness => true
end

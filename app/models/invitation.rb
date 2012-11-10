class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  attr_accessible :event_id, :intention, :user_id, :owner_id, :editable
end

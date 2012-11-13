class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  attr_accessible :content, :event_id, :user_id
end

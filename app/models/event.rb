class Event < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  attr_accessible :budget, :context, :date, :place, :title, :user_id, :public, :start_time, :reply_delivery
end

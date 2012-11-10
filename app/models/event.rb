class Event < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy

  attr_accessible :budget, :context, :date, :place, :title, :user_id, :public
end

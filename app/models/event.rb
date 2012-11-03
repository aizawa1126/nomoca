class Event < ActiveRecord::Base
  belongs_to :user

  attr_accessible :budget, :context, :date, :place, :title
end

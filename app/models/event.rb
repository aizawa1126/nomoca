class Event < ActiveRecord::Base
  attr_accessible :budget, :context, :date, :place, :title
end

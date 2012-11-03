class User < ActiveRecord::Base
  attr_accessible :account, :name, :password
end

class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  attr_accessible :account, :name, :password, :password_confirmation

  validates :account, :presence => {:message =>'is blank'}, :uniqueness => true, :format => {:with => /^[1-9a-zA-Z]+$/, :message => 'may only contain alphanumeric characters '}
  validates :password, :presence => {:message =>'is blank'}, :confirmation => true

  def self.authenticate(attributes)
    find_by_account_and_password(attributes[:account], attributes[:password])
  end
end

class User < ActiveRecord::Base
  has_many :addresses, :dependent => :destroy

  attr_accessible :first_name, :last_name

  validates :first_name, :last_name, :presence => true
end

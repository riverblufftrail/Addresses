class Address < ActiveRecord::Base
  belongs_to :user

  attr_accessible :street, :city, :state, :zip, :user_id

  validates :street, :city, :state, :zip,  :presence => true
  validates :zip, :numericality => true
  validates :state, :length => { :is => 2 }
  validates :state, :format => { :with => /\A[A-Z]{2}\z/, :message => "Only caps allowed" }

end

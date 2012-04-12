require 'spec_helper'

describe User do
  it 'must have a first name and last name' do
    u =User.new
    #u.valid?.should be_false
    u.should_not be_valid
    u.errors[:first_name].should_not be_empty
    u.errors[:last_name].should_not be_empty
  end

  it 'can have many addresses' do
    u =User.new
    u.should respond_to(:addresses)

  end

end
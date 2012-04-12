require 'spec_helper'

describe Address do

  it 'Street, City, Sate & Zip required' do
    a = Address.new
    #u.valid?.should be_false
    a.should_not be_valid
    a.errors[:street].should_not be_empty
    a.errors[:city].should_not be_empty
    a.errors[:state].should_not be_empty
    a.errors[:zip].should_not be_empty

  end


  it 'Zip should be numeric' do
    a = Address.new
    a.zip = "abc"
    a.should_not be_valid
    a.errors[:zip].should_not be_empty


  end

  it 'State must be two letters' do
    a = Address.new
    a.state = "tex"
    a.should_not be_valid
    a.errors[:state].should_not be_empty
  end



  it 'State must Upper Case' do
    a = Address.new
    a.state = "te"
    a.should_not be_valid
    a.errors[:state].should_not be_empty
  end


  it 'Each address belongs to user' do
    user = FactoryGirl.create(:user)
    address = FactoryGirl.create(:address, :user =>user)

    user.addresses.first.should == address

    #a = Address.new
    #a.should respond_to(:user)
  end

  it "should not have orphaned addresses when the user object is removed" do
    user = FactoryGirl.create(:user)
    address = FactoryGirl.create(:address, :user =>user)
    user.destroy
    expect {
      Address.find(address.id)
    }.to raise_exception
  end

  it "should be able to create addresses from the user object" do
    user = FactoryGirl.create(:user)
    address = user.addresses.create
    user.addresses.last.should == address
  end

  it "should have many addresses per user" do
    user = FactoryGirl.create(:user)
    address1 = user.addresses.create(:street => '1234 Street', :city => 'City', :state => 'AZ', :zip => '12345')
    address2 = user.addresses.create(:street => '1234 Street', :city => 'City', :state => 'AZ', :zip => '12345')
    user.addresses.count.should == 2
  end

  it "should not have any addresses" do
    user = FactoryGirl.create(:user)
    user.addresses.count.should == 0
  end

end
require 'spec_helper'

describe AddressesController do
  before do
    @user = FactoryGirl.create(:user)
    @address1 = FactoryGirl.create(:address, :user => @user)
    @address2 = FactoryGirl.create(:address, :user => @user)
  end

  describe "GET 'index'" do
    it "should display the addresses template" do
      get :index
      assigns(:user).should == @user
      assigns(:addresses).size.should > 0
      response.should render_template('index')
    end
  end

  describe "GET 'show'" do
    it "should render the show template" do
      get :show, { :user_id => @user, :id => @address1.id }
      assigns(:user).should == @user
      assigns(:address).should == @address1
      response.should render_template('show')
    end
  end

  describe "GET 'new'" do
    it "should render the new template" do
      get :new, :user_id => @user.id
      assigns(:user).should == @user
      assigns(:address).should be_a(Address)
      response.should render_template('new')
    end
  end

  describe "POST 'create'" do
    describe "when the data is valid" do
      it "saves the data" do
        expect {
          post :create, { :user_id => @user.id, :address => { :street => '1234 Street', :city => 'Bend', :state => 'AZ', :zip => '12345' } }
        }.to change{@user.addresses.count}.by(1)
      end

      it "should render the show template" do
        post :create, { :user_id => @user.id, :address => { :street => '1234 Street', :city => 'Bend', :state => 'AZ', :zip => '12345' } }
        response.should render_template('show')
      end
    end

    describe "when invalid" do
      it "should not save the data" do
        expect {
          post :create, { :user_id => @user.id, :address => { :street => '', :city => '', :state => '', :zip => '' } }
        }.to_not change{Address.count}
      end

      it "should render the new template" do
        post :create, { :user_id => @user.id, :address => { :street => '1234 Street', :city => 'Bend', :state => 'AZ', :zip => '12345' } }
        response.should render_template('new')
      end
    end
  end

  describe "GET 'edit'" do
    it "should render the edit template" do
      get :edit, { :user_id => @user, :id => @address1.id }
      assigns(:user).should == @user
      assigns(:address).should == @address1
      response.should render_template('edit')
    end
  end

  describe "PUT 'update'" do
    before
      @street = '456 Street'
      @city = 'Different'
      @state = 'NY'
      @zip = '54321'
    end

    describe "when data is valid" do
      it "should update the address" do
        post :update, { :user_id => @user.id, :id => @address.id, :address => { :street => @street, :city => @city, :state => @state, :zip => @zip } }
        address = @user.addresses.find(@address.id)
        address.street.should == @street
        address.city.should == @city
        address.state.should == @state
        address.zip.should == @zip
      end

      it "should render the show template" do
        post :update, { :user_id => @user.id, :id => @address.id, :address => { :street => @street, :city => @city, :state => @state, :zip => @zip } }
        response.should render_template('show')
      end
    end

    describe "when data is not valid"
  end
end

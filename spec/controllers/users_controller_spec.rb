require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "should define @users" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      get :index
      assigns(:users).size.should > 0
      response.should render_template('index')
    end
  end

  describe "GET 'new'" do
    it "should display the new template" do
      get :new
      assigns(:user).should be_a(User)
      response.should render_template('new')
    end
  end

  describe "POST 'create'" do
    describe "when data is valid" do
      it "saves the user" do
        expect {
          post :create, :user => { :first_name => 'John', :last_name => 'Doe' }
        }.to change{ User.count }.by(1)
      end
    end

    it "should redirect to the show page" do
      post :create, :user => { :first_name => 'John', :last_name => 'Doe' }
      response.should redirect_to(user_path(User.last.id))
    end

    it "should render the new page if user is invalid" do
      post :create
      response.should render_template('new')
    end
  end

  describe "when data is not valid" do
    it "does not save the user" do
      expect {
        post :create, :user => {}
      }.to_not change{User.count}
    end

    it "returns to the new template" do
      post :create, :user => {}
      response.should render_template('new')
    end
  end

  describe "GET 'show'" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "sets @user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end

    it "renders 'show' template" do
      get :show, :id => @user.id
      response.should render_template('show')
    end
  end

  describe "GET 'edit'" do
    describe "when user exists" do
      it "should render the edit template" do
        user = FactoryGirl.create(:user)
        get :edit, :id => user.id
        response.should render_template('edit')
      end
    end
  end

  describe "PUT 'create'" do
    before do
      @user = FactoryGirl.create(:user)
    end

    describe "when valid" do
      it "should updated the user attributes" do
        put :update, { :id => @user.id, :user => { :first_name => 'Some', :last_name => 'Name' } }
        user = User.find(@user.id)
        user.first_name.should == 'Some'
        user.last_name.should == 'Name'
      end

      it "should render the show template" do
        put :update, { :id => @user.id, :user => { :first_name => 'Some', :last_name => 'Name' } }
        response.should redirect_to(user_path(@user))
      end
    end

    describe "when invalid" do
      it "should not save the user data" do
        put :update, { :id => @user.id, :user => { :first_name => '', :last_name => '' } }
        response.should render_template('edit')
      end
    end
  end

end

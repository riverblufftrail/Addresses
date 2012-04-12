class AddressesController < ApplicationController
  before_filter :get_user

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end

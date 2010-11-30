class UsersController < ApplicationController

  respond_to :json

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with(@user)
  end

end

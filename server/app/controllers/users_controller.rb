class UsersController < ApplicationController

  respond_to :json

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with(@user)
  end

  def update
    begin
      @user = User.find(params[:id])
      @user.update_attributes(params[:user])
      respond_with(@user)
    rescue ActiveRecord::RecordNotFound 
      render :json => "Not Found", :status => :not_found
    end
  end

end

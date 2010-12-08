require 'spec_helper'

describe UsersController do

  describe "POST create" do

    let(:user) { mock_model(User).as_new_record.as_null_object }

    before do
      User.stub(:new).and_return(user)
    end

    it "creates a new user" do
      User.should_receive(:new).with("name" => "test", "lastname" => "test test", "login" => "test").and_return(user)
      post :create, :format => "json", :user => { "name" => "test", "lastname" => "test test", "login" => "test" }
    end

    it "saves the user" do
      user.should_receive(:save)
      post :create, :format => "json"
    end

    context "when the user saves successfully" do

      it "returns 201 status code" do
        # TODO: Refactor to helper method
        user.stub(:errors).and_return({})
        post :create, :format => "json"
        response.response_code.should == 201
      end

    end

    context "when the user fails to save" do

      it "returns 422 status code" do
        # TODO: Refactor to helper method
        user.stub(:errors).and_return({:error => [nil]})
        post :create, :format => "json"
        response.response_code.should == 422
      end

    end

  end

  describe "PUT update" do

    let(:user) { mock_model(User).as_null_object }

    before do
      User.stub(:find).with(1).and_return(user)
    end

    it "finds the user" do
      User.should_receive(:find).with(1).and_return(user)
      put :update, :id => 1, :format => "json"
    end

    it "updates user attributes" do
      user.should_receive(:update_attributes)
      put :update, :id => 1, :format => "json"
    end

    context "when the user updates successfully" do

      it "returns 200 status code" do
        user.stub(:errors).and_return({})
        put :update, :id => 1, :format => "json"
        response.response_code.should == 200
      end

    end

    context "when the user fails to update" do

      it "returns 422 status code" do
        user.stub(:errors).and_return({:error => [nil]})
        put :update, :id => 1, :format => "json"
        response.response_code.should == 422
      end

    end

    context "when the user does not exist" do

      it "returns 404 status code" do
        User.stub(:find).with(1).and_raise(ActiveRecord::RecordNotFound)
        put :update, :id => 1, :format => "json"
        response.response_code.should == 404
      end

    end

  end

end

require 'spec_helper'

describe UsersController do

  describe "POST create" do

    let(:user) { mock_model(User).as_null_object }

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

    it "returns 201 status code" do
      post :create, :format => "json"
      response.response_code.should == 201
    end

  end

end

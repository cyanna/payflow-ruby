require 'ostruct'
require 'spec_helper'

describe Payflow::Gateway do
  describe "Making a Sale" do

  end

  describe "Making an authorization" do
    it "should create a request with :authorization" do
      expected_return = double(commit: Payflow::MockResponse.new(""))
      expect(Payflow::Request).to receive(:new).with(:authorization, 10, nil, {:login=>"login", :password=>"password", :partner=>"Partner"}).and_return(expected_return)
      gateway = Payflow::Gateway.new(OpenStruct.new(password: "password",  login: "login", partner: "Partner"))
      gateway.authorize(10, nil)
    end
  end

  describe "Initializing" do
    it "should require login" do
      gateway = Payflow::Gateway.new(OpenStruct.new(password: "password", partner: "partner"))
      gateway.should be(nil)
    end

    it "should require password" do
      gateway = Payflow::Gateway.new(OpenStruct.new(login: "login", partner: "partner"))
      gateway.should be(nil)
    end

    it "should require partner" do
      gateway = Payflow::Gateway.new(OpenStruct.new(password: "password",  login: "login"))
      gateway.should be(nil)
    end

    it "should be valid with login, password, partner" do
      gateway = Payflow::Gateway.new(OpenStruct.new(password: "password",  login: "login", partner: "Partner"))
      gateway.should be_a(Payflow::Gateway)
    end
  end
end

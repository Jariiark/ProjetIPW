require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "devrait réussir" do
      get :new
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get :new
      response.should have_selector("titre", :content => "S'identifier")
    end
  end
end

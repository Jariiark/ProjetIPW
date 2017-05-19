require 'rails_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  it "should get home" do
    get pages_home_url
    assert_response :success
  end

  it "should get contact" do
    get pages_contact_url
    assert_response :success
  end
  
  it "should get connect" do
    get pages_?_url
    essert_response :success
  end
  


end

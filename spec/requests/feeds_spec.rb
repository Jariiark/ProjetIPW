require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  describe "GET /feeds" do
    it "works! (now write some real specs)" do
      get feeds_path
      expect(response).to have_http_status(200)
    end
  end
  describe "création" do

    describe "échec" do

      it "ne devrait pas créer un nouveau feed" do
        lambda do
          visit root_path
          fill_in :feed_url, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Feed, :count)
      end
    end

    describe "succès" do

      it "devrait créer un nouveau feed" do
        
        lambda do
          visit root_path
          fill_in :feed_url, :with => url
          click_button
          response.should have_selector("span.url", :url => url)
        end.should change(Feed, :count).by(1)
      end
    end
  end
end

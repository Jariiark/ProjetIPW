require 'rails_helper'

RSpec.describe "feeds/edit", type: :view do
  before(:each) do
    @feed = assign(:feed, Feed.create!(
      :tititle => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit feed form" do
    render

    assert_select "form[action=?][method=?]", feed_path(@feed), "post" do

      assert_select "input#feed_tititle[name=?]", "feed[tititle]"

      assert_select "input#feed_url[name=?]", "feed[url]"
    end
  end
end

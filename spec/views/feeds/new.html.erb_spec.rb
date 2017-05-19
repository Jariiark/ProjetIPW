require 'rails_helper'

RSpec.describe "feeds/new", type: :view do
  before(:each) do
    assign(:feed, Feed.new(
      :tititle => "MyString",
      :url => "MyString"
    ))
  end

  it "renders new feed form" do
    render

    assert_select "form[action=?][method=?]", feeds_path, "post" do

      assert_select "input#feed_tititle[name=?]", "feed[tititle]"

      assert_select "input#feed_url[name=?]", "feed[url]"
    end
  end
end

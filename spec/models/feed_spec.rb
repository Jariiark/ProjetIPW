require 'rails_helper'

RSpec.describe Feed, type: :model do
  it "devrait créer une nouvelle instance avec les attributs valides" do
    Feed.create!(@attr)
  end
  describe "associations avec l'utilisateur" do

    before(:each) do
      @feed = @user.feeds.create(@attr)
    end

    it "devrait avoir un attribut user" do
      @feed.should respond_to(:user)
    end

    it "devrait avoir le bon utilisateur associé" do
      @feed.user_id.should == @user.id
      @feed.user.should == @user
    end
  end
  describe "validations" do

    it "requiert un identifiant d'utilisateur" do
      Feed.new(@attr).should_not be_valid
    end

    it "requiert un contenu non vide" do
      @user.feeds.build(:url => "  ").should_not be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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
  describe "POST 'create'" do
    
    describe "invalid signin" do

      it "devrait re-rendre la page new" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "devrait avoir le bon titre" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "S'identifier")
      end

      it "devait avoir un message flash.now" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
    describe "avec un email et un mot de passe valides" do

      it "devrait identifier l'utilisateur" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end
   describe "POST 'deconnect'" do
     it "devrait deconnecter l'utilisateur" do
	delete :destroy
        controller.should redirect_to(root_path)
     end
   end
        
end

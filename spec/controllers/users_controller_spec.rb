require 'spec_helper'

RSpec.describe UsersController do
  render_views
  describe "GET 'new'" do
    it "devrait réussir" do
      get 'new'
      response.should be_success
    end
    it "devrait avoir le titre adéquat" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end
  end
  describe "GET 'show'" do

    it "devrait réussir" do
      get :show, :id => @user
      response.should be_success
    end

    it "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "devrait avoir le bon titre" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end

    it "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end
    it "devrait afficher les feeds de l'utilisateur" do
     get :show, :id =>user
    end
  end
  describe "POST 'create'" do

    describe "échec" do

    

      it "ne devrait pas créer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end

      it "devrait rendre la page 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    describe "succès" do
      
      it "devrait identifier l'utilisateur" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

      it "devrait créer un utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    
    end

 end

end

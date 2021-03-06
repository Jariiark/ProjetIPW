require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  describe UsersController do
  render views
  describe "GET 'show'" do

    test "devrait réussir" do
      get :show, :id => @user
      response.should be_success
    end

    test "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
  test "should get new" do
    get users_connect_url
    assert_response :success
  end
  test "devrait avoir le bon titre" do 
      get :new
      response.should have_selector("title", :content => "Inscription")
    end
  test "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end
  test "devrait avoir un champ nom" do
      get :new
      response.should have_selector("input[nom='user[nom]'][type='text']")
    end

    test "devrait avoir un champ email"

    test "devrait avoir un champ mot de passe"

    it "devrait avoir un champ confirmation du mot de passe"
  end
  end
  describe "POST 'create'" do

    describe "échec" do

      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      test "ne devrait pas créer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      test "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end

      test "devrait rendre la page 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    describe "succès" do

      before(:each) do
        @attr = { :nom => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end
      test "devrait identifier l'utilisateur" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

      test "devrait créer un utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      test "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    
    end
     test "devrait avoir un message de bienvenue" do
        post :create, :user => @attr
        flash[:success].should =~ /Incription réussie/i
      end
  end

end

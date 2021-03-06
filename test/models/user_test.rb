require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe User do

  before(:each) do
    @attr = { :nom => "Example User", :email => "user@example.com" }
  end

  test "devrait créer une nouvelle instance dotée des attributs valides" do
    User.create(@attr)
  end

  test "devrait exiger un nom" do
    bad_guy = User.new(@attr.merge(:nom => ""))
    bad_guy.should_not be_valid
  end
  test "devrait rejeter les noms trop longs" do
    long_nom = "a" * 51
    long_nom_user = User.new(@attr.merge(:nom => long_nom))
    long_nom_user.should_not be_valid
  end
  test "exige une adresse email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  test "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  test "devrait rejeter une adresse email invalide" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  test "devrait rejeter un email double" do
    # Place un utilisateur avec un email donné dans la BD.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
   describe "password validations" do

    test "devrait exiger un mot de passe" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    test "devrait exiger une confirmation du mot de passe qui correspond" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    test  "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    test "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    test "devrait avoir un attribut  mot de passe crypté" do
      @user.should respond_to(:encrypted_password)
    end
    test "devrait définir le mot de passe crypté" do
      @user.encrypted_password.should_not be_blank
    end
    describe "Méthode has_password?" do

     test "doit retourner true si les mots de passe coïncident" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      test "doit retourner false si les mots de passe divergent" do
        @user.has_password?("invalide").should be_false
      end 
    end
    describe "authenticate method" do

      test "devrait retourner nul en cas d'inéquation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      test "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      test "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
end



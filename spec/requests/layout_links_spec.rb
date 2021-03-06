describe "Liens du layout" do

describe "quand pas identifié" do
    it "doit avoir un lien de connexion" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "S'identifier")
    end
  end

  describe "quand identifié" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in "Mot de passe", :with => @user.password
      click_button
    end

    it "devrait avoir un lien de déconnxion" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Déconnexion")
    end

    it "devrait avoir un lien vers le profil" 
     visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profil")
    end
  end
end

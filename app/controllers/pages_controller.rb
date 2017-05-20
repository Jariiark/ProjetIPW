
class PagesController < ApplicationController
  def public_method
    alim
  end  

  def home
   @title = "Accueil"
   
   
   if signed_in?
    @feed = Feed.new
    @alim_items=current_user.alim.paginate(:page=>params[:page],:per_page => 5)
   end
  end

  def contact
   @title = "Contact"
  end
  
  def about
   @title = "A Propos"
  end
  def help
   @title = "Aide"
  end
end

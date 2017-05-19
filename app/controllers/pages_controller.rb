
class PagesController < ApplicationController
  def public_method
    alim
  end  

  def home
   @title = "Accueil"
   @feed = Feed.new if signed_in?
   if signed_in?
    @feed = Feed.new
    @alim_items= current_user.alim.paginate(:page=>params[:page])
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

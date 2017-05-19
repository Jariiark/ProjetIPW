class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.nom
  end
  def new
   @user = User.new
   @title = "S'inscrire"
  end
  def create
    @user = User.new(user_param)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue!"
      redirect_to @user
    else
      @title = "S'inscrire"
      render 'new'
    end
  end
  private
  def user_param
   params.require(:user).permit(:nom, :email, :password,:salt, :encrypted_password)
  end
end

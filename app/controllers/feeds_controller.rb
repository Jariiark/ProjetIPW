class FeedsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => [:destroy, :edit]
  def index
     
    @feeds=Feed.all if signed_in?
  end
  def new
   @feed=Feed.new
  end
  def create
  @feed  = current_user.feeds.build(feed_param)
    if @feed.save
      flash[:success] = "Feed created!"
      redirect_to root_path
    else
      @alim_items= []
      render 'pages/home'
    end
  end
  def show
    @feed=Feed.find_by_permalink(params[:id])
  end
  def edit
    @feed = Feed.find_by_permalink(params[:id])
  end
  def destroy
    @feed.destroy
    redirect_to root_path
  end

  private

    def authorized_user
      @feed = Feed.find(params[:id])
      redirect_to root_path unless current_user==(@feed.user)
    end
    def feed_param
     params.require(:feed).permit(:title, :url)
    end
end

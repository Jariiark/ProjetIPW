class FeedsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :show,:update,:edit]
  before_filter :authorized_user, :only => [:destroy, :edit, :show, :update]
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  def index  
    @feeds=Feed.all if signed_in?
    @feeds = Feed.paginate(:page => params[:page], :per_page =>7)
  end
  def new
   @feed=Feed.new
  end
  def show
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
  
  def update
    respond_to do |format|
      if @feed.update(feed_param)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:feed).permit(:title, :url,:description)
    end
    def set_feed
      @feed = Feed.find(params[:id])
    end
end

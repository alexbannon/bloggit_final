class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    if session[:is_signed_in]
      @post = Post.new
      @user = User.find(params[:user_id])
    else
      flash[:not_signed_in] = "You need to sign in to create a post!"
      redirect_to "/"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    if !session[:is_signed_in]
      flash[:not_signed_in] = "You need to sign in to create a post!"
      redirect_to "/"
    else
      @user = User.find(params[:user_id])
      @post = Post.create!(post_params)
      redirect_to user_post_path(@user, @post)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :post_content, :user_id)
  end
end

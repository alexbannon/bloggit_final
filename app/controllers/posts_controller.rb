class PostsController < ApplicationController

  def all_posts
    @posts = Post.all
  end

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
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    @comment = Comment.new
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

  def edit
    if session[:user_id].to_i == params[:user_id].to_i
      @post = Post.find(params[:id])
      @user = User.find(params[:user_id])
    else
      flash[:not_signed_in] = "You are not authorized to edit this post."
      redirect_to "/"
      return
    end
  end

  def update
    if session[:user_id].to_i == params[:user_id].to_i
      @user = User.find(params[:user_id])
      @post = Post.find(params[:id])
      @post.update(post_params)
      redirect_to user_post_path(@user, @post)
      return
    else
      flash[:not_signed_in] = "You are not authorized to edit this post."
      redirect_to "/"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(session[:user_id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :post_content, :user_id)
  end
end

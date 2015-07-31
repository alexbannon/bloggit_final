class CommentsController < ApplicationController

  def create
    if !session[:is_signed_in]
      flash[:message] = "You need to sign in to create a comment!"
    elsif params[:comment_content] == ""
      flash[:message] = "Comments cannot be blank"
    else
      @user = User.find(params[:user_id])
      @comment = Comment.create!(comment_content: params[:comment_content], user_id: session[:user_id], post_id: params[:post_id])
      redirect_to user_post_path(@user, params[:post_id])
      return
    end
    redirect_to :back
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@user, params[:post_id])
  end
end

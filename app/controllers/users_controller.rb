class UsersController < ApplicationController
  # TODO: before_filter :ensure_correct_user, only: [:edit}

  def show
    if params[:id].to_i == session[:user_id].to_i
      @user = User.find(session[:user_id])
    else
      @user = User.find(params[:id])
      flash[:message] = "You must be signed in as #{@user.username} to access this page"
      redirect_to "/"
    end
  end

  def username_home
    if User.find_by(username: params[:username])
      @user = User.find_by(username: params[:username])
      redirect_to user_posts_path(@user)
    else
      flash[:message] = "username not found"
      redirect_to "/"
    end
  end

  def homepage
  end

  def new
  end

  def index
  end

  def create
    # TODO: move logic to User validations
    if params[:user][:username] == "" || params[:user][:password_digest] == "" || params[:user][:email] == ""
      message = "fields cannot be blank."
    else
      if User.find_by(username: params[:user][:username])
        message = "username already exists"
      else
        User.create!(username: params[:user][:username], password_digest: BCrypt::Password.create(params[:user][:password_digest].strip), email: params[:user][:email])
        cookies[:username] = params[:user][:username]
        session[:is_signed_in] = true
        session[:user_id] = User.find_by(username: params[:user][:username]).id
        redirect_to "/"
        return
      end
    end
    flash[:message] = message
    redirect_to :back
  end

  def update
    if params[:user][:username] == "" || params[:user][:password_digest] == "" || params[:user][:email] == ""
      message = "fields cannot be blank."
    else
      if !session[:user_id].to_i == params[:id].to_i
        message = "Error: Not logged in. How did you even get here? Tisk tisk."
      else
        @user = User.find(session[:user_id].to_i)
        @user.update!(username: params[:user][:username], password_digest: BCrypt::Password.create(params[:user][:password_digest].strip), email: params[:user][:email])
        redirect_to user_posts_path(@user)
        return
      end
    end
    flash[:message] = message
    redirect_to :back
  end

  def sign_in_page
  end

  def sign_in
    if params[:user][:username].strip == "" || params[:user][:password_digest].strip == ""
      message = "fields cannot be blank"
    else
      if !User.find_by(username: params[:user][:username])
        message = "username not found."
      else
        @user = User.find_by(username: params[:user][:username])
        decoded_hash = BCrypt::Password.new(@user.password_digest)
        if decoded_hash.is_password?(params[:user][:password_digest]) == false
          message = "Your password's wrong!"
        else
          cookies[:username] = params[:user][:username]
          session[:is_signed_in] = true
          session[:user_id] = User.find_by(username: params[:user][:username]).id
          redirect_to user_posts_path(session[:user_id])
          return
        end
      end
    end
    flash[:message] = message
    redirect_to :back
  end

  def sign_out
    reset_session
    redirect_to root_url
  end

end

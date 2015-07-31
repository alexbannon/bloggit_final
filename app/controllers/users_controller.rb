class UsersController < ApplicationController

  def show

  end

  def new
  end

  def index
  end

  def create
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
    flash[:sign_in_message] = message
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
          redirect_to "/"
          return
        end
      end
    end
    flash[:sign_in_message] = message
    redirect_to "/"
  end

  def sign_out
    reset_session
    redirect_to root_url
  end

end

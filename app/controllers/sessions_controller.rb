class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    # If user exists AND password is correct
    if @user && @user.authenticate(params[:password])
      # Save user ID inside cookie.
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # If user info incorrect, send them back to login form
      render :new
    end
  end

  # remove cookie and send user back to login page
  def destroy
    session[:user_id] = nil
    render :new
  end
end

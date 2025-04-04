class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    # If user exists AND password is correct
    if @user && @user.authenticate(params[:password])
      # Save user ID inside cookie.
      session[:user_id] = @user.id
      puts "Session set: #{session[:user_id]}"
      redirect_to root_path
    else
      # If user info incorrect, send them back to login form
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  # remove cookie and send user back to login page
  def destroy
    session[:user_id] = nil
    redirect_to new_login_path
  end
end

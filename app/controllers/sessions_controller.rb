class SessionsController < ApplicationController
  include SessionsHelper

  before_action :redirect_if_logged_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])

    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      @user = User.new(session_params)
      render :new
    end
  end

  def destroy
    log_out!
  end
end

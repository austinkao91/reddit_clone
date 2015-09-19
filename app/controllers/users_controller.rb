class UsersController < ApplicationController
  include UsersHelper

  def new
    @user = User.new
    render :new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to subs_url #temporary
    else
      flash.now["errors"] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to subs_url
    else
      flash.now["errors"] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_url #temporary
  end
end

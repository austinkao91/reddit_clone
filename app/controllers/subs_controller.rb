class SubsController < ApplicationController
  include SubsHelper

  before_action :valid_user?, only: [:edit, :update]
  before_action :redirect_if_not_logged_in

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = current_user.subs.new
    render :new
  end

  def create
    @sub = current_user.subs.new(subs_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub
      if @sub.update(subs_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        @sub = Sub.find(params[:id])
        render :edit
      end
    else
      flash.now[:errors] << "Sub doesn't exist!"
      @subs = Sub.all
      render :index
    end
  end

  def show
    @sub = Sub.find(params[:id])
    if @sub
      render :show
    else
      flash.now[:errors] << "Sub doesn't exist!"
      render :index
    end
  end

  private
  def valid_user?
    @sub = Sub.find(params[:id])
    if current_user.id != @sub.user_id
      flash.now["errors"] = ["Only the moderator may edit this sub"]
      redirect_to sub_url(@sub)
    end
  end
end

class PostsController < ApplicationController
  include PostsHelper
  before_action :redirect_if_not_logged_in
  before_action :valid_user?, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :edit
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments
    if @post
      render :show
    else
      flash.now[:errors] = ["Post could not be found!"]
      redirect_to subs_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to subs_url
    end
  end
  private

  def valid_user?
    @post = Post.find(params[:id])

    if current_user.id != @post.user_id
      flash.now[:errors] = ["Unauthorized User"]
      redirect_to subs_url
    end
  end
end

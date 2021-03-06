class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.includes(:followers, :followed_users).all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.followed_users

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def new
  	@user = User.new
  end
  def show
    @user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
  end
  def create
  	@user=User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Blog app!"
  		redirect_to user_path(@user)
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def index
    @user = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Delete Successfully"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  
  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end

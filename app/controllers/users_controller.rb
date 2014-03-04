class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to root_url
      flash[:danger] = 'Please log-out before trying to sign up'
    else
  	  @user = User.new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user 
      flash[:notice] = "Welcome to GameOn! Frag On!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
  user = User.find(params[:id])
    if (current_user? user) && (current_user.admin?)
      flash[:danger] = "You are not allowed to delete yourself as an admin."
    else
      user.destroy
      flash[:notice] = "User destroyed. name: #{user.name} | email: #{user.email}"
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

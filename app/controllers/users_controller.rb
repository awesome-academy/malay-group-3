class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.order(:name).page params[:page]
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info_mail"
      redirect_to root_path
    else
      flash.now[:danger] = t ".fail_mess_create"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      redirect_to @user
      flash[:success] =  t ".success"
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
     flash[:success] =  t ".success"
   else
     flash[:warning] = t ".fail"
   end
   redirect_to users_path
 end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "users.user_not_found"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t  "users.update.login"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

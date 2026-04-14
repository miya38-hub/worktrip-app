class Public::UsersController < Public::ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :require_authentication, except: [:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user)
      redirect_to user_path(@user), notice: "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @spots = @user.spots.includes(:comments, :reviews)

    @favorites = []
    @reviews = []
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)

    terminate_session
    redirect_to new_user_path, notice: "退会しました"
  end

  private

  def ensure_correct_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :profile_image)
  end
end
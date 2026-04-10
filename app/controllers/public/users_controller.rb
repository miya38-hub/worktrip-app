class Public::UsersController < Public::ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

      start_new_session_for(@user)

      redirect_to root_path, notice: "登録しました"
    else
      render :new
    end
  end

  def show
    @user = current_user
    @spots = @user.spots

    @favorites = []
    @reviews = []
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :profile_image)
  end
end

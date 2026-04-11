class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: [:new, :create, :guest_login]

  skip_before_action :verify_authenticity_token, only: [:guest_login]

  def new
  end

  def create
    user = User.find_by(email_address: params[:email])

    if user&.authenticate(params[:password]) && user.is_active
      start_new_session_for(user)
      redirect_to spots_path, notice: "ログインしました"
    else
      flash[:alert] = "メールアドレスまたはパスワードが違います"  # ← ここ変更🔥
      redirect_to new_session_path
    end
  end

  def guest_login
    user = User.guest
    start_new_session_for(user)
    redirect_to spots_path, notice: "ゲストログインしました"
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end

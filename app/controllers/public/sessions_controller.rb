class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email_address: params[:email])

    if user&.authenticate(params[:password])
      start_new_session_for(user)
      
      redirect_to root_path, notice: "ログイン成功"
    else
      flash[:alert] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end

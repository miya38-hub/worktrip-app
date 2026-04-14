class Admin::SessionsController < Admin::ApplicationController

  def new
  end

  def create
    admin = Admin.find_by(email_address: params[:email_address])

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_spots_path, notice: "管理者ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to admin_login_path, notice: "ログアウトしました"
  end
end
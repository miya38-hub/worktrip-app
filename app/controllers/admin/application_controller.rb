class Admin::ApplicationController < ActionController::Base
  layout "admin"

  helper_method :current_admin, :admin_logged_in?

  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  def admin_logged_in?
    current_admin.present?
  end

  def require_admin
    redirect_to admin_login_path, alert: "管理者ログインが必要です" unless admin_logged_in?
  end
end
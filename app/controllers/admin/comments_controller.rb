class Admin::CommentsController < Admin::ApplicationController
  before_action :require_admin

  def index
    @comments = Comment.includes(:user, :spot).order(created_at: :desc)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました"
  end
end
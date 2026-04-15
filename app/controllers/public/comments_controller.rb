class Public::CommentsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot
  before_action :set_comment, only: [:update, :destroy]
  before_action :ensure_correct_user, only: [:update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.spot_id = @spot.id

    if @comment.save
      redirect_to spot_path(@spot), notice: "コメントを投稿しました"
    else
      @reviews = @spot.reviews.includes(:user).order(created_at: :desc)
      @comments = @spot.comments.includes(:user).order(created_at: :desc)
      render "public/spots/show", status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to spot_path(@spot), notice: "コメントを更新しました"
    else
      @reviews = @spot.reviews.includes(:user).order(created_at: :desc)
      @comments = @spot.comments.includes(:user).order(created_at: :desc)
      render "public/spots/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to spot_path(@spot), notice: "コメントを削除しました"
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def set_comment
    @comment = @spot.comments.find(params[:id])
  end

  def ensure_correct_user
    unless @comment.user == current_user
      redirect_to spot_path(@spot), alert: "権限がありません"
    end
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
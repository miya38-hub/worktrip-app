class Public::SearchesController < Public::ApplicationController
  before_action :require_authentication

  def search
    @range = params[:range]
    @word  = params[:word]
    @match = params[:match]

    if @range == "User"
      @users = search_users(@word, @match)
    elsif @range == "Spot"
      @spots = search_spots(@word, @match)
    end
  end

  private

  def search_users(word, match)
    case match
    when "perfect_match"
      User.where(name: word)
    when "forward_match"
      User.where("name LIKE ?", "#{escape_like(word)}%")
    when "backward_match"
      User.where("name LIKE ?", "%#{escape_like(word)}")
    when "partial_match"
      User.where("name LIKE ?", "%#{escape_like(word)}%")
    else
      User.all
    end
  end

  def search_spots(word, match)
    case match
    when "perfect_match"
      Spot.where(name: word)
    when "forward_match"
      Spot.where("name LIKE ?", "#{escape_like(word)}%")
    when "backward_match"
      Spot.where("name LIKE ?", "%#{escape_like(word)}")
    when "partial_match"
      Spot.where("name LIKE ?", "%#{escape_like(word)}%")
    else
      Spot.all
    end
  end

  def escape_like(word)
    ActiveRecord::Base.sanitize_sql_like(word.to_s)
  end
end
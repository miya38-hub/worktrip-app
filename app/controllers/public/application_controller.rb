class Public::ApplicationController < ApplicationController

  helper_method :current_user

  private

  def current_user
    Current.session&.user
  end
end
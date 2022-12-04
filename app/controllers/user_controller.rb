# frozen_string_literal: true

class UserController < SessionController
  def profile
    @user = User.find(session[:current_user_id])
  end

  def articles
    user = User.find(session[:current_user_id])
    @ratings = user.ratings.where({ user_id: user.id })
  end
end

class UsersController < ApplicationController
  def show
    @user = current_user
    @participant = Participant.new(user: @user)
  end

  def update
    current_user.update(update_params)
    redirect_to current_user
  end

  def update_params
    params.require(:user).permit(:time_zone)
  end
end
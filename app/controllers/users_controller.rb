class UsersController < ApplicationController
  def show
    @user = current_user
    @participant = Participant.new(user: @user)
  end
end
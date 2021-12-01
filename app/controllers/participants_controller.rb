class ParticipantsController < ApplicationController
  def create
    @participant = Participant.new(create_params)
    if @participant.save
      @user = current_user
      @participant = Participant.new(user: @user)
      render turbo_stream: turbo_stream.replace(:user, template: "users/show")
    else
      @user = current_user
      render turbo_stream: turbo_stream.replace(:user, template: "users/show"), status: :unprocessable_entity
    end
  end

  def create_params
    params.require(:participant).permit(:name, :user_id, :age_at_creation)
  end
end
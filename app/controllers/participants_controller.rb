class ParticipantsController < ApplicationController
  def create
    @participant = Participant.new(create_params)
    if @participant.save
      redirect_to user_path(@participant.user)
    else
    end
  end

  def create_params
    params.require(:participant).permit(:name, :user_id)
  end
end
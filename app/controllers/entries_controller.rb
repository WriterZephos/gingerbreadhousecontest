class EntriesController < ApplicationController
  before_action :ensure_contest
  before_action :ensure_participant, only: [:select_participant]
  
  def new
    unless @contest.accepting_entries? && logged_in?
      redirect_to contest_path(@contest)
    end
  end

  def select_participant
    unless @contest.accepting_entries? && logged_in?
      redirect_to contest_path(@contest)
    end

    @entry = Entry.new(participant: @participant, contest: @contest)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:entry_form, partial: "entries/form") }
    end
  end

  def create
    @entry = Entry.new(create_params)
    if @entry.save
      redirect_to contest_path(@contest)
    else
    end
  end

  def new_params
    params.permit(:contest_id)
  end

  def create_params
    params.require(:entry).permit(:contest_id, :participant_id, :title, :description, images: [])
  end

  def ensure_contest
    @contest = Contest.find(params[:contest_id])
  end

  def ensure_participant
    @participant = Participant.find(params[:participant_id])
  end
end
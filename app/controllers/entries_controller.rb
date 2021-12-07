class EntriesController < ApplicationController
  before_action :ensure_contest
  before_action :ensure_participant, only: [:select_participant, :create]
  
  def new
    unless @contest.accepting_entries? && logged_in?
      flash[:error] = "Entries are no longer accepted for #{@contest.name} or you are not logged in."
      redirect_to contest_path(@contest)
      return
    end
    render :select_participant
  end

  def select_participant
    unless @contest.accepting_entries? && logged_in?
      flash[:error] = "Entries are no longer accepted for #{@contest.name} or you are not logged in."
      redirect_to contest_path(@contest)
      return
    end

    @entry = Entry.new(participant: @participant, contest: @contest)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:entry_form, partial: "entries/form") }
    end
  end

  def create
    @entry = Entry.new(create_params)
    if @entry.save
      flash[:notice] = "Your entry was submitted successfully."
      redirect_to contest_path(@contest)
      return
    else
      flash[:error] = "There was an error."
      render :new
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
    @participant = Participant.find(params[:participant_id] || create_params[:participant_id])
  end
end
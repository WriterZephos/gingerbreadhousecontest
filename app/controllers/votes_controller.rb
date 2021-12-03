class VotesController < ApplicationController
  before_action :ensure_contest
  before_action :ensure_participant, only: [:select_participant, :create]

  def new
    unless @contest.voting_active? && logged_in?
      flash[:error] = "Voting is closed for #{@contest.name} or you are not logged in."
      redirect_to contest_path(@contest)
      return
    end
    render :select_participant
  end

  def select_participant
    unless @contest.voting_active? && logged_in?
      flash[:error] = "Voting is closed for #{@contest.name} or you are not logged in."
      redirect_to contest_path(@contest)
      return
    end
    @entries = @contest.entries.where.not(participant: @participant)
    @ranks = 1..@entries.count
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:vote_form, partial: "votes/form") }
    end
  end

  def create
    unless @contest.voting_active? && logged_in?
      flash[:error] = "Voting is closed for #{@contest.name} or you are not logged in."
      redirect_to contest_path(@contest)
      return
    end

    if @contest.votes.where(participant: @participant).any?
      flash[:error] = "That participant has already voted in #{@contest.name}."
      redirect_to contest_path(@contest)
      return
    end

    @entries = @contest.entries.where.not(participant: @participant)
    @entries.each do |entry|
      rank = params["entry_#{entry.id}_rank".to_sym].to_i
      entry.rank(@participant,rank)
    end

    own_entry = @contest.entries.where(participant: @participant).first

    if own_entry.present?
      own_entry.rank(@participant, @entries.count + 1)
    end

    redirect_to contest_path(@contest)
  end

  def ensure_contest
    @contest = Contest.find(params[:contest_id])
  end

  def ensure_participant
    @participant = Participant.find(params[:participant_id])
  end
end
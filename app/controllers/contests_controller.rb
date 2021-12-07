class ContestsController < ApplicationController
  def show
    @contest = Contest.find(params[:id])
    @entries =  if @contest.voting_ended?
                  @contest.rank_entries
                elsif @contest.voting_active?
                  @contest.entries
                elsif logged_in?
                  @contest.entries.where(participant: current_user.participants)
                else
                  []
                end
  end

  def new
    @contest ||= Contest.new
  end

  def create
    @contest = Contest.new(create_params)
    if @contest.save
      @entries =  if @contest.voting_ended?
        @contest.rank_entries
      else
        @contest.entries
      end
      redirect_to(@contest)
    else
      render :new, status: 422
    end
  end

private

  def create_params
    params.require(:contest).permit(:name, :age_limit, :min_age_limit, :vote_start_date, :vote_end_date)
  end
end
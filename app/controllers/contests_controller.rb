class ContestsController < ApplicationController
  def show
    @contest = Contest.find(params[:id])
    @entries =  if @contest.voting_ended?
                  @contest.rank_entries
                else
                  @contest.entries
                end
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = Contest.new(create_params)
    if @contest.save
      @entries =  if @contest.voting_ended?
        @contest.rank_entries
      else
        @contest.entries
      end
      render :show
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

private

  def create_params
    params.require(:contest).permit(:name, :year, :age_limit, :vote_start_date, :vote_end_date)
  end
end
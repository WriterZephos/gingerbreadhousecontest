class RankList
  def initialize(contest, participant)
    @contest = contest
    @participant = participant
    @ranks = @contest.votes.where(participant: @participant).order(:rank)
  end

  def tally(tally)
    @ranks.each do |vote|
      if tally[vote.entry_id].present?
        tally[vote.entry_id] += 1
        return
      end
    end
  end

  def rank_score(rank)
    case rank
    when 1
      1000
    end
  end
end
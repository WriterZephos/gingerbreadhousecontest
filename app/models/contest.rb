class Contest < ApplicationRecord
  has_many :entries
  has_one :winning_entry, :class_name => "Entry"
  has_many :votes, through: :entries

  before_validation :set_year
  
  validates :vote_start_date, presence: true
  validates :vote_end_date, presence: true
  validates :year, presence: true
  validates :name, presence: true

  def set_year
    return if self.persisted?
    self.year = Date.today.year
  end

  def get_winners
    if votes.any?
      entries.map { |e| [e, e.votes.sum(&:rank)] }.group_by(&:last).sort_by {|k,v| k}.first.last.map(&:first)
    end
  end

  def has_entry_from(participant)
    entries.where(participant_id: participant.id).any?
  end

  def has_vote_from(participant)
    votes.where(participant_id: participant.id).any?
  end

  def accepting_entries?
    Time.zone.now < vote_start_date
  end

  def voting_active?
    Time.zone.now > vote_start_date && Time.zone.now < vote_end_date
  end

  def voting_ended?
    Time.zone.now > vote_end_date
  end

  def rank_entries
    return [[]] if entries.blank?

    tallies = {}
    entries.each do |entry|
      tallies[entry.id] = 0
    end

    votes.each do |vote|
      tallies[vote.entry_id] += vote.rank
    end

    sorted_tally = tallies.sort_by { |_, v| v }

    ranks = []
    lowest_score = sorted_tally.first[1]
    rank = 0

    sorted_tally.each do |tally|
      entry = Entry.find(tally[0])
      if tally[1] != lowest_score
        lowest_score = tally[1]
        rank += 1
      end
      ranks[rank] ||= []
      ranks[rank] << entry
    end
    ranks
  end
end
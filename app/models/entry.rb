class Entry < ApplicationRecord

  belongs_to :contest
  belongs_to :participant
  has_many :votes

  has_many_attached :images
  has_rich_text :description

  attr_accessor :rank

  validates :participant, presence: true
  validates :contest, presence: true
  validates :title, presence: true

  def rank(participant, rank)
    Vote.create(entry: self, participant: participant, rank: rank)
  end

  def tally_votes(rank)
    votes.where(rank: rank).count
  end
end
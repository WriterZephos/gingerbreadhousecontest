class Participant < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :entries

  def get_votes(entries, rank)
    votes.where(entry: entries, rank: ranks)
  end
end
class Vote < ApplicationRecord
  belongs_to :participant
  belongs_to :entry

  validates :participant, presence: true
  validates :entry, presence: true
  validates :rank, presence: true
end
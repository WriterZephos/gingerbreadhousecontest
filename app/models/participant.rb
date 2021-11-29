class Participant < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :entries

  def can_enter_in(contest)
    result = !contest.has_entry_from(self)
    if contest.age_limit.present?
      result &&= (birthday + contest.age_limit.years) > Date.today
    end
    result
  end
end
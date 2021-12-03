class Participant < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :entries

  validates :name, presence: true
  validates :age_at_creation, presence: true

  def can_enter_in(contest)
    result = !contest.has_entry_from(self)

    if contest.age_limit.present?
      result &&= age < contest.age_limit
    end

    if contest.min_age_limit.present?
      result &&= age >= contest.min_age_limit
    end
    
    result
  end

  def age
    year_difference = Date.today.year - created_at.year
    age_at_creation + year_difference
  end
end
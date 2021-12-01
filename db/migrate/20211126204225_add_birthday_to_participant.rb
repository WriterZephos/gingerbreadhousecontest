class AddBirthdayToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :age_at_creation, :integer, null: false
  end
end

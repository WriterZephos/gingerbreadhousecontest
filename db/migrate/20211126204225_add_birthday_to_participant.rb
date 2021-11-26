class AddBirthdayToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :birthday, :date, null: false
  end
end

class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :rank
      t.belongs_to :participant, index: true
      t.belongs_to :entry, index: true
      t.timestamps
    end
  end
end

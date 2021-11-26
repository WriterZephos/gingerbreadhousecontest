class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.belongs_to :participant, index: true
      t.belongs_to :user, index: true
      t.belongs_to :contest, index: true
      t.timestamps
    end

    add_index :entries, [:contest_id, :participant_id], unique: true
  end
end

class CreateContests < ActiveRecord::Migration[7.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.string :year
      t.string :status
      t.datetime :vote_start_date
      t.datetime :vote_end_date
      t.references :winning_entry, index: true, foreign_key: { to_table: :entries }
      t.timestamps
    end
  end
end
class AddMinAgeLimitToContest < ActiveRecord::Migration[7.0]
  def change
    add_column :contests, :min_age_limit, :integer, null: true
  end
end

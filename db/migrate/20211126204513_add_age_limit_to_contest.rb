class AddAgeLimitToContest < ActiveRecord::Migration[7.0]
  def change
    add_column :contests, :age_limit, :integer
  end
end

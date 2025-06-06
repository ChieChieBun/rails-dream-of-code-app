class RemoveMentorFromSubmissions < ActiveRecord::Migration[8.0]
  def change
    remove_column :submissions, :mentor_id, :integer
  end
end

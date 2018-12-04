class AddMoodToJournalEntry < ActiveRecord::Migration
  def change
    add_column :journal_entries, :mood, :string, default: "happy"
  end
end

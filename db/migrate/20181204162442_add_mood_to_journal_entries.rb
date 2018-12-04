class AddMoodToJournalEntries < ActiveRecord::Migration
  def change
    add_column :journal_entries, :mood, :string
  end
end

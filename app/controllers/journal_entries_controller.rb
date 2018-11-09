class JournalEntriesController < ApplicationController

  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    erb :'/journal_entries/new'
  end

  # post journal_entries to create a new journal entry
  post '/journal_entries' do

  end

  # show route for a journal entry

  # index route for all journal entries
end

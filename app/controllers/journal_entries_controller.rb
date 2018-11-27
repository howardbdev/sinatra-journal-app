class JournalEntriesController < ApplicationController

  get '/journal_entries' do
    @journal_entries = JournalEntry.all
    erb :'journal_entries/index'
  end

  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    redirect_if_not_logged_in
    erb :'/journal_entries/new'
  end

  # post journal_entries to create a new journal entry
  post '/journal_entries' do
    redirect_if_not_logged_in
    # I want to create a new journal entry and save it to the DB
    # I also only want to create a journal entry if a user is logged in
    # I only want to save the entry if it has some content
    if params[:content] != ""
      # create a new entry
      flash[:message] = "Journal entry successfully created."
      @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
      redirect "/journal_entries/#{@journal_entry.id}"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/journal_entries/new'
    end
  end

  # show route for a journal entry
  get '/journal_entries/:id' do
    set_journal_entry
    erb :'/journal_entries/show'
  end


  # *** MAJOR PROBLEMS!!! ***
  # 1. RIGHT NOW, ANYONE CAN EDIT ANYONE ELSE'S JOURNAL ENTRIES!!!!
  # 2. ALSO, I CAN EDIT A JOURNAL ENTRY TO BE BLANK!!!!!

  # This route should send us to journal_entries/edit.erb, which will
  # render an edit form
  get '/journal_entries/:id/edit' do
    redirect_if_not_logged_in
    set_journal_entry
    if authorized_to_edit?(@journal_entry)
      erb :'/journal_entries/edit'
    else
      redirect "users/#{current_user.id}"
    end
  end

  # This action's job is to ...???
  patch '/journal_entries/:id' do
    redirect_if_not_logged_in
    # 1. find the journal entry
    set_journal_entry
    if @journal_entry.user == current_user && params[:content] != ""
    # 2. modify (update) the journal entry
      @journal_entry.update(content: params[:content])
      # 3. redirect to show page
      redirect "/journal_entries/#{@journal_entry.id}"
    else
      redirect "users/#{current_user.id}"
    end
  end

  delete '/journal_entries/:id' do
    set_journal_entry
    if authorized_to_edit?(@journal_entry)
      @journal_entry.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect '/journal_entries'
    else
      redirect '/journal_entries'
    end
  end
  # index route for all journal entries

  private

  def set_journal_entry
    @journal_entry = JournalEntry.find(params[:id])
  end
end

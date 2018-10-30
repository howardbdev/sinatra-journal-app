class UsersController < ApplicationController

  # what routes do I need for login?

  # the purpose of this route is to render the login page (form)
  get '/login' do
    erb :login
  end

  # what routes do I need for signup?
  get '/signup' do

  end

end

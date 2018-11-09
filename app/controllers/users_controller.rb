class UsersController < ApplicationController

  # what routes do I need for login?

  # the purpose of this route is to render the login page (form)
  get '/login' do
    erb :login
  end

  # the purpose of this route is to receive the login form,
  # find the user, and log the user in (create a session)
  post '/login' do
    # params looks like: {email: "user@user.com", password: "password"}
    # Find the user
    @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are
    # they have the credentials - email/password combo
    if @user.authenticate(params[:password])
      # log the user in - create the user session
      session[:user_id] = @user.id # actually logging the user in
      # redirect to the user's show page
      puts session
      redirect "users/#{@user.id}"
    else
      # tell the user they entered invalid credentials
      # redirect them to the login page
    end
  end

  # what routes do I need for signup?
  # this route's job is to render the signup form
  get '/signup' do
    # erb (render) a view
    erb :signup
  end

  post '/users' do
    # here is where we will create a new user and persist the new
    # user to the DB
    # params will look like this:
    # {
    #   "name"=>"Elizabeth",
    #   "email"=>"elizabeth@e.com",
    #   "password"=>"password"
    # }
    # I only want to persist a user that has a name, email, AND password
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      # valid input
      @user = User.create(params)
      session[:user_id] = @user.id # actually logging the user in
      # where do I go now?
      # let's go to the user show page
      redirect "/users/#{@user.id}"
    else
      # not valid input
      # it would be better to include a message to the user
      # telling them what is wrong
      redirect '/signup'
    end
  end

  # user SHOW route
  get '/users/:id' do
    # what do I need to do first?
    @user = User.find_by(id: params[:id])

    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end

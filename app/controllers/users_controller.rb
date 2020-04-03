class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else 
            erb :'/users/login'
        end
    end 

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect "users/#{@user.id}"
        else
           redirect '/login'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        if logged_in? && @user == current_user
            erb :'/users/show'
        else 
            redirect to '/login'
        end 
    end

    get '/signup' do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else 
            erb :'/users/create'
        end
    end 

    post '/signup/' do
        @user = User.new(params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect "users/#{@user.id}"
        else
            redirect to '/signup'
        end 
    end 
end 
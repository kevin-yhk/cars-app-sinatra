class CarsController < ApplicationController
    get '/cars/new' do
        if logged_in?
            erb :'cars/create'
        else  
            redirect '/login'
        end 
    end 
end
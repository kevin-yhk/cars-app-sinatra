class CarsController < ApplicationController
    
    get '/cars' do
        if logged_in? 
            @current_user = current_user
            @cars = Car.select{|car|car.user_id == @current_user.id}
            erb :'/cars/index'
        else 
            redirect '/login'
        end 
    end
    
    get '/cars/new' do
        if logged_in?
            erb :'cars/create'
        else  
            redirect '/login'
        end 
    end 

    post '/cars' do 
        if logged_in?
            if params[:make] == "" || params[:model] == "" || params[:year] == "" || params[:trim] == ""
                redirect '/cars/new'
            else 
                @car = current_user.cars.create(make: params[:make], model: params[:model], year: params[:year], trim: params[:trim])
                if @car.save
                    redirect "/cars/#{@car.id}"
                else 
                    redirect '/cars/new'
                end 
            end
        else
            redirect '/login/'
        end 
    end 

    get '/cars/:id' do
        if logged_in?
          @car = Car.find_by_id(params[:id])
          erb :'cars/show'
        else
          redirect '/login'
        end
    end

    get '/cars/:id/edit' do
        if logged_in?
          @car = Car.find_by_id(params[:id])
          if @car && @car.user == current_user
            erb :'cars/edit'
          else
            redirect '/cars'
          end
        else
          redirect '/login'
        end
    end

    patch '/cars/:id' do
        if logged_in?
            @car = Car.find_by_id(params[:id])
            if @car.user == current_user && params[:make] != "" && params[:model] != "" && params[:year] != "" && params[:trim] != ""
                @car.update(make: params[:make], model: params[:model], year: params[:year], trim: params[:trim])
                redirect "/cars/#{@car.id}"
            else
                redirect "/cars/#{@car.id}/edit"
            end
        else 
            redirect '/login'
        end
    end

    delete '/cars/:id/delete' do
        if logged_in?
          @car = Car.find_by_id(params[:id])
          if @car && @car.user == current_user
            @car.delete
            redirect "/cars"
          else
            redirect "/login"
          end
        end
    end


end
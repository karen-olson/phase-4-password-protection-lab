class SessionsController < ApplicationController

    def create 
        user = User.find_by_username(params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else 
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end
    
    # find the user with their username
    # if there's a user and the result of calling authenticate on their password is truthy, 
    # set the user_id attribute of session to the user's id
    # render the user as a JSON string and set the status to created
    # otherwise, render an error
    # invalid username or password, status is unauthorized

    def destroy 
        session.delete :user_id
        head :no_content
    end
end

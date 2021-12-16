class UsersController < ApplicationController
before_action :authorize, only: [:show]
wrap_parameters format: []

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # def show
    #     user = User.find_by(id: session[:user_id])
    #     if user 
    #         render json: user 
    #     else 
    #         render json: {error: "Not authorized"}, status: :unauthorized
    #     end
    # end
        
    def show
        user = User.find_by(id: session[:user_id])
        render json: user
    end

    private

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end

class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @plans = @user.plans
    end

    def index
        @users = User.all
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
    end

    private

    def user_params
        params.require(:users).permit(:name)
    end
end

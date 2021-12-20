class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @plans = @user.plans
        @groups = @user.groups
    end

    def index
        @users = User.all
    end

    def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
            redirect_to user_path(@user.id)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.id != current_user.id
            redirect_to user_path(current_user)
        end
        if @user.update(user_params)
            redirect_to user_path(@user.id), notice:"ユーザーをアップデートしました。"
        else
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction, :color)
    end
end

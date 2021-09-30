class GroupsController < ApplicationController
    def index
        @groups = Group.all
    end

    def show
        @group = Group.find(params[:id])
        @users = @group.users
        if current_user.in?(@users)
            @plans = []
            @users.each do |user|
                user_plans = user.plans
                @plans.concat(user_plans)
                # user_plans.each do |user_plan|
                #     @plans.concat(user_plan)
                # end
            end
        else
            redirect_to groups_path, notice:'このグループに所属していません。'
        end
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            @group.users << current_user
            redirect_to root_path, notice:'succesfully created group'
        else
            render :new
        end
    end

    def edit
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
            redirect_to group_path(@group), notice: 'succressfullu updated'
        else
            render :edit
        end
    end

    def destroy
        group = Group.find(params[:id])
        group.destroy
        redirect_to groups_path
    end

    def join
        @group = Group.find(params[:id])
        current_user.groups << @group
        redirect_to group_path(@group)
    end

    def withdrawal
    end

    private
    def group_params
        params.require(:group).permit(:name, users_ids: [])
    end
end

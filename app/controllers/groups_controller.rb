class GroupsController < ApplicationController
    def index
        @groups = Group.all
        @group = Group.new
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

    def create
        @group = Group.new(group_params)
        if @group.save
            @group.users << current_user
            redirect_to group_path(@group), notice:'グループを作成しました！'
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
            redirect_to group_path(@group), notice: 'アップデート成功！'
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
        gr_temp = Group.new(group_params)
        @group = Group.find_by(name: gr_temp.name)
        # if @group&.authenticate(params[:password])
        if @group.password == gr_temp.password
            current_user.groups << @group
            redirect_to group_path(@group), notice: '加入しました！'
        else
            redirect_to groups_path, notice: '加入に失敗しました。'
        end
    end

    def withdrawal
    end

    private
    def group_params
        params.require(:group).permit(:password, :name, users_ids: [])
    end
end

class GroupsController < ApplicationController
    def create_group_plan
        @grplan = Grplan.new(plan_params)
        if @grplan.save
            redirect_to user_path(current_user), notice:'グループイベントを作成しました。'
        else
            redirect_to user_path(current_user), notice:'作成に失敗しました' 
        end
    end
    def index
        @groups = Group.all
        @group = Group.new
    end

    def show
        @group = Group.find(params[:id])
        @users = @group.users
        @grplan = Grplan.new
        $group_id = @group.id
        # @grplan.group_id = @group.id
        if current_user.in?(@users)
            @plans = []
            @users.each do |user|
                user_plans = user.plans
                @plans.concat(user_plans)
            end
            @grplans = @group.grplans
            # @plans.concat(@group.grplans)
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

    def destroy
        @group = Group.find(params[:id])
        @group.users.delete(current_user)
        redirect_to user_path(current_user), notice: '脱退しました。'
    end

    private
    def group_params
        params.require(:group).permit(:password, :name, users_ids: [])
    end
end

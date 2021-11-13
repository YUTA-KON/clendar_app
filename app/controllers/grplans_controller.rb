class GrplansController < ApplicationController
    def index
    end

    def show
        @plan = Grplan.find(params[:id])
        # if @grplan.user_id != current_user.id
        #     redirect_to user_path(current_user)
        # end
    end

    def create
        @grplan = Grplan.new(plan_params)
        @grplan.user_id = $group_id
        if @grplan.save
            redirect_to user_path(current_user), notice:'グループイベントを作成しました。'
        else
            redirect_to user_path(current_user), notice:'作成に失敗しました' 
        end
    end

    def edit
        @grplan = Grplan.find(params[:id])
    end

    def update
        @grplan = Grplan.find(params[:id])
        if @grplan.update(plan_params)
            redirect_to user_path(current_user), notice:"successfully updated."
        else
            render :edit
        end
    end

    def destroy
        @grplan = Grplan.find(params[:id])
        @grplan.destroy
        redirect_to user_path(current_user), notice:"successfully deleted"
    end

    protected
    def plan_params
        params.require(:grplan).permit(:title, :body, :start_time, :finish_time, :start_time_dow, :finish_time_dow, :ifrepeat, :dow)
    end
end

class TeamsController < ApplicationController
    before_action :authenticate_user!

    def new
        @team = Team.new
    end

    def edit
        @team = Team.find(params[:id])
    end

    def create 
        @team = Team.new(team_params)
    

        if @team.save
            if(@team.manager)
                @team.manager.team_id = @team.id
                @team.manager.is_manager = true
                @team.manager.save
            end
            redirect_to @team
        else
            render "/teams/new"
        end
    end

    def update
        @team = Team.find(params[:id])

        if(@team && @team.manager)
            @team.manager.team_id = nil
            @team.manager.is_manager = false
            @team.manager.save
        end

        if(@team && @team.update(team_params))
            if(@team.manager)
                @team.manager.team_id = @team.id
                @team.manager.is_manager = true
                @team.manager.save
            end
            
            redirect_to @team
        elsif(!@team)
            redirect_to @teams
        else
          render 'edit'
        end
    end

    def show
        @team = Team.find(params[:id])
    end

    def index
        @teams = Team.all
    end

    def destroy
        @team = Team.find(params[:id])
        if(@team && @team.manager)
            @team.manager.is_manager = false
            @team.manager.save
        end

        if(@team)
            @team.destroy
        end

        redirect_to teams_path
    end

    

    private

    def team_params
        params.require(:team).permit(:name,:manager_id,employee_ids: [])
    end
end

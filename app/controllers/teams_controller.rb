class TeamsController < ApplicationController
    before_action :authenticate_user!, unless: :admin_signed_in?, only: [:show, :index, :search]
    before_action :authenticate_admin!,except:[:show,:index,:search]

    def new
        @team = Team.new
    end

    def edit
        @team = Team.find(params[:id])
    end

    def create 
        @team = Team.new(team_params)
    
        if @team.save
            TeamManagerService.new(@team).set_manager
            redirect_to @team
        else
            render "/teams/new"
        end
    end

    def update
        @team = Team.find(params[:id])


        TeamManagerService.new(@team).remove_manager
        

        if(@team && @team.update(team_params))
            TeamManagerService.new(@team).set_manager
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

    def search
        @teams = Team.where("name LIKE ?","%" + params[:key] + "%")
    end

    def destroy
        @team = Team.find(params[:id])
        TeamManagerService.new(@team).remove_manager

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

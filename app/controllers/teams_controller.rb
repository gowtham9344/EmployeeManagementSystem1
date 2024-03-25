class TeamsController < ApplicationController
    before_action :must_login2,except:[:show,:index,:search]
    before_action :must_login1,only:[:show,:index,:search]

    def new
        @team = Team.new
    end

    def edit
        @team = Team.find_by(id: params[:id])
        
        if @team.nil?
            flash[:alert] = "No team available"
            redirect_to teams_path
        end
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
        @team = Team.find_by(id: params[:id])


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
        @team = Team.find_by(id: params[:id])
        if @team.nil?
            flash[:alert] = "No team available"
            redirect_to teams_path
        end
    end

    def index
        @teams = Team.all
    end

    def search
        @teams = Team.where("name LIKE ?","%" + params[:key] + "%")
    end

    def destroy
        @team = Team.find_by(id: params[:id])
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

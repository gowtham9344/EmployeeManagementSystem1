class TeamManagerService
    def initialize(team)
      @team = team
    end
  
    def remove_manager
        if(@team && @team.manager)
            @team.manager.update(team_id:nil,is_manager:false)
        end
    end

    def set_manager
        if(@team && @team.manager)
            @team.manager.update(team_id:@team.id,is_manager:true)
        end
    end
  end
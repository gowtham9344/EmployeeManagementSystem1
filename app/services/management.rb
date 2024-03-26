module Management
    class EmployeeManagerService
        def initialize(employee)
        @employee = employee
        end
    
        def assign_manager
        return unless @employee.is_manager?
    
        old_manager = @employee.team.manager
        old_manager.update(is_manager: false) if old_manager
    
        @employee.team.update(manager_id: @employee.id)
        end

        def change_manager(employee1,employee2)
            if(@employee.is_manager == true)
                if(employee2 && employee2.team_id == @employee.team_id)
                    employee2.update(is_manager:false)
                elsif(@employee.team.manager)
                    @employee.team.manager.update(is_manager:false)
                    if(employee2 && @employee.id != employee2.id)
                        employee2.team.update(manager_id:employee2.id)
                    end
                else
                    if(employee2 && @employee.id != employee2.id)
                        employee2.team.update(manager_id:employee2.id)
                    end
                end
                @employee.team.update(manager_id:@employee.id)
            else
                if(employee2 && @employee.id != employee2.id)
                    employee2.team.update(manager_id:employee2.id)
                end
            end
        end

        def remove_manager
            if(@employee && @employee.team)
                @employee.team.update(manager_id:nil)
            end
        end
    end

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
end
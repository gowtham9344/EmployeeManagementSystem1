class EmployeesController < ApplicationController
    before_action :authenticate_user!, unless: :admin_signed_in?, only: [:show, :index]
    before_action :authenticate_admin!,except:[:show,:index]

    def new
        @employee = Employee.new
    end

    def edit
        @employee = Employee.find(params[:id])
    end

    def create 
        @employee = Employee.new(employee_params)
       
        
        if @employee.save
            EmployeeManagerService.new(@employee).assign_manager
            redirect_to @employee
        else
            render 'new'
        end
    end

    def update
        @employee = Employee.find(params[:id])
        employee1 = Employee.find(params[:id])
        employee2 = employee1.team ? employee1.team.manager : nil

        EmployeeManagerService.new(@employee).remove_manager
       
        if(@employee && @employee.update(employee_params))
            EmployeeManagerService.new(@employee).change_manager(employee1,employee2)
            redirect_to @employee
        else
           render 'edit'
        end
    end

    def destroy
        @employee = Employee.find(params[:id])

        EmployeeManagerService.new(@employee).remove_manager

        if(@employee)
            @employee.destroy
        end
        
        redirect_to employees_path
    end

    def show
        @employee = Employee.find(params[:id])
    end

    def index
        @employees = Employee.all
    end

    private

    def employee_params
        params.require(:employee).permit(:name,:email,:address,:mobile, :team_id,:is_manager)
    end

    
end

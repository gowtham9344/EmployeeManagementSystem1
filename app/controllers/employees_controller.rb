class EmployeesController < ApplicationController
    before_action :must_login2,except:[:show,:index,:search]
    before_action :must_login1,only:[:show,:index,:search]

    def new
        @employee = Employee.new
    end

    def edit
        @employee = Employee.where.not(role: 'admin').find_by(id: params[:id])
        if(@employee.nil?)
            flash[:alert] = "No Employee available"
            redirect_to employees_path
        end
    end

    def create 
        @employee = Employee.new(employee_params)
    
        if @employee.save
            Management::EmployeeManagerService.new(@employee).assign_manager
            redirect_to @employee
        else
            render 'new'
        end
    end

    def update
        @employee = Employee.where.not(role: 'admin').find_by(id: params[:id])
        employee1 = Employee.where.not(role: 'admin').find_by(id: params[:id])
        employee2 = employee1.team ? employee1.team.manager : nil

        Management::EmployeeManagerService.new(@employee).remove_manager
       
        if(@employee && @employee.update(employee_params))
            Management::EmployeeManagerService.new(@employee).change_manager(employee1,employee2)
            redirect_to @employee
        else
           render 'edit'
        end
    end

    def destroy
        @employee = Employee.where.not(role: 'admin').find_by(id: params[:id])

        Management::EmployeeManagerService.new(@employee).remove_manager

        if(@employee)
            @employee.destroy
        end
        
        redirect_to employees_path
    end

    def show
        @employee = Employee.where.not(role: 'admin').find_by(id: params[:id])
        if(@employee.nil?)
            flash[:alert] = "No Employee available"
            redirect_to employees_path
        end
    end

    def index
        @employees = Employee.where.not(role: 'admin')
    end
      

    def search
        @employees = Employee.where.not(role: 'admin').where("name LIKE ? OR email LIKE ?", "%#{params[:key]}%", "%#{params[:key]}%")
    end

    private

    def employee_params
        params.require(:employee).permit(:name,:email,:address,:mobile, :team_id,:is_manager,:role)
    end
    
end

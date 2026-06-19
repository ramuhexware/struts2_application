package com.example.employee.action;

import com.opensymphony.xwork2.ActionSupport;
import com.example.employee.entity.Employee;
import com.example.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.stream.Collectors;

public class EmployeeAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    @Autowired
    private EmployeeService employeeService;

    private int id;
    private Employee employee;
    private List<Employee> employees;
    
    // Filters and Search
    private String searchQuery;
    private String deptFilter;
    private String statusFilter;

    // Action Methods

    // List employees (with Java 8 Stream filtering)
    public String list() {
        List<Employee> allEmployees = employeeService.getAllEmployees();
        
        employees = allEmployees.stream().filter(emp -> {
            boolean matchesSearch = true;
            boolean matchesDept = true;
            boolean matchesStatus = true;

            // Search query filter (matches name or email)
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = searchQuery.toLowerCase().trim();
                matchesSearch = emp.getName().toLowerCase().contains(query) 
                        || emp.getEmail().toLowerCase().contains(query);
            }

            // Department filter
            if (deptFilter != null && !deptFilter.trim().isEmpty() && !deptFilter.equalsIgnoreCase("All")) {
                matchesDept = emp.getDepartment().equalsIgnoreCase(deptFilter.trim());
            }

            // Status filter
            if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("All")) {
                matchesStatus = emp.getStatus().equalsIgnoreCase(statusFilter.trim());
            }

            return matchesSearch && matchesDept && matchesStatus;
        }).collect(Collectors.toList());

        return SUCCESS;
    }

    // View employee details
    public String detail() {
        if (id > 0) {
            employee = employeeService.getEmployeeById(id);
            if (employee == null) {
                addActionError("Employee with ID " + id + " not found.");
                return ERROR;
            }
        } else {
            addActionError("Invalid Employee ID.");
            return ERROR;
        }
        return SUCCESS;
    }

    // Add employee form initiation
    public String add() {
        employee = new Employee();
        employee.setStatus("Active"); // Default value
        return SUCCESS;
    }

    // Edit employee form initiation
    public String edit() {
        if (id > 0) {
            employee = employeeService.getEmployeeById(id);
            if (employee == null) {
                addActionError("Employee not found.");
                return ERROR;
            }
        }
        return SUCCESS;
    }

    // Save or update employee
    public String save() {
        if (employee == null) {
            addActionError("Invalid employee data.");
            return INPUT;
        }
        
        // Basic Validation
        if (employee.getName() == null || employee.getName().trim().isEmpty()) {
            addFieldError("employee.name", "Name is required.");
        }
        if (employee.getEmail() == null || employee.getEmail().trim().isEmpty()) {
            addFieldError("employee.email", "Email is required.");
        }
        if (employee.getDepartment() == null || employee.getDepartment().trim().isEmpty()) {
            addFieldError("employee.department", "Department is required.");
        }
        if (employee.getRole() == null || employee.getRole().trim().isEmpty()) {
            addFieldError("employee.role", "Role/Designation is required.");
        }
        if (employee.getSalary() <= 0) {
            addFieldError("employee.salary", "Salary must be greater than zero.");
        }
        if (employee.getJoiningDate() == null || employee.getJoiningDate().trim().isEmpty()) {
            addFieldError("employee.joiningDate", "Joining Date is required.");
        }

        if (hasFieldErrors() || hasActionErrors()) {
            return INPUT;
        }

        employeeService.saveEmployee(employee);
        return SUCCESS;
    }

    // Delete employee
    public String delete() {
        if (id > 0) {
            employeeService.deleteEmployee(id);
        }
        return SUCCESS;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employees) {
        this.employees = employees;
    }

    public String getSearchQuery() {
        return searchQuery;
    }

    public void setSearchQuery(String searchQuery) {
        this.searchQuery = searchQuery;
    }

    public String getDeptFilter() {
        return deptFilter;
    }

    public void setDeptFilter(String deptFilter) {
        this.deptFilter = deptFilter;
    }

    public String getStatusFilter() {
        return statusFilter;
    }

    public void setStatusFilter(String statusFilter) {
        this.statusFilter = statusFilter;
    }
}

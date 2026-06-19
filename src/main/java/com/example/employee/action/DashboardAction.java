package com.example.employee.action;

import com.opensymphony.xwork2.ActionSupport;
import com.example.employee.entity.Employee;
import com.example.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DashboardAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    @Autowired
    private EmployeeService employeeService;

    private int totalEmployees;
    private int activeEmployees;
    private int inactiveEmployees;
    private double averageSalary;
    
    private Map<String, Long> departmentCounts;
    private Map<String, Long> roleCounts;
    private List<Employee> recentHires;

    @Override
    public String execute() {
        List<Employee> allEmployees = employeeService.getAllEmployees();

        totalEmployees = allEmployees.size();

        // Calculate Active and Inactive counts
        activeEmployees = (int) allEmployees.stream()
                .filter(e -> "Active".equalsIgnoreCase(e.getStatus()))
                .count();

        inactiveEmployees = totalEmployees - activeEmployees;

        // Calculate Average Salary
        averageSalary = allEmployees.stream()
                .mapToDouble(Employee::getSalary)
                .average()
                .orElse(0.0);

        // Group by Department and count
        departmentCounts = allEmployees.stream()
                .collect(Collectors.groupingBy(Employee::getDepartment, Collectors.counting()));

        // Group by Role and count
        roleCounts = allEmployees.stream()
                .collect(Collectors.groupingBy(Employee::getRole, Collectors.counting()));

        // Get 5 most recent hires (sorted by joining date descending)
        recentHires = allEmployees.stream()
                .sorted((e1, e2) -> {
                    if (e1.getJoiningDate() == null && e2.getJoiningDate() == null) return 0;
                    if (e1.getJoiningDate() == null) return 1;
                    if (e2.getJoiningDate() == null) return -1;
                    return e2.getJoiningDate().compareTo(e1.getJoiningDate());
                })
                .limit(5)
                .collect(Collectors.toList());

        return SUCCESS;
    }

    // Getters and Setters

    public int getTotalEmployees() {
        return totalEmployees;
    }

    public void setTotalEmployees(int totalEmployees) {
        this.totalEmployees = totalEmployees;
    }

    public int getActiveEmployees() {
        return activeEmployees;
    }

    public void setActiveEmployees(int activeEmployees) {
        this.activeEmployees = activeEmployees;
    }

    public int getInactiveEmployees() {
        return inactiveEmployees;
    }

    public void setInactiveEmployees(int inactiveEmployees) {
        this.inactiveEmployees = inactiveEmployees;
    }

    public double getAverageSalary() {
        return averageSalary;
    }

    public void setAverageSalary(double averageSalary) {
        this.averageSalary = averageSalary;
    }

    public Map<String, Long> getDepartmentCounts() {
        return departmentCounts;
    }

    public void setDepartmentCounts(Map<String, Long> departmentCounts) {
        this.departmentCounts = departmentCounts;
    }

    public Map<String, Long> getRoleCounts() {
        return roleCounts;
    }

    public void setRoleCounts(Map<String, Long> roleCounts) {
        this.roleCounts = roleCounts;
    }

    public List<Employee> getRecentHires() {
        return recentHires;
    }

    public void setRecentHires(List<Employee> recentHires) {
        this.recentHires = recentHires;
    }
}

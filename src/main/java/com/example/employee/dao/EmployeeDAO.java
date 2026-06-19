package com.example.employee.dao;

import com.example.employee.entity.Employee;
import java.util.List;

public interface EmployeeDAO {
    List<Employee> getAllEmployees();
    void saveEmployee(Employee employee);
    Employee getEmployeeById(int id);
    void deleteEmployee(int id);
}

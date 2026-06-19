package com.example.employee.service.impl;

import com.example.employee.dao.EmployeeDAO;
import com.example.employee.entity.Employee;
import com.example.employee.service.EmployeeService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService, InitializingBean {

    @Autowired
    private EmployeeDAO employeeDAO;

    @Autowired
    private org.springframework.transaction.PlatformTransactionManager transactionManager;

    @Override
    public List<Employee> getAllEmployees() {
        return employeeDAO.getAllEmployees();
    }

    @Override
    public void saveEmployee(Employee employee) {
        employeeDAO.saveEmployee(employee);
    }

    @Override
    public Employee getEmployeeById(int id) {
        return employeeDAO.getEmployeeById(id);
    }

    @Override
    public void deleteEmployee(int id) {
        employeeDAO.deleteEmployee(id);
    }

    // Auto-seed database when Spring starts up
    @Override
    public void afterPropertiesSet() throws Exception {
        org.springframework.transaction.support.TransactionTemplate transactionTemplate = 
                new org.springframework.transaction.support.TransactionTemplate(transactionManager);
        
        transactionTemplate.execute(status -> {
            List<Employee> existing = employeeDAO.getAllEmployees();
            if (existing == null || existing.isEmpty()) {
                employeeDAO.saveEmployee(new Employee("Alice Vance", "alice.vance@company.com", "+1 (555) 019-2834", "Engineering", "Senior Architect", 125000.00, "2021-04-12", "Active"));
                employeeDAO.saveEmployee(new Employee("Bob Miller", "bob.miller@company.com", "+1 (555) 024-9182", "Engineering", "Software Engineer", 85000.00, "2023-01-15", "Active"));
                employeeDAO.saveEmployee(new Employee("Clara Oswald", "clara.o@company.com", "+1 (555) 091-8273", "HR", "HR Manager", 75000.00, "2020-11-01", "Active"));
                employeeDAO.saveEmployee(new Employee("David Tennant", "david.t@company.com", "+1 (555) 018-2736", "Marketing", "Marketing Director", 98000.00, "2019-06-18", "Active"));
                employeeDAO.saveEmployee(new Employee("Emma Watson", "emma.w@company.com", "+1 (555) 045-6789", "Finance", "Senior Accountant", 90000.00, "2022-08-24", "Active"));
                employeeDAO.saveEmployee(new Employee("Franklin Clinton", "franklin.c@company.com", "+1 (555) 056-7890", "Sales", "Sales Executive", 65000.00, "2023-05-10", "Active"));
                employeeDAO.saveEmployee(new Employee("Grace Hopper", "grace.h@company.com", "+1 (555) 067-8901", "Engineering", "Tech Lead", 115000.00, "2022-02-15", "Active"));
                employeeDAO.saveEmployee(new Employee("Henry Cavill", "henry.c@company.com", "+1 (555) 078-9012", "HR", "Recruiter", 60000.00, "2023-09-01", "Active"));
                employeeDAO.saveEmployee(new Employee("Iris West", "iris.w@company.com", "+1 (555) 089-0123", "Marketing", "PR Specialist", 70000.00, "2024-02-28", "Active"));
                employeeDAO.saveEmployee(new Employee("Jack Reacher", "jack.r@company.com", "+1 (555) 090-1234", "Security", "Security Lead", 80000.00, "2021-10-10", "Inactive"));
            }
            return null;
        });
    }
}

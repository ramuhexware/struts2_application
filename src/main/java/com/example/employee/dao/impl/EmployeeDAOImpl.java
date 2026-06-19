package com.example.employee.dao.impl;

import com.example.employee.dao.EmployeeDAO;
import com.example.employee.entity.Employee;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<Employee> getAllEmployees() {
        return getCurrentSession().createQuery("from Employee", Employee.class).list();
    }

    @Override
    public void saveEmployee(Employee employee) {
        getCurrentSession().saveOrUpdate(employee);
    }

    @Override
    public Employee getEmployeeById(int id) {
        return getCurrentSession().get(Employee.class, id);
    }

    @Override
    public void deleteEmployee(int id) {
        Employee employee = getEmployeeById(id);
        if (employee != null) {
            getCurrentSession().delete(employee);
        }
    }
}

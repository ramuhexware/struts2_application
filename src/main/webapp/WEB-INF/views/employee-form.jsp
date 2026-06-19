<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:if test="employee.id > 0">Edit Employee</s:if><s:else>Add Employee</s:else> - Employee Management</title>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Main Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <div class="logo">E</div>
            <div class="title">EmpManager</div>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="${pageContext.request.contextPath}/dashboard">
                    <i class="fa-solid fa-chart-pie"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/listEmployees">
                    <i class="fa-solid fa-users"></i> Employees
                </a>
            </li>
            <li class="<s:if test='employee.id == 0'>active</s:if>">
                <a href="${pageContext.request.contextPath}/addEmployee">
                    <i class="fa-solid fa-user-plus"></i> Add Employee
                </a>
            </li>
        </ul>
        <div class="sidebar-footer">
            &copy; 2026 EmpManager.<br>Java 8 & Struts 2
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-header" id="form-header">
            <div>
                <h1>
                    <s:if test="employee.id > 0">Edit Employee Profile</s:if>
                    <s:else>Add New Employee</s:else>
                </h1>
                <p>
                    <s:if test="employee.id > 0">Update profile details for <s:property value="employee.name"/>.</s:if>
                    <s:else>Fill out the form below to register a new staff member.</s:else>
                </p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/listEmployees" class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left-long"></i> Back to Directory
                </a>
            </div>
        </div>

        <!-- Error Panel -->
        <s:if test="hasActionErrors()">
            <div class="alert-danger" id="action-errors">
                <s:actionerror/>
            </div>
        </s:if>

        <!-- Form Card -->
        <div class="card" style="max-width: 800px; margin: 0 auto;">
            <form action="saveEmployee" method="post" id="employee-form">
                <!-- Hidden fields -->
                <input type="hidden" name="employee.id" value="<s:property value='employee.id'/>" />

                <!-- Form Fields Grid -->
                <div class="form-grid">
                    <!-- Full Name -->
                    <div class="form-group">
                        <label for="name">Full Name *</label>
                        <input type="text" id="name" name="employee.name" 
                               value="<s:property value='employee.name'/>" 
                               placeholder="e.g. Sarah Jenkins" 
                               class="form-control <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.name")'>field-error</s:if>" />
                        <s:fielderror fieldName="employee.name" cssClass="error-msg"/>
                    </div>

                    <!-- Email Address -->
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="employee.email" 
                               value="<s:property value='employee.email'/>" 
                               placeholder="e.g. sarah.j@company.com" 
                               class="form-control <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.email")'>field-error</s:if>" />
                        <s:fielderror fieldName="employee.email" cssClass="error-msg"/>
                    </div>

                    <!-- Phone Number -->
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="employee.phone" 
                               value="<s:property value='employee.phone'/>" 
                               placeholder="e.g. +1 (555) 019-2834" 
                               class="form-control" />
                    </div>

                    <!-- Department -->
                    <div class="form-group">
                        <label for="department">Department *</label>
                        <select id="department" name="employee.department" 
                                class="form-control form-select <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.department")'>field-error</s:if>">
                            <option value="">Select Department</option>
                            <option value="Engineering" <s:if test='employee.department == "Engineering"'>selected</s:if>>Engineering</option>
                            <option value="HR" <s:if test='employee.department == "HR"'>selected</s:if>>HR</option>
                            <option value="Marketing" <s:if test='employee.department == "Marketing"'>selected</s:if>>Marketing</option>
                            <option value="Finance" <s:if test='employee.department == "Finance"'>selected</s:if>>Finance</option>
                            <option value="Sales" <s:if test='employee.department == "Sales"'>selected</s:if>>Sales</option>
                            <option value="Security" <s:if test='employee.department == "Security"'>selected</s:if>>Security</option>
                        </select>
                        <s:fielderror fieldName="employee.department" cssClass="error-msg"/>
                    </div>

                    <!-- Designation / Role -->
                    <div class="form-group">
                        <label for="role">Designation / Role *</label>
                        <input type="text" id="role" name="employee.role" 
                               value="<s:property value='employee.role'/>" 
                               placeholder="e.g. Senior Frontend Developer" 
                               class="form-control <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.role")'>field-error</s:if>" />
                        <s:fielderror fieldName="employee.role" cssClass="error-msg"/>
                    </div>

                    <!-- Annual Salary -->
                    <div class="form-group">
                        <label for="salary">Annual Salary (USD) *</label>
                        <input type="number" step="0.01" id="salary" name="employee.salary" 
                               value="<s:property value='employee.salary'/>" 
                               placeholder="e.g. 85000" 
                               class="form-control <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.salary")'>field-error</s:if>" />
                        <s:fielderror fieldName="employee.salary" cssClass="error-msg"/>
                    </div>

                    <!-- Date of Joining -->
                    <div class="form-group">
                        <label for="joiningDate">Date of Joining *</label>
                        <input type="date" id="joiningDate" name="employee.joiningDate" 
                               value="<s:property value='employee.joiningDate'/>" 
                               class="form-control <s:if test='hasFieldErrors() && getFieldErrors().containsKey("employee.joiningDate")'>field-error</s:if>" />
                        <s:fielderror fieldName="employee.joiningDate" cssClass="error-msg"/>
                    </div>

                    <!-- Employment Status -->
                    <div class="form-group">
                        <label for="status">Employment Status</label>
                        <select id="status" name="employee.status" class="form-control form-select">
                            <option value="Active" <s:if test='employee.status == "Active"'>selected</s:if>>Active</option>
                            <option value="Inactive" <s:if test='employee.status == "Inactive"'>selected</s:if>>Inactive</option>
                        </select>
                    </div>
                </div>

                <!-- Form actions buttons -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/listEmployees" class="btn btn-secondary" id="btn-cancel">Cancel</a>
                    <button type="submit" class="btn btn-primary" id="btn-save">
                        <i class="fa-solid fa-floppy-disk"></i> Save Employee
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Main JS Application script -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>

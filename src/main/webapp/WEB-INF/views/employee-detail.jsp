<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Profile - Employee Management</title>
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
            <li class="active">
                <a href="${pageContext.request.contextPath}/listEmployees">
                    <i class="fa-solid fa-users"></i> Employees
                </a>
            </li>
            <li>
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
        <div class="page-header" id="detail-header">
            <div>
                <h1>Employee Profile</h1>
                <p>Detailed overview information for <s:property value="employee.name"/>.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/listEmployees" class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left-long"></i> Back to Directory
                </a>
            </div>
        </div>

        <!-- Detail Layout Grid -->
        <div class="detail-card-container">
            <!-- Left Side: Profile Summary -->
            <div class="card profile-avatar-card">
                <div class="big-avatar">
                    <s:property value="employee.name.substring(0,2)"/>
                </div>
                <h2><s:property value="employee.name"/></h2>
                <div class="role"><s:property value="employee.role"/></div>
                
                <div style="margin-bottom: 2rem;">
                    <s:if test='employee.status.equalsIgnoreCase("Active")'>
                        <span class="badge badge-active">Active Employee</span>
                    </s:if>
                    <s:else>
                        <span class="badge badge-inactive">Inactive / On Leave</span>
                    </s:else>
                </div>

                <!-- Profile Actions -->
                <div style="display: flex; flex-direction: column; gap: 0.75rem; width: 100%;">
                    <a href="editEmployee?id=<s:property value="employee.id"/>" class="btn btn-secondary" style="justify-content: center; width: 100%; border-color: rgba(139, 92, 246, 0.3); color: var(--accent-color);" id="btn-edit-profile">
                        <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                    </a>
                    <a href="deleteEmployee?id=<s:property value="employee.id"/>" class="btn btn-danger btn-delete-confirm" data-name="<s:property value="employee.name"/>" style="justify-content: center; width: 100%;" id="btn-delete-profile">
                        <i class="fa-solid fa-trash-can"></i> Delete Employee
                    </a>
                </div>
            </div>

            <!-- Right Side: Detailed Info Grid -->
            <div class="card" style="padding: 2rem;">
                <h3 style="margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.75rem;">Information Details</h3>
                
                <div class="info-grid">
                    <!-- ID -->
                    <div class="info-item" id="info-id">
                        <span class="label">Employee ID</span>
                        <span class="value">#EMP-<s:property value="employee.id"/></span>
                    </div>

                    <!-- Department -->
                    <div class="info-item" id="info-department">
                        <span class="label">Department</span>
                        <span class="value"><s:property value="employee.department"/></span>
                    </div>

                    <!-- Email -->
                    <div class="info-item" id="info-email">
                        <span class="label">Email Address</span>
                        <span class="value"><s:property value="employee.email"/></span>
                    </div>

                    <!-- Phone -->
                    <div class="info-item" id="info-phone">
                        <span class="label">Phone Number</span>
                        <span class="value">
                            <s:if test="employee.phone == null || employee.phone.trim().isEmpty()">
                                <span style="color: var(--text-muted); font-weight: normal; font-style: italic;">Not Provided</span>
                            </s:if>
                            <s:else>
                                <s:property value="employee.phone"/>
                            </s:else>
                        </span>
                    </div>

                    <!-- Salary -->
                    <div class="info-item" id="info-salary">
                        <span class="label">Annual Salary</span>
                        <span class="value format-salary"><s:property value="employee.salary"/></span>
                    </div>

                    <!-- Joining Date -->
                    <div class="info-item" id="info-joining">
                        <span class="label">Date of Joining</span>
                        <span class="value"><s:property value="employee.joiningDate"/></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main JS Application script -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>

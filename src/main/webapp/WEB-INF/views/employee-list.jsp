<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Directory - Employee Management</title>
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
        <div class="page-header" id="list-header">
            <div>
                <h1>Employees Directory</h1>
                <p>Manage and filter all registered employee profiles.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/addEmployee" class="btn btn-primary">
                    <i class="fa-solid fa-plus"></i> Add Employee
                </a>
            </div>
        </div>

        <!-- Filter and Search Bar -->
        <div class="card" style="padding: 1.25rem; margin-bottom: 1.5rem;">
            <form action="listEmployees" method="get" class="filter-bar" id="filter-form">
                <!-- Search query -->
                <div class="search-input-wrapper">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" name="searchQuery" value="<s:property value="searchQuery"/>" 
                           placeholder="Search by name or email..." class="form-control" id="search-box">
                </div>
                
                <!-- Department filter -->
                <div>
                    <select name="deptFilter" class="form-control form-select" id="dept-select">
                        <option value="All" <s:if test='deptFilter == null || deptFilter == "All"'>selected</s:if>>All Departments</option>
                        <option value="Engineering" <s:if test='deptFilter == "Engineering"'>selected</s:if>>Engineering</option>
                        <option value="HR" <s:if test='deptFilter == "HR"'>selected</s:if>>HR</option>
                        <option value="Marketing" <s:if test='deptFilter == "Marketing"'>selected</s:if>>Marketing</option>
                        <option value="Finance" <s:if test='deptFilter == "Finance"'>selected</s:if>>Finance</option>
                        <option value="Sales" <s:if test='deptFilter == "Sales"'>selected</s:if>>Sales</option>
                        <option value="Security" <s:if test='deptFilter == "Security"'>selected</s:if>>Security</option>
                    </select>
                </div>

                <!-- Status filter -->
                <div>
                    <select name="statusFilter" class="form-control form-select" id="status-select">
                        <option value="All" <s:if test='statusFilter == null || statusFilter == "All"'>selected</s:if>>All Statuses</option>
                        <option value="Active" <s:if test='statusFilter == "Active"'>selected</s:if>>Active</option>
                        <option value="Inactive" <s:if test='statusFilter == "Inactive"'>selected</s:if>>Inactive</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary" id="btn-apply-filters">Filter</button>
                <a href="listEmployees" class="btn btn-secondary" id="btn-clear-filters">Reset</a>
            </form>
        </div>

        <!-- Directory Table -->
        <div class="card">
            <div class="table-responsive">
                <table class="custom-table" id="directory-table">
                    <thead>
                        <tr>
                            <th>Employee</th>
                            <th>Department</th>
                            <th>Role / Title</th>
                            <th>Salary</th>
                            <th>Date Joined</th>
                            <th>Status</th>
                            <th style="text-align: right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:if test="employees.isEmpty()">
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 3rem 0; color: var(--text-muted);">
                                    <i class="fa-regular fa-folder-open" style="font-size: 2rem; display: block; margin-bottom: 0.75rem;"></i>
                                    No employees found matching the filters.
                                </td>
                            </tr>
                        </s:if>
                        <s:else>
                            <s:iterator value="employees" var="emp">
                                <tr>
                                    <td>
                                        <div class="emp-profile-col">
                                            <div class="emp-avatar">
                                                <s:property value="name.substring(0,2)"/>
                                            </div>
                                            <div class="emp-name-wrapper">
                                                <span class="name"><s:property value="name"/></span>
                                                <span class="email"><s:property value="email"/></span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge badge-dept"><s:property value="department"/></span>
                                    </td>
                                    <td><s:property value="role"/></td>
                                    <td>
                                        <span class="format-salary"><s:property value="salary"/></span>
                                    </td>
                                    <td><s:property value="joiningDate"/></td>
                                    <td>
                                        <s:if test='status.equalsIgnoreCase("Active")'>
                                            <span class="badge badge-active">Active</span>
                                        </s:if>
                                        <s:else>
                                            <span class="badge badge-inactive">Inactive</span>
                                        </s:else>
                                    </td>
                                    <td style="text-align: right;">
                                        <div style="display: inline-flex; gap: 0.5rem; justify-content: flex-end;">
                                            <a href="viewEmployee?id=<s:property value="id"/>" class="btn btn-secondary btn-sm" title="View details" id="btn-view-<s:property value="id"/>">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                            <a href="editEmployee?id=<s:property value="id"/>" class="btn btn-secondary btn-sm" style="color: var(--accent-color); border-color: rgba(139, 92, 246, 0.2);" title="Edit Profile" id="btn-edit-<s:property value="id"/>">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a href="deleteEmployee?id=<s:property value="id"/>" class="btn btn-danger btn-sm btn-delete-confirm" data-name="<s:property value="name"/>" title="Delete Employee" id="btn-delete-<s:property value="id"/>">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </s:iterator>
                        </s:else>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Main JS Application script -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>

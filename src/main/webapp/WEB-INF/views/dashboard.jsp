<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Employee Management</title>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Main Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <div class="logo">E</div>
            <div class="title">EmpManager</div>
        </div>
        <ul class="sidebar-menu">
            <li class="active">
                <a href="${pageContext.request.contextPath}/dashboard">
                    <i class="fa-solid fa-chart-pie"></i> Dashboard
                </a>
            </li>
            <li>
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
        <div class="page-header" id="dashboard-header">
            <div>
                <h1>Dashboard</h1>
                <p>Welcome back! Here is a summary of your organization status.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/addEmployee" class="btn btn-primary">
                    <i class="fa-solid fa-plus"></i> Add Employee
                </a>
            </div>
        </div>

        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="card stat-card" id="stat-total">
                <div class="stat-icon blue">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><s:property value="totalEmployees"/></span>
                    <span class="stat-label">Total Employees</span>
                </div>
            </div>
            <div class="card stat-card" id="stat-active">
                <div class="stat-icon green">
                    <i class="fa-solid fa-user-check"></i>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><s:property value="activeEmployees"/></span>
                    <span class="stat-label">Active Staff</span>
                </div>
            </div>
            <div class="card stat-card" id="stat-inactive">
                <div class="stat-icon orange">
                    <i class="fa-solid fa-user-slash"></i>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><s:property value="inactiveEmployees"/></span>
                    <span class="stat-label">On Leave/Inactive</span>
                </div>
            </div>
            <div class="card stat-card" id="stat-salary">
                <div class="stat-icon purple">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div class="stat-info">
                    <span class="stat-value format-salary"><s:property value="averageSalary"/></span>
                    <span class="stat-label">Average Salary</span>
                </div>
            </div>
        </div>

        <!-- Dashboard Layout Grid -->
        <div class="dashboard-grid">
            <!-- Left Side: Recent Hires -->
            <div class="card">
                <div class="table-title-bar">
                    <h3>Recent Hires</h3>
                    <a href="${pageContext.request.contextPath}/listEmployees" class="btn btn-secondary btn-sm">View All</a>
                </div>
                <div class="table-responsive">
                    <table class="custom-table" id="recent-hires-table">
                        <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Department</th>
                                <th>Role</th>
                                <th>Joined</th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:if test="recentHires.isEmpty()">
                                <tr>
                                    <td colspan="4" style="text-align: center; color: var(--text-muted);">No records found</td>
                                </tr>
                            </s:if>
                            <s:else>
                                <s:iterator value="recentHires" var="emp">
                                    <tr>
                                        <td>
                                            <div class="emp-profile-col">
                                                <div class="emp-avatar">
                                                    <s:property value="name.substring(0,2)"/>
                                                </div>
                                                <div class="emp-name-wrapper">
                                                    <a href="viewEmployee?id=<s:property value="id"/>" style="text-decoration:none;">
                                                        <span class="name"><s:property value="name"/></span>
                                                    </a>
                                                    <span class="email"><s:property value="email"/></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td><span class="badge badge-dept"><s:property value="department"/></span></td>
                                        <td><s:property value="role"/></td>
                                        <td><s:property value="joiningDate"/></td>
                                    </tr>
                                </s:iterator>
                            </s:else>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Right Side: Department breakdown (Chart) -->
            <div class="card chart-card">
                <h3>Departments</h3>
                <div class="chart-container">
                    <canvas id="deptChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Main JS Application script -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>

    <!-- Chart Configuration Script -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const ctx = document.getElementById('deptChart').getContext('2d');
            
            // Dynamic data arrays rendered by JSP from the Action map
            const labels = [];
            const data = [];
            
            <s:iterator value="departmentCounts">
                labels.push("<s:property value="key"/>");
                data.push(<s:property value="value"/>);
            </s:iterator>

            if (labels.length === 0) {
                // Fallback in case of empty counts
                labels.push("No Data");
                data.push(1);
            }

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: data,
                        backgroundColor: [
                            '#8b5cf6', // Violet
                            '#3b82f6', // Blue
                            '#10b981', // Emerald
                            '#f59e0b', // Amber
                            '#ef4444', // Red
                            '#ec4899', // Pink
                            '#06b6d4'  // Cyan
                        ],
                        borderWidth: 0,
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                color: '#94a3b8',
                                font: {
                                    family: 'Inter',
                                    size: 11
                                },
                                padding: 15
                            }
                        }
                    },
                    cutout: '72%'
                }
            });
        });
    </script>
</body>
</html>

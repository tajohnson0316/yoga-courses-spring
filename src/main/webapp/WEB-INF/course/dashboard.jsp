<%--
  Created by IntelliJ IDEA.
  User: arman
  Date: 6/22/2023
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>

<html>
<head>
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
  <script type="text/javascript" src="/js/app.js"></script>
  
  <title>YoYoga - Dashboard</title>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a href="/dashboard" class="navbar-brand">
      YoYoga
    </a>
    <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a href="/dashboard" class="nav-link">
            Home
          </a>
        </li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger" role="button">
        Log Out
      </a>
    </div>
  </div>
</nav>
<div class="container p-5">
  <h1 class="mb-3">Welcome, Instructor ${userName}!</h1>
  <div class="d-flex justify-content-between align-items-end mb-3">
    <p>Course Schedule:</p>
    <a href="/courses/new/form" class="btn btn-outline-success" role="button">
      + New Course
    </a>
  </div>
  <div class="d-flex justify-content-center">
    <div class="card w-100">
      <div class="card-body">
        <table class="table table-striped table-bordered">
          <thead>
          <tr>
            <th scope="col">Course Name</th>
            <th scope="col">Instructor</th>
            <th scope="col">Weekday</th>
            <th scope="col">Price</th>
            <th scope="col">Time</th>
            <th scope="col">Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="course" items="${allCourses}">
            <tr>
              <td>
                <a href="/courses/${course.id}">${course.name}</a>
              </td>
              <td>${course.instructor.userName}</td>
              <td>${course.day}</td>
              <td>
                <fmt:formatNumber type="currency" value="${course.price}"/>
              </td>
              <td>
                <fmt:formatDate type="time" value="${course.time}"/>
              </td>
              <c:choose>
                <c:when test="${course.instructor.id == userId}">
                  <td>
                    <div class="d-flex justify-content-center">
                      <form action="/courses/delete/${course.id}" method="post">
                        <div class="btn-group" role="group">
                          <a href="/courses/edit/${course.id}" class="btn btn-warning">
                            Edit
                          </a>
                          <input type="hidden" name="_method" value="delete">
                          <button type="submit" class="btn btn-danger">Delete</button>
                        </div>
                      </form>
                    </div>
                  </td>
                </c:when>
                <c:otherwise>
                  <td>
                    ---
                  </td>
                </c:otherwise>
              </c:choose>
                <%-- VIEW | EDIT | DELETE --%>
              <c:if test="${course.instructor.id == userId}">
              
              </c:if>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
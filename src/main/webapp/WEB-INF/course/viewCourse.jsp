<%--
  Created by IntelliJ IDEA.
  User: arman
  Date: 6/22/2023
  Time: 12:58 PM
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
  
  <title>YoYoga - View Course</title>
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
  <div class="card w-100 mb-5">
    <div class="card-header text-center fs-3">
      <%-- TODO: VIEW CARD HEADER --%>
      ${course.name}
    </div>
    <div class="card-body">
      <%-- TODO: VIEW CARD CONTENT --%>
      <div class="d-flex justify-content-start gap-3 mb-3">
        <span class="fw-bold">Day:</span>
        <span>${course.day}</span>
      </div>
      <div class="d-flex justify-content-start gap-3 mb-3">
        <span class="fw-bold">Price:</span>
        <span>$${course.price}</span>
      </div>
      <div class="d-flex justify-content-start gap-3 mb-3">
        <span class="fw-bold">Time:</span>
        <fmt:formatDate type="time" value="${course.time}"/>
      </div>
      <p class="fs-3">
        ${course.description}
      </p>
    </div>
  </div>
  
  <hr class="mb-5">
  
  <div class="mb-5">
    <h3 class="text-decoration-underline">
      Enrolled Students
    </h3>
    <c:forEach var="student" items="${course.students}">
      <p>
        <span>${student.name}</span> - <span>${student.email}</span>
      </p>
    </c:forEach>
  </div>
  
  <hr class="mb-5">
  
  <c:if test="${userId == course.instructor.id}">
    <h2 class="mb-3">
      Enroll Students in Course
    </h2>
    <div class="d-flex justify-content-between mb-3">
      <div>
        <h3>New Student</h3>
        <form:form action="/courses/${course.id}/students/create" method="post" modelAttribute="student">
          <div class="mb-3">
            <form:label path="name" class="form-label">
              Student Name:
            </form:label>
            <form:input path="name" class="form-control"/>
            <p class="text-danger">
              <form:errors path="name"/>
            </p>
          </div>
          <div class="mb-3">
            <form:label path="email" class="form-label">
              Student E-mail:
            </form:label>
            <form:input type="email" path="email" class="form-control"/>
            <p class="text-danger">
              <form:errors path="email"/>
            </p>
          </div>
          <button type="submit" class="btn btn-success">Enroll Student</button>
        </form:form>
      </div>
      <div>
        <h3>Existing Student</h3>
        <form:form action="/courses/${course.id}/students/enroll" method="post" modelAttribute="student">
          <div class="mb-3">
            <form:label for="studentSelect" path="id" class="form-label">
              Unenrolled Students:
            </form:label>
            <form:select class="form-select" path="id">
              <c:forEach var="student" items="${unenrolledStudents}">
                <option value="${student.id}">${student.name} - ${student.email}</option>
              </c:forEach>
            </form:select>
          </div>
          <button type="submit" class="btn btn-success">Enroll Student</button>
        </form:form>
      </div>
    </div>
  </c:if>
</div>
</body>
</html>
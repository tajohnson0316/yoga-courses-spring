<%--
  Created by IntelliJ IDEA.
  User: arman
  Date: 6/22/2023
  Time: 3:07 PM
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
  
  <title>YoYoga - Edit Course</title>
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
  <h1>Edit Course</h1>
  <form:form action="/courses/update/${course.id}" method="put" modelAttribute="course">
    <form:input type="hidden" path="instructor" value="${userId}"/>
    <div class="mb-3">
      <form:label path="name" class="form-label">
        Course Name:
      </form:label>
      <form:input path="name" class="form-control"/>
      <p class="text-danger">
        <form:errors path="name"/>
      </p>
    </div>
    <div class="mb-3">
      <form:label path="day" class="form-label">
        Day of the Week:
      </form:label>
      <form:select path="day" class="form-select">
        <form:option value="Sunday">Sunday</form:option>
        <form:option value="Monday">Monday</form:option>
        <form:option value="Tuesday">Tuesday</form:option>
        <form:option value="Wednesday">Wednesday</form:option>
        <form:option value="Thursday">Thursday</form:option>
        <form:option value="Friday">Friday</form:option>
        <form:option value="Saturday">Saturday</form:option>
      </form:select>
      <p class="text-danger">
        <form:errors path="day"/>
      </p>
    </div>
    <div class="mb-3">
      <form:label path="price" class="form-label">
        Drop-in Price:
      </form:label>
      <div class="input-group">
        <span class="input-group-text">$</span>
        <form:input type="number" path="price" class="form-control w-50" min="0.01" step="0.01"/>
      </div>
      <p class="text-danger">
        <form:errors path="name"/>
      </p>
    </div>
    <div class="mb-3">
      <form:label path="time" class="form-label">
        Time:
      </form:label>
      <form:input type="time" path="time" class="form-control" min="05:00" max="22:00"/>
      <p class="text-danger">
        <form:errors path="time"/>
      </p>
      <p class="fw-bold">Business hours are from 5 AM to 10 PM</p>
    </div>
    <div class="mb-3">
      <form:label path="description" class="form-label">
        Description:
      </form:label>
      <form:textarea path="description" class="form-control"/>
      <p class="text-danger">
        <form:errors path="description"/>
      </p>
    </div>
    <div class="d-flex justify-content-end gap-3">
      <a href="/dashboard" class="btn btn-danger" role="button">Cancel</a>
      <button type="submit" class="btn btn-success">Save Changes</button>
    </div>
  </form:form>
</div>
</body>
</html>
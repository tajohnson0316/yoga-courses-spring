package com.tajohnson.yogacourses.controllers.course;

import com.tajohnson.yogacourses.models.course.Course;
import com.tajohnson.yogacourses.models.student.Student;
import com.tajohnson.yogacourses.services.course.CourseService;
import com.tajohnson.yogacourses.services.student.StudentService;
import com.tajohnson.yogacourses.services.user.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CourseController {
  @Autowired
  private UserService userService;

  @Autowired
  private CourseService courseService;

  @Autowired
  private StudentService studentService;

  //  =============== GET ROUTES ===============

  // *** DASHBOARD ROUTE ***
  @GetMapping("/dashboard")
  public String dashboard(
    HttpSession session,
    Model model
  ) {
    if (session.getAttribute("userId") == null) {
      return "redirect:/logout";
    }

    Long userId = (Long) session.getAttribute("userId");
    if (!userService.isValidId(userId)) {
      return "redirect:/logout";
    }

    model.addAttribute("userId", userId);
    String userName = userService.getUserById(userId).getUserName();
    model.addAttribute("userName", userName);

    model.addAttribute("allCourses", courseService.allCourses());

    return "/course/dashboard.jsp";
  }

  // *** DISPLAY COURSE FORM ***
  @GetMapping("/courses/new/form")
  public String displayCourseForm(
    @ModelAttribute("course") Course course,
    HttpSession session,
    Model model
  ) {
    if (session.getAttribute("userId") == null) {
      return "redirect:/logout";
    }

    Long userId = (Long) session.getAttribute("userId");
    if (!userService.isValidId(userId)) {
      return "redirect:/logout";
    }

    model.addAttribute("userId", userId);

    return "course/courseForm.jsp";
  }

  // *** VIEW COURSE ***
  @GetMapping("/courses/{id}")
  public String viewCourse(
    @PathVariable("id") Long id,
    @ModelAttribute("student") Student student,
    HttpSession session,
    Model model
  ) {
    if (session.getAttribute("userId") == null) {
      return "redirect:/logout";
    }

    Long userId = (Long) session.getAttribute("userId");
    if (!userService.isValidId(userId)) {
      return "redirect:/logout";
    }
    Course course = courseService.getCourseById(id);
    model.addAttribute("course", course);
    model.addAttribute("userId", userId);
    model.addAttribute("unenrolledStudents", courseService.getUnenrolledStudents(course));

    return "course/viewCourse.jsp";
  }

  //  =============== POST ROUTES ===============

  // *** CREATE NEW COURSE ***
  @PostMapping("/courses/new/create")
  public String createProject(
    @Valid @ModelAttribute("course") Course course,
    BindingResult result,
    HttpSession session,
    Model model
  ) {
    Long userId = (Long) session.getAttribute("userId");

    if (result.hasErrors()) {
      model.addAttribute("course", course);
      model.addAttribute("userId", userId);
      return "course/courseForm.jsp";
    }
    Course newCourse = courseService.createCourse(course);
    return String.format("redirect:/courses/%d", newCourse.getId());
  }

  // *** CREATE NEW STUDENT ***
  @PostMapping("/courses/{courseId}/students/create")
  public String createStudent(
    @PathVariable("courseId") Long id,
    @Valid @ModelAttribute("student") Student student,
    BindingResult result,
    HttpSession session,
    Model model
  ) {
    if (result.hasErrors()) {
      Long userId = (Long) session.getAttribute("userId");
      Course course = courseService.getCourseById(id);
      model.addAttribute("course", course);
      model.addAttribute("userId", userId);
      model.addAttribute("unenrolledStudents", courseService.getUnenrolledStudents(course));
      model.addAttribute("student", student);

      return "course/viewCourse.jsp";
    }
    Student newStudent = studentService.createStudent(student);
    courseService.addStudentToCourse(id, newStudent.getId());

    return String.format("redirect:/courses/%d", id);
  }

  // *** ADD STUDENT TO COURSE ***
  @PostMapping("/courses/{courseId}/students/enroll")
  public String addStudentToCourse(
    @PathVariable("courseId") Long id,
    @ModelAttribute("student") Student student
  ) {
    courseService.addStudentToCourse(id, student.getId());

    return String.format("redirect:/courses/%d", id);
  }
}
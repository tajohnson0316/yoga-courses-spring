package com.tajohnson.yogacourses.services.course;

import com.tajohnson.yogacourses.models.course.Course;
import com.tajohnson.yogacourses.models.student.Student;
import com.tajohnson.yogacourses.repositories.course.CourseRepository;
import com.tajohnson.yogacourses.services.student.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
  @Autowired
  private CourseRepository courseRepository;

  @Autowired
  private StudentService studentService;

  public List<Course> allCourses() {
    return this.courseRepository.findAll();
  }

  public Course getCourseById(Long id) {
    Optional<Course> optional = courseRepository.findById(id);

    return optional.orElse(null);
  }

  public List<Student> getUnenrolledStudents(Course course) {
    List<Student> allStudents = studentService.allStudents();
    List<Student> enrolledStudents = course.getStudents();
    List<Student> unenrolledStudents = new ArrayList<>();
    for (Student student : allStudents) {
      if (!enrolledStudents.contains(student)) {
        unenrolledStudents.add(student);
      }
    }
    return unenrolledStudents;
  }

  public Course createCourse(Course course) {
    course.setStudents(new ArrayList<>());
    return courseRepository.save(course);
  }

  public Course updateCourse(Course course) {
    List<Student> allStudents = studentService.allStudents();
    List<Student> enrolledStudents = new ArrayList<>();

    for (Student student : allStudents) {
      if (student.getCourses().contains(course)) {
        enrolledStudents.add(student);
      }
    }
    course.setStudents(enrolledStudents);
    return courseRepository.save(course);
  }

  public Course addStudentToCourse(Long courseId, Long studentId) {
    Student student = studentService.getStudentById(studentId);
    Course course = getCourseById(courseId);

    course.getStudents().add(student);

    return courseRepository.save(course);
  }

  public void deleteCourseById(Long id) {
    courseRepository.deleteById(id);
  }
}
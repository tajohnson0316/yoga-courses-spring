package com.tajohnson.yogacourses.services.student;

import com.tajohnson.yogacourses.models.student.Student;
import com.tajohnson.yogacourses.repositories.student.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentService {
  @Autowired
  private StudentRepository studentRepository;

  public List<Student> allStudents() {
    return studentRepository.findAll();
  }

  public Student getStudentById(Long id) {
    Optional<Student> optional = studentRepository.findById(id);

    return optional.orElse(null);
  }

  public Student createStudent(Student student) {
    return studentRepository.save(student);
  }

  public Student updateStudent(Student student) {
    return studentRepository.save(student);
  }
}
package com.tajohnson.yogacourses.repositories.student;

import com.tajohnson.yogacourses.models.student.Student;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentRepository extends CrudRepository<Student, Long> {
  @NotNull List<Student> findAll();
}
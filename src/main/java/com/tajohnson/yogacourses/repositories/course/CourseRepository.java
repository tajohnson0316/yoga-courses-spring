package com.tajohnson.yogacourses.repositories.course;

import com.tajohnson.yogacourses.models.course.Course;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseRepository extends CrudRepository<Course, Long> {
  @NotNull List<Course> findAll();
}
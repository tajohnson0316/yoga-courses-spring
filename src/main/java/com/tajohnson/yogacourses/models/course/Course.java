package com.tajohnson.yogacourses.models.course;

import com.tajohnson.yogacourses.models.student.Student;
import com.tajohnson.yogacourses.models.user.User;
import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "courses")
public class Course {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotBlank(message = "Course name is required")
  @Size(min = 2, message = "Requires a minimum of 2 characters")
  private String name;

  @NotBlank(message = "Day of the week is required")
  private String day;

  @NotNull(message = "Drop-in price required")
  @DecimalMin(value = "0.01", message = "Requires a minimum of $0.01")
  private Double price;

  @NotNull(message = "Course time is required")
  private LocalTime time;

  @NotBlank(message = "Course description is required")
  @Size(min = 3, message = "Requires a minimum of 36 characters")
  private String description;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id")
  private User instructor;

  @ManyToMany(fetch = FetchType.LAZY)
  @JoinTable(
    name = "courses_students",
    joinColumns = @JoinColumn(name = "course_id"),
    inverseJoinColumns = @JoinColumn(name = "student_id")
  )
  private List<Student> students;

  @Column(updatable = false)
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date createdAt;

  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date updatedAt;

  public Course() {
  }

  @PrePersist
  protected void onCreate() {
    this.createdAt = new Date();
  }

  @PreUpdate
  protected void onUpdate() {
    this.updatedAt = new Date();
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getDay() {
    return day;
  }

  public void setDay(String day) {
    this.day = day;
  }

  public @NotNull Double getPrice() {
    return price;
  }

  public void setPrice(@NotNull Double price) {
    this.price = price;
  }

  public @NotNull LocalTime getTime() {
    return time;
  }

  public void setTime(@NotNull LocalTime time) {
    this.time = time;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public User getInstructor() {
    return instructor;
  }

  public void setInstructor(User instructor) {
    this.instructor = instructor;
  }

  public List<Student> getStudents() {
    return students;
  }

  public void setStudents(List<Student> students) {
    this.students = students;
  }

  public Date getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Date createdAt) {
    this.createdAt = createdAt;
  }

  public Date getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Date updatedAt) {
    this.updatedAt = updatedAt;
  }
}
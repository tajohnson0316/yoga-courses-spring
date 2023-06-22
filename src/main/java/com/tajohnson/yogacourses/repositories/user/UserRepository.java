package com.tajohnson.yogacourses.repositories.user;

import com.tajohnson.yogacourses.models.user.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
  Optional<User> findByEmail(String email);

  List<User> findAll();
}
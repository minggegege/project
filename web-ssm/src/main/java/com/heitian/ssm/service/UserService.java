package com.heitian.ssm.service;

import com.heitian.ssm.model.User;

import java.util.List;
import java.util.Map;
public interface UserService {

    List<User> getAllUser();

    Map select(Map map);

    List<User> getUser();
}

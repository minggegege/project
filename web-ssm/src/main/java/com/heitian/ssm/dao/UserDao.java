package com.heitian.ssm.dao;

import com.heitian.ssm.model.Topic;
import com.heitian.ssm.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface UserDao {

    List<User> selectAllUser();

    Integer select(Map map);
    List cha(Map map);

    List<User> getUser();
}

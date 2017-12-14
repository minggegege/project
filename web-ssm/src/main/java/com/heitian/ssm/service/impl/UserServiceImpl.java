package com.heitian.ssm.service.impl;

import com.heitian.ssm.dao.UserDao;
import com.heitian.ssm.model.User;
import com.heitian.ssm.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ClientViewServiceI")
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {
    
    @Resource
    private UserDao userDao;
    @Override
    public List<User> getAllUser() {

        return userDao.selectAllUser();
    }
    @Override
    public  Map select(Map map) {
        Map<String,Object> mapp = new HashMap<String,Object>();
        mapp.put("count",userDao.select(map));
        mapp.put("select",userDao.cha(map));
        return mapp;
    }
    @Override
    public List<User> getUser() {
        return userDao.getUser();
    }
}

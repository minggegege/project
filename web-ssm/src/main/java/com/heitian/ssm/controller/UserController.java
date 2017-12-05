package com.heitian.ssm.controller;

import com.heitian.ssm.model.PageBean;
import com.heitian.ssm.model.Topic;
import com.heitian.ssm.model.User;
import com.heitian.ssm.service.UserService;
import com.heitian.ssm.utils.FenYe;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/user")
public class UserController {

    private Logger log = Logger.getLogger(UserController.class);
    @Resource
    private UserService userService;

    @RequestMapping(value="/login",method=RequestMethod.POST)
    public String login(Topic topic, HttpServletRequest request, @PathParam("pagecode") String pagecode,String name) throws UnsupportedEncodingException {
        System.out.println(name+"=================");
        PageBean bean = new PageBean();
        bean.setPagecode((null != pagecode && !"".equals(pagecode.trim())) ? Integer
                .parseInt(pagecode.trim()) : 1);//当前页码数
        bean.setUrl(getParameterUrl(request.getParameterMap(), request));
        Map map = new HashMap();
        map.put("bean",bean);
        map.put("lianxi", topic);
        map.put("name",name);
        Map mapquery = userService.select(map);
        bean.setTotalrecord(Integer.valueOf(mapquery.get("count").toString()));
        bean.setBeanList((List)mapquery.get("select"));
        System.out.println(bean.getBeanList()+"1111111");
        request.setAttribute("pageBean", bean);
        return "/app/jsp/stationSearch";
    }


    private String getParameterUrl(Map<String, String[]> parameterMap, HttpServletRequest request) throws UnsupportedEncodingException {
        String url = "";
        Set<String> set = parameterMap.keySet();
        for (String stuid : set) {
            String[] arr = (String[]) parameterMap.get(stuid);
            if (!"pagecode".equals(stuid)) {
                if (!"".equals(url)) {
                    url += "&";
                }
                arr[0] = URLDecoder.decode(arr[0], "utf-8");
                url += stuid + "=" + arr[0];
            }
        }
        String s = request.getContextPath() + "/user/login";
        return s + "?" + url;
    }

    @RequestMapping("/showUser")
    public String showUser(HttpServletRequest request, Model model) {
        log.info("查询所有用户信息");
        List<User> userList = userService.getAllUser();
        model.addAttribute("userList", userList);
        System.out.println("哈哈");
        return "app/jsp/showUser";
    }
    @RequestMapping("/query")
    public String query(HttpServletRequest request, Model model) {
        List<User> users = userService.getUser();
        System.out.println(users);
        model.addAttribute("users",users);
        return "app/jsp/showUser";
    }
}

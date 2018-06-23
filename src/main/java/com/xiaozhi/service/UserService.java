package com.xiaozhi.service;

import com.xiaozhi.common.entity.User;

import java.util.List;

/**
 * Created by Administrator on 2018/6/17/017.
 */
public interface UserService {
    //根据用户id查询用户真名
    public String  selectRealNameByUserName(String userName);

    //根据用户名查询用户管理的部门id
    public int selectDeptIdByUserName(String username);

    //得到所有用户
    public List<User> getAllUser();

    //得到总用户数
    public long getUserNum();

    //检查用户的名字看是否可用（不重复）
    public boolean checkUserName(String username);

    //保存用户
    public void saveUser(User user);

    //根据id查询用户
    public User getUser(Integer uId);

    //更新用户
    public void updateUser(User user);

    //单个删除用户
    public void deleteUser(Integer id);

    //批量删除用户
    public void deleteBatch(List<Integer> ids);

}

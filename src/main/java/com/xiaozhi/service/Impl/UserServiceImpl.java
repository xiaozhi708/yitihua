package com.xiaozhi.service.Impl;

import com.xiaozhi.common.entity.User;
import com.xiaozhi.common.entity.UserExample;
import com.xiaozhi.mapper.UserMapper;
import com.xiaozhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/17/017.
 */
@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    //根据用户id查询用户真名
    public String selectRealNameByUserName(String userName) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(userName);
         List<User> userList =userMapper.selectByExample(example);
         if(userList!=null){
             return userList.get(0).getRealName();
         }else{
             return "";
         }
    }
    //根据用户名查询用户管理的部门id
    public int selectDeptIdByUserName(String userName){
        UserExample userExample = new UserExample();
        UserExample.Criteria userCriteria =userExample.createCriteria();
        userCriteria.andUsernameEqualTo(userName);
        List<User> userList =userMapper.selectByExample(userExample);
        int userDeptId =userList.get(0).getDeptId();
        return userDeptId;
    }

    //查询所有用户
    public List<User> getAllUser(){
        UserExample example = new UserExample();
        example.setOrderByClause("tu.u_id ASC");//按照用户的id递增顺序排列
        List<User> userList =userMapper.selectByExampleWithRole(example);
        return userList;
    }

    //查询用户总数
    public long getUserNum(){
        UserExample example =new UserExample();
        long userNum =userMapper.countByExample(example);
        return userNum;
    }

    /**
     * 检验用户的名字是否可用
     *
     * @param username
     * @return true 表明当前姓名可用，否则不可用
     */
    public boolean checkUserName(String username) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count = userMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 保存用户
     * @param user
     */
    public void saveUser(User user){
        userMapper.insertSelective(user);
    }

    /**
     * 根据id查询用户
     * @param uId
     * @return
     */
    public User getUser(Integer uId){
        User user = userMapper.selectByPrimaryKeyWithRole(uId);
        //System.out.println("用户角色的id"+user.getRole().getId());
        return user;
    }

    /**
     * 更新用户
     * @param user
     */
    public void updateUser(User user){
        System.out.println("即将更新的用户的id："+user.getuId());
        userMapper.updateByPrimaryKeySelective(user);
    }


    /**
     * 单个删除用户
     * @param uId
     */
    public void deleteUser(Integer uId){
        System.out.println("进入了userServiceImpl的deleteUser方法，uId="+uId);
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUIdEqualTo(uId);
        userMapper.deleteByExample(example);
    }

    /**
     * 批量删除用户
     * @param ids
     */
    public void deleteBatch(List<Integer> ids){
        System.out.println("进入了userServiceImpl的deleteBatch方法");
        UserExample example =new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUIdIn(ids);
        userMapper.deleteByExample(example);
    }
}

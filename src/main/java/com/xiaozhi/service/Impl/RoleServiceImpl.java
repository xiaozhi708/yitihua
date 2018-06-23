package com.xiaozhi.service.Impl;

import com.xiaozhi.common.entity.Role;
import com.xiaozhi.common.entity.RoleExample;
import com.xiaozhi.common.entity.UserRoleExample;
import com.xiaozhi.mapper.RoleMapper;
import com.xiaozhi.mapper.UserRoleMapper;
import com.xiaozhi.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/21/021.
 * 关于role和userRole的业务
 */
@Service
public class RoleServiceImpl implements RoleService{

    @Autowired
    RoleMapper roleMapper;
    @Autowired
    UserRoleMapper userRoleMapper;

    /**
     * 取出所有角色
     * @return
     */
    public List<Role> getAllRoles(){
        RoleExample roleExample = new RoleExample();
        List<Role> roleList =roleMapper.selectByExample(roleExample);
//        for(int i=0;i<roleList.size();i++){
//            System.out.println("角色："+roleList.get(i).getName());
//        }
        return roleList;
    }
    /**
     * 批量删除用户时，将这些用户与角色的关联信息也删除
     * @param ids 用户id
     */
    public void deleteBatch(List<Integer> ids){
        UserRoleExample example =new UserRoleExample();
        UserRoleExample.Criteria criteria =example.createCriteria();
        criteria.andUserIdIn(ids);
        userRoleMapper.deleteByExample(example);
    }

    /**
     * 根据用户id删除用户与角色的关联关系
     * @param id
     */
    public void deleteRole(Integer id){
        UserRoleExample example =new UserRoleExample();
        UserRoleExample.Criteria criteria =example.createCriteria();
        criteria.andUserIdEqualTo(id);
        userRoleMapper.deleteByExample(example);
    }

    /**
     * 根据角色的id批量删除角色
     * @param ids
     */
    public void deleteBatchByRoleIds(List<Integer> ids){
        RoleExample example =new RoleExample();
        RoleExample.Criteria criteria =example.createCriteria();
        criteria.andIdIn(ids);
        roleMapper.deleteByExample(example);
    }

    /**
     * 根据角色的id删除该角色
     * @param id
     */
    public void deleteRoleByRoleId(Integer id){
        RoleExample example =new RoleExample();
        RoleExample.Criteria criteria =example.createCriteria();
        criteria.andIdEqualTo(id);
        roleMapper.deleteByExample(example);
    }

    /**
     * 检查角色名是否可用（不重复）
     * @param roleName
     * @return
     */
    public boolean checkRoleName(String roleName){
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andNameEqualTo(roleName);
        long count = roleMapper.countByExample(example);
        return count == 0;
    }


    /**
     * 根据角色id查询角色
     * @param id
     * @return
     */
    public Role getRoleById(Integer id){
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria =example.createCriteria();
        criteria.andIdEqualTo(id);
        List<Role> roleList =roleMapper.selectByExample(example);
        return roleList.get(0);
    }
    /**
     * 保存角色
     * @param role
     */
    public void saveRole(Role role){
        roleMapper.insertSelective(role);
    }

    /**
     * 更新角色
     * @param role
     */
    public void updateRole(Role role){
        System.out.println("即将更新的角色的id："+role.getId());
        roleMapper.updateByPrimaryKeySelective(role);
    }


}

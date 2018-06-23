package com.xiaozhi.service;

import com.xiaozhi.common.entity.Role;

import java.util.List;

/**
 * Created by Administrator on 2018/6/21/021.
 */
public interface RoleService {
    /**
     * 拿到所有角色
     * @return
     */
    public List<Role> getAllRoles();

    /**
     * 批量删除用户时，将这些用户与角色的关联信息也删除
     * @param ids 用户id
     */
    public void deleteBatch(List<Integer> ids);

    /**
     * 根据用户id删除用户与角色的关联关系
     * @param id
     */
    public void deleteRole(Integer id);

    /**
     * 根据角色的id批量删除角色
     * @param ids
     */
    public void deleteBatchByRoleIds(List<Integer> ids);

    /**
     * 根据角色的id删除该角色
     * @param id
     */
    public void deleteRoleByRoleId(Integer id);

    /**
     * 检查角色名是否可用（不重复）
     * @param roleName
     * @return
     */
    public boolean checkRoleName(String roleName);

    /**
     * 保存角色
     * @param role
     */
    public void saveRole(Role role);

    /**
     * 根据角色id查询角色
     * @param id
     * @return
     */
    public Role getRoleById(Integer id);

    /**
     * 更新角色
     * @param role
     */
    public void updateRole(Role role);



}

package com.xiaozhi.mapper;

import com.xiaozhi.common.entity.Role;
import com.xiaozhi.common.entity.RoleExample;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {
    long countByExample(RoleExample example);

    int deleteByExample(RoleExample example);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Set<String> selectByUserId(Integer userId);

    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    //根据主键id更新角色
    int updateByPrimaryKeySelective(Role role);

    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);
}
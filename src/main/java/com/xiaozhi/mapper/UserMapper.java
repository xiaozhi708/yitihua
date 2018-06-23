package com.xiaozhi.mapper;

import com.xiaozhi.common.entity.User;
import com.xiaozhi.common.entity.UserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    long countByExample(UserExample example);

    int deleteByExample(UserExample example);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserExample example);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    int updateByExample(@Param("record") User record, @Param("example") UserExample example);
    //新增的
    int updateByPrimaryKeySelective(User record);

    List<User> selectByExampleWithRole(UserExample userExample);

    User selectByPrimaryKeyWithRole(Integer uId);


}
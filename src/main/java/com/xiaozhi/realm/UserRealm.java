package com.xiaozhi.realm;

import com.xiaozhi.common.entity.User;
import com.xiaozhi.common.entity.UserExample;
import com.xiaozhi.mapper.RoleMapper;
import com.xiaozhi.mapper.UserMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2018/3/30/030.
 */
public class UserRealm extends AuthorizingRealm {
    @Autowired
    UserMapper userMapper;
    @Autowired
    RoleMapper roleMapper;
    //授权
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //返回值：AuthorizationInfo，封装获取的用户对应的所有角色，SimpleAuthorizationInfo(set<String>)
        //参数列表：principalCollection 登录的身份，登录的用户名
        clearAuthz();
        AuthorizationInfo info =null;
        //3.查询数据库，是否存在指定用户名和密码的用户
        String userName =principalCollection.toString();
        System.out.println("授权中用户名是："+userName);
        UserExample userExample =new UserExample();
        UserExample.Criteria c = userExample.createCriteria();
        c.andUsernameEqualTo(userName);
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList!=null){
//            Set<String> roles =new HashSet<String>();
            Set<String> roles = roleMapper.selectByUserId(userList.get(0).getId());
//           roles.add(userList.get(0).getId());
          info =new SimpleAuthorizationInfo(roles);
            System.out.println(info);
        }else {
            //5.如果没有查到，抛出一个异常
            throw new AuthenticationException();
        }

        return info;
    }
    //清空权限
    public void clearAuthz(){
        this.clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
    }

    //认证
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        SimpleAuthenticationInfo info =null;
        //1.将token转换为UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken) authenticationToken;
        //2.获取用户名即可
        String userName =upToken.getUsername();

        //3.查询数据库，是否存在指定用户名和密码的用户
        UserExample userExample =new UserExample();
        UserExample.Criteria c = userExample.createCriteria();
        c.andUsernameEqualTo(userName);
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList!=null){
            //4.如果查询到了，封装查询结果，返回给我们的调用
            Object principal = userName;
            Object credentials =userList.get(0).getPassword();
            String realmName =this.getName();
            //ByteSource
            ByteSource salt =ByteSource.Util.bytes(userName);
            //将数据库中查询出来的密码进行同样的加密（正常情况是用mybatis，存储到数据库的数据就是经过加密的）
            SimpleHash sh =new SimpleHash("MD5",credentials,salt,1024);

            //不加盐值的情况
            //info =new SimpleAuthenticationInfo(principal,sh,realmName);
            //盐值加密
            info =new SimpleAuthenticationInfo(principal,sh,salt,realmName);
        }else {
            //5.如果没有查到，抛出一个异常
            throw new AuthenticationException();
        }
        return info;
    }


}

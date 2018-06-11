package com.xiaozhi.realm;

import com.xiaozhi.common.entity.User;
import com.xiaozhi.common.entity.UserExample;
import com.xiaozhi.mapper.UserMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;


/**
 * Created by Administrator on 2018/3/30/030.
 * Realm 需要查询数据库，并且得到正确的数据（只是认证用所以只继承了AuthenticatingRealm ,而没有实现Realm接口）
 */
public class ShiroRealm2 extends AuthenticatingRealm {
    @Autowired
    UserMapper userMapper;
    /**
     * 1.doGetAuthenticationInfo,获取认证消息，如果数据库中没有数据返回null，如果得到正确的用户名和密码则返回指定类型的对象
     * 2.AuthenticationInfo（这是一个接口） 可以使用SimpleAuthenticationInfo实现类，封装给你正确的用户名和密码
     * 3.token参数就是我们需要认证的token
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("这个第二个Realm");
        SimpleAuthenticationInfo info =null;
        //1.将token转换为UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken) authenticationToken;
        //2.获取用户名即可
        String userName =upToken.getUsername();

        //3.查询数据库，是否存在指定用户名和密码的用户
        UserExample userExample =new UserExample();
        UserExample.Criteria c = userExample.createCriteria();
        c.andAccountEqualTo(userName);
        List<User> userList = userMapper.selectByExample(userExample);//（可连接不同的数据库）
        if(userList!=null){
            //4.如果查询到了，封装查询结果，返回给我们的调用
                Object principal = userName;
                Object credentials =userList.get(0).getPwd();
                String realmName =this.getName();
            //ByteSource
            ByteSource salt =ByteSource.Util.bytes(userName);
            //将数据库中查询出来的秘密进行同样的加密（正常情况是用mybatis，存储到数据库的数据就是经过加密的）
            SimpleHash sh =new SimpleHash("SHA1",credentials,salt,1024);

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

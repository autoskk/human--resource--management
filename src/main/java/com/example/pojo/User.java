package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users") // 确保表名小写
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id") // 指定列名
    private Integer userId; // 用户ID

    @Column(name = "user_name", unique = true, nullable = false) // 指定列名
    private String userName; // 用户名

    @Column(name = "user_password", nullable = false) // 指定列名
    private String userPassword; // 密码

    @Column(name = "role_id", nullable = false) // 指定列名
    private Integer roleId;

    // 如果需要关联 Role 实体，可以添加下面的代码
    // @ManyToOne
    // @JoinColumn(name = "role_id", referencedColumnName = "role_id", insertable = false, updatable = false)
    // private Role role; // 角色实体关系
}

package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userID; // 用户ID

    @Column(unique = true, nullable = false)
    private String username; // 用户名

    @Column(nullable = false)
    private String password; // 密码

    @Column(name = "role_id", nullable = false)
    private Integer roleId;

}

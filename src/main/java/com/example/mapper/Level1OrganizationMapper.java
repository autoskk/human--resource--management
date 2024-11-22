package com.example.mapper;

import com.example.pojo.Level1Organization;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface Level1OrganizationMapper {

    @Insert("INSERT INTO level_1_organizations (level_1_id, level_1_name) VALUES (#{level1Id}, #{level1Name})")
    void insertLevel1Organization(Level1Organization level1Organization);

    @Select("SELECT * FROM level_1_organizations WHERE level_1_id = #{level1Id}")
    Level1Organization findById(int level1Id);

    @Select("SELECT * FROM level_1_organizations")
    List<Level1Organization> findAll();

    @Update("UPDATE level_1_organizations SET level_1_name = #{level1Name} WHERE level_1_id = #{level1Id}")
    void updateLevel1Organization(Level1Organization level1Organization);

    @Delete("DELETE FROM level_1_organizations WHERE level_1_id = #{level1Id}")
    void deleteLevel1Organization(int level1Id);
}

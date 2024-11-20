package com.example.mapper;

import com.example.pojo.Level2Organization;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface Level2OrganizationMapper {

    @Insert("INSERT INTO level_2_organizations (level_2_id, level_1_id, level_2_name) VALUES (#{level2Id}, #{level1Id}, #{level2Name})")
    void insertLevel2Organization(Level2Organization level2Organization);

    @Select("SELECT * FROM level_2_organizations WHERE level_2_id = #{level2Id}")
    Level2Organization findById(int level2Id);

    @Select("SELECT * FROM level_2_organizations")
    List<Level2Organization> findAll();

    @Update("UPDATE level_2_organizations SET level_2_name = #{level2Name} WHERE level_2_id = #{level2Id}")
    void updateLevel2Organization(Level2Organization level2Organization);

    @Select("SELECT * FROM level_2_organizations WHERE level_1_id = #{level1Id}")
    List<Level2Organization> findByLevel1Id(int level1Id);

    @Delete("DELETE FROM level_2_organizations WHERE level_2_id = #{level2Id}")
    void deleteLevel2Organization(int level2Id);
}

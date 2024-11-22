package com.example.mapper;

import com.example.pojo.Level3Organization;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface Level3OrganizationMapper {

    @Insert("INSERT INTO level_3_organizations (level_3_id, level_2_id, level_3_name) VALUES (#{level3Id}, #{level2Id}, #{level3Name})")
    void insertLevel3Organization(Level3Organization level3Organization);

    @Select("SELECT * FROM level_3_organizations WHERE level_3_id = #{level3Id}")
    Level3Organization findById(int level3Id);

    @Select("SELECT * FROM level_3_organizations")
    List<Level3Organization> findAll();

    @Select("SELECT * FROM level_3_organizations WHERE level_2_id = #{level2Id}")
    List<Level3Organization> findByLevel2Id(int level2Id);

    @Update("UPDATE level_3_organizations SET level_3_name = #{level3Name} WHERE level_3_id = #{level3Id}")
    void updateLevel3Organization(Level3Organization level3Organization);

    @Delete("DELETE FROM level_3_organizations WHERE level_3_id = #{level3Id}")
    void deleteLevel3Organization(int level3Id);
}

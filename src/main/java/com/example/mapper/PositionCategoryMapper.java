package com.example.mapper;

import com.example.pojo.PositionCategory;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PositionCategoryMapper {

    @Insert("INSERT INTO position_categories (category_id, category_name) VALUES (#{categoryId}, #{categoryName})")
    void insertPositionCategory(PositionCategory positionCategory);

    @Select("SELECT * FROM position_categories WHERE category_id = #{categoryId}")
    PositionCategory findById(int categoryId);

    @Select("SELECT * FROM position_categories")
    List<PositionCategory> findAll();

    @Update("UPDATE position_categories SET category_name = #{categoryName} WHERE category_id = #{categoryId}")
    void updatePositionCategory(PositionCategory positionCategory);

    @Delete("DELETE FROM position_categories WHERE category_id = #{categoryId}")
    void deletePositionCategory(int categoryId);
}

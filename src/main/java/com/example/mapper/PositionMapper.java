package com.example.mapper;

import com.example.pojo.Position;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PositionMapper {

    @Insert("INSERT INTO positions (position_id, category_id, position_name) VALUES (#{positionId}, #{categoryId}, #{positionName})")
    void insertPosition(Position position);

    @Select("SELECT * FROM positions WHERE position_id = #{positionId}")
    Position findById(int positionId);

    @Select("SELECT * FROM positions")
    List<Position> findAll();

    @Select("SELECT * FROM positions WHERE category_id = #{categoryId}")
    List<Position> findByCategoryId(int categoryId);

    @Update("UPDATE positions SET position_name = #{positionName}, category_id = #{categoryId} WHERE position_id = #{positionId}")
    void updatePosition(Position position);

    @Delete("DELETE FROM positions WHERE position_id = #{positionId}")
    void deletePosition(int positionId);
}

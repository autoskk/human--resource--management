package com.example.mapper;

import com.example.pojo.EmployeeRecord;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface EmployeeMapper {

    @Insert("INSERT INTO employee_records (record_id, employee_name, gender, email, mobile, address, age, " +
            "education_level, major, salary_standard_id, bank, account_number, personal_history, created_by, created_date, status, " +
            "level_1_id, level_2_id, level_3_id, category_id, position_id, photo_url) " +
            "VALUES (#{recordId}, #{employeeName}, #{gender}, #{email}, #{mobile}, #{address}, #{age}, " +
            "#{educationLevel}, #{major}, #{salaryStandardId}, #{bank}, #{accountNumber}, #{personalHistory}, #{createdBy}, " +
            "#{createdDate}, #{status}, #{level1Id}, #{level2Id}, #{level3Id}, #{categoryId}, #{positionId}, #{photoUrl})")
    void insertEmployee(EmployeeRecord employeeRecord);

    @Select("SELECT * FROM employee_records WHERE record_id = #{recordId}")
    EmployeeRecord findById(String recordId);

    @Update("UPDATE employee_records SET employee_name = #{employeeName}, gender = #{gender}, email = #{email}, " +
            "mobile = #{mobile}, address = #{address}, age = #{age}, education_level = #{educationLevel}, major = #{major}, " +
            "salary_standard_id = #{salaryStandardId}, bank = #{bank}, account_number = #{accountNumber}, personal_history = #{personalHistory}, " +
            "level_1_id = #{level1Id}, level_2_id = #{level2Id}, level_3_id = #{level3Id}, category_id = #{categoryId}, position_id = #{positionId}, " +
            "photo_url = #{photoUrl}, status = #{status} WHERE record_id = #{recordId}")
    void updateEmployee(EmployeeRecord employeeRecord);

    @Delete("DELETE FROM employee_records WHERE record_id = #{recordId}")
    void deleteEmployee(String recordId);

    @Select("SELECT * FROM employee_records WHERE status = '待复核'")
    List<EmployeeRecord> findPendingEmployees();

    @Select("SELECT * FROM employee_records")
    List<EmployeeRecord> findAllEmployees();

    @Select("<script>" +
            "SELECT * FROM employee_records WHERE 1=1" +
            "<if test='level1Id != null'> AND level_1_id = #{level1Id}</if>" +
            "<if test='level2Id != null'> AND level_2_id = #{level2Id}</if>" +
            "<if test='level3Id != null'> AND level_3_id = #{level3Id}</if>" +
            "<if test='categoryId != null'> AND category_id = #{categoryId}</if>" +
            "<if test='positionId != null'> AND position_id = #{positionId}</if>" +
            "<if test='startDate != null'> AND created_date &gt;= #{startDate}</if>" +
            "<if test='endDate != null'> AND created_date &lt;= #{endDate}</if>" +
            "</script>")
    List<EmployeeRecord> searchEmployees(@Param("level1Id") Integer level1Id,
                                         @Param("level2Id") Integer level2Id,
                                         @Param("level3Id") Integer level3Id,
                                         @Param("categoryId") Integer categoryId,
                                         @Param("positionId") Integer positionId,
                                         @Param("startDate") Date startDate,
                                         @Param("endDate") Date endDate);

//<<<<<<< HEAD
    @Select("SELECT COUNT(*) FROM employee_records WHERE level_1_id = #{level1Id} AND level_2_id = #{level2Id} AND level_3_id = #{level3Id}")
    int countByOrganizations(@Param("level1Id") int level1Id, @Param("level2Id") int level2Id, @Param("level3Id") int level3Id);




//=======
    //  统计特定组织下的员工数量
    @Select("SELECT COUNT(*) FROM employee_records WHERE level_1_id = #{level1Id} AND level_2_id = #{level2Id} AND level_3_id = #{level3Id}")
    Integer countEmployeesByLevel(@Param("level1Id") int level1Id,
                              @Param("level2Id") int level2Id,
                              @Param("level3Id") int level3Id);

    // 计算特定组织下员工的基本薪资总额
    @Select("SELECT SUM(ss.base_salary) " +
            "FROM employee_records er " +
            "JOIN salary_standard ss ON er.salary_standard = ss.salary_standard_id " +
            "WHERE er.level_1_id = #{level1Id} " +
            "AND er.level_2_id = #{level2Id} " +
            "AND er.level_3_id = #{level3Id}")
    Double calculateTotalBaseSalary(@Param("level1Id") int level1Id,
                                    @Param("level2Id") int level2Id,
                                    @Param("level3Id") int level3Id);
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292

    // 在EmployeeMapper.java中
    @Update("UPDATE employee_records SET status = '已删除' WHERE record_id = #{recordId} AND status != '待复核'")
    void softDeleteEmployee(String recordId);


    @Update("UPDATE employee_records SET status = '正常' WHERE record_id = #{recordId} AND status = '已删除'")
    void restoreEmployee(String recordId);

}

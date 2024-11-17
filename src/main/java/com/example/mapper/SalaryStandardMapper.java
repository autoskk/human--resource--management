package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.SalaryStandard;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SalaryStandardMapper extends BaseMapper<SalaryStandard> {
    // 根据薪酬标准名称查找
    SalaryStandard selectByStandardName(String standardName);
}

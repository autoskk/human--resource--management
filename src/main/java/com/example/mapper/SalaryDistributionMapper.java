package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.SalaryDistribution;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SalaryDistributionMapper extends BaseMapper<SalaryDistribution> {
    // 这里可以添加更多自定义查询方法
}

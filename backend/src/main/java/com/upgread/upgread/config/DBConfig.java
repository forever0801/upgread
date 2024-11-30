package com.upgread.upgread.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = "com.upgread.upgread.model.dao")
public class DBConfig {

}

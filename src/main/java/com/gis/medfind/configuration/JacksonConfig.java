package com.gis.medfind.configuration;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.n52.jackson.datatype.jts.JtsModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

@Configuration
public class JacksonConfig {

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper mapper = new Jackson2ObjectMapperBuilder().build();
        System.out.println("***********************object mapper configured************");
        return mapper;
    }
    @Bean
    public JtsModule getJtsModule() {
        ObjectMapper mapper = objectMapper();
        JtsModule module = new JtsModule();
        mapper = mapper.registerModule(module);
        System.out.println("***********************jts module configured************");
        return module;
    }
}

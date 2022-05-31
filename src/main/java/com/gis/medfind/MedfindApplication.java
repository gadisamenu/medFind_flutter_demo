package com.gis.medfind;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
 
@SpringBootApplication
@ComponentScan(basePackages = "com.gis.medfind")
public class MedfindApplication {
 
	public static void main(String[] args) {
		SpringApplication.run(MedfindApplication.class, args);
	}

}

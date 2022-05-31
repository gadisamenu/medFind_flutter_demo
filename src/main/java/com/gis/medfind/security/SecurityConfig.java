package com.gis.medfind.security;

import com.gis.medfind.serviceImplem.CustomUserDetailServices;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
 

   @Bean
   PasswordEncoder bcryptPasswordEncoder() {
       return new BCryptPasswordEncoder();
   }
   @Bean
   public UserDetailsService userDetailsService(){
       return new CustomUserDetailServices();
   }
   @Bean
   public DaoAuthenticationProvider authenticationProvider() {
       DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
       authProvider.setUserDetailsService(userDetailsService());
       authProvider.setPasswordEncoder(bcryptPasswordEncoder());
        
       return authProvider;
   }

   @Override
   protected void configure(AuthenticationManagerBuilder auth) throws Exception {
       auth.authenticationProvider(authenticationProvider());
   }
   @Override
    public void configure(HttpSecurity http) throws Exception {
         http
                 .authorizeRequests()
            
            .antMatchers("/admin/**").hasAuthority("ADMIN")
            .antMatchers("/handle_request/**").hasAuthority("STAFF")
            .antMatchers("/watchlist").hasAuthority("USER")
            .antMatchers("/location","/profile").hasAnyAuthority("USER","STAFF","ADMIN")
            // .antMatchers("/profile").access("hasAuthority('USER') || hasAuthority('STAFF')")
            .antMatchers("/", "/**").permitAll()
            .anyRequest().authenticated()
         .and()
         .formLogin()
                 .loginPage("/login")
            .failureUrl("/login_failure")
            .usernameParameter("email")
            //.accessDeniedPage("/403")
            .defaultSuccessUrl("/login_success")
            .permitAll()
         .and()
                 .logout()
             .permitAll();

        http.csrf().disable();
        http.headers().frameOptions().disable();
    }
     
}


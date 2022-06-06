package com.gis.medfind.security;

import com.gis.medfind.jwt.JwtRequestFilter;
import com.gis.medfind.serviceImplem.CustomUserDetailServices;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(
		// securedEnabled = true,ppp
		// jsr250Enabled = true,
		prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	CustomUserDetailServices userDetailsService;


	@Bean
	public JwtRequestFilter authenticationJwtTokenFilter() {
		return new JwtRequestFilter();
	}
	@Override
	public void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
		authenticationManagerBuilder.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.cors().and().csrf().disable();
			// .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
			// .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
			// .authorizeRequests().antMatchers("/authenticate").permitAll()
			// .antMatchers("/api/**").authenticated()
			// .anyRequest().authenticated();
			http
                 .authorizeRequests()
            .antMatchers("/api/v1/authenticate","/api/v1/search", "/api/v1/register").permitAll()
            .antMatchers("/api/v1/admin/**").hasAuthority("ADMIN")
            // .antMatchers("/api/handle_request/**").hasAuthority("STAFF")
            .antMatchers("/api/v1/watchlist/**").hasAuthority("USER")
            .antMatchers("/api/v1/user/**","/api/v1/reservations/**").hasAnyAuthority("USER","PHARMACY","ADMIN")
            // .antMatchers("/profile").access("hasAuthority('USER') || hasAuthority('STAFF')")
            // .antMatchers("/", "/**").permitAll()
            .anyRequest().authenticated()
         .and()
         .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
         .and()
         .formLogin()
            .loginPage("/login")
            // .failureUrl("/login_failure")
            .usernameParameter("email")
            //.accessDeniedPage("/403")
            .defaultSuccessUrl("/success",false)
            .permitAll()
        .and()
                 .logout()
             .permitAll();

        
        // http.headers().frameOptions().disable();


		http.addFilterBefore(authenticationJwtTokenFilter(), UsernamePasswordAuthenticationFilter.class);
	}
	
    @Bean
    public CorsFilter corsFilter(){
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.addAllowedOriginPattern("*");
        // config.addAllowedOrigin("*");
        config.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type","charset","Access-Control-Allow-Origin"));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "PUT","OPTIONS","PATCH", "DELETE"));
        config.addExposedHeader("Authorization");       
        source.registerCorsConfiguration("/**",config);
        return new CorsFilter(source);
    }
}




















































































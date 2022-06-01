package com.gis.medfind.jwt;

import com.gis.medfind.serviceImplem.CustomUserDetailServices;

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
            .antMatchers("/api/authenticate","/api/search", "/api/register").permitAll()
            .antMatchers("/api/admin/**").hasAuthority("ADMIN")
            // .antMatchers("/api/handle_request/**").hasAuthority("STAFF")
            .antMatchers("/api/watchlist/**").hasAuthority("USER")
            .antMatchers("/api/profile/**").hasAnyAuthority("USER","STAFF","ADMIN")
            // .antMatchers("/profile").access("hasAuthority('USER') || hasAuthority('STAFF')")
            // .antMatchers("/", "/**").permitAll()
            .anyRequest().authenticated()
         .and()
         .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
         .and()
         .formLogin()
            .loginPage("/login")
            .failureUrl("/login_failure")
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
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");
        source.registerCorsConfiguration("/**",config);
        return new CorsFilter(source);
    }
}




















































































//package com.bet99.bet99test.service;
//
//import com.bet99.bet99test.entity.User;
//import com.bet99.bet99test.repository.UserRepository;
//import jakarta.annotation.PostConstruct;
//import lombok.RequiredArgsConstructor;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//
//import java.util.Collections;
//
//@Service
//@RequiredArgsConstructor
//public class CustomUserDetailsService implements UserDetailsService {
//
//    private final UserRepository userRepository;
//    private final PasswordEncoder encoder;
//
//    @Override
//    public UserDetails loadUserByUsername(String username)
//            throws UsernameNotFoundException {
//        User user = userRepository.findByUsername(username)
//                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
//
//        return new org.springframework.security.core.userdetails.User(
//                user.getUsername(),
//                user.getPassword(),
//                Collections.singleton(new SimpleGrantedAuthority(user.getRole()))
//        );
//    }
//
//    @PostConstruct
//    public void init() {
//        if (userRepository.findByUsername("admin").isEmpty()) {
//            User user = new User();
//            user.setId(-1L);
//            user.setUsername("admin");
//            user.setPassword(encoder.encode("admin123"));
//            user.setRole("ROLE_USER");
//            userRepository.save(user);
//        }
//    }
//}
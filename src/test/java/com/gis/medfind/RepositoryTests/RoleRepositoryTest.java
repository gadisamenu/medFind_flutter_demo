package com.gis.medfind.RepositoryTests;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.List;

import com.gis.medfind.entity.Privilege;
import com.gis.medfind.entity.Role;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.PrivilegeRepository;
import com.gis.medfind.repository.RoleRepository;
import com.gis.medfind.repository.UserRepository;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class RoleRepositoryTest {
 
    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private RoleRepository roleRepo;
     
    @Autowired
    private PrivilegeRepository prevRepo;
     
    @Autowired
    private UserRepository userRepo;
     
    @Test
    public void testCreateRole() {
        Role role = new Role();
            role.setName("ADMIN");
                Privilege pr = new Privilege();
                Privilege prev = prevRepo.save(pr);
                pr = new Privilege();
                Privilege prev2 = prevRepo.save(pr);
                List<Privilege> privileges = new ArrayList<>();
                    privileges.add(prev);
                    privileges.add(prev2);
            role.setPrivileges(privileges);
                User usr = new User();
                User user1 = userRepo.save(usr);
                usr = new User();
                User user2 = userRepo.save(usr);
                List<User> users = new ArrayList<>();
                    users.add(user1);
                    users.add(user2);
            role.setUsers(users);

        Role saved_role = roleRepo.save(role);

        Role exist_role = entityManager.find(Role.class, role.getId());
        assertThat(exist_role.getName()).isEqualTo(saved_role.getName());        
    }
}
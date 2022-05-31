package com.gis.medfind.RepositoryTests;
 
import static org.assertj.core.api.Assertions.assertThat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import com.gis.medfind.entity.Medicine;
import com.gis.medfind.entity.User;
import com.gis.medfind.entity.WatchList;
import com.gis.medfind.repository.MedicineRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;

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
public class WatchListRepositoryTest {
 
    @Autowired
    private TestEntityManager entityManager;
     
    @Autowired
    private WatchListRepository watchRepo;
     
    @Autowired
    private MedicineRepository medRepo;
     
    @Autowired
    private UserRepository userRepo;
     
    @Test
    public void testCreateWatchList() {
        WatchList watchlist = new WatchList();
        watchlist.setCreationDate(new Date().toString());
            List<Medicine> medicines = new ArrayList<>();
            Medicine med1 = medRepo.save(new Medicine());
            Medicine med2 = medRepo.save(new Medicine());
            Medicine med3 = medRepo.save(new Medicine());
            Medicine med4 = medRepo.save(new Medicine());

            medicines.add(med1);
            medicines.add(med2);
            medicines.add(med3);
            medicines.add(med4);
        
        // watchlist.setMedicines(medicines);
        User savedPatient = userRepo.save(new User());
        watchlist.setOwner(savedPatient);
        
        WatchList savedWatchList = watchRepo.save(watchlist);

        WatchList existWatchList = entityManager.find(WatchList.class, savedWatchList.getId());

        assertThat(savedWatchList.getCreationDate()).isEqualTo(existWatchList.getCreationDate());
        
    }
}
package com.gis.medfind.RepositoryTests;

import static org.assertj.core.api.Assertions.assertThat;

import com.gis.medfind.entity.Medicine;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.repository.PillRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;



@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class PillRepositoryTest {

    @Autowired
    PillRepository pillRepo;

    @Test
    public void testCreatePill() {
        int count = (int)pillRepo.count();
        Medicine md = new Medicine();

        Pill pl = new Pill();
            pl.setMedicine(md);
            pl.setAmount(20);
            pl.setStrength(500);
        pillRepo.save(pl);
        assertThat((int)pillRepo.count()).isEqualTo(count + 1);
    }
}

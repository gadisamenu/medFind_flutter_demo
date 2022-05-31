package com.gis.medfind.RepositoryTests;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.List;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Medicine;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.repository.MedPackRepository;
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
public class MedpackRepositoryTest {

    @Autowired
    PillRepository pillRepo;

    @Autowired
    MedPackRepository medpackRepo;

    @Test
    public void testCreateMedpack() {
        
        long initial_count = medpackRepo.count();
        Medicine md = new Medicine();
        Pill pl = new Pill();
            pl.setMedicine(md);
            pl.setAmount(20);
            pl.setStrength(500);
        pillRepo.save(pl);
        
        Medicine md1 = new Medicine();
        Pill pl1 = new Pill();
            pl1.setMedicine(md1);
            pl1.setAmount(20);
            pl1.setStrength(500);
        pillRepo.save(pl1);
        
        Medicine md2 = new Medicine();
        Pill pl2 = new Pill();
            pl2.setMedicine(md2);
            pl2.setAmount(20);
            pl2.setStrength(500);
        pillRepo.save(pl2);

        Medicine md3 = new Medicine();
        Pill pl3 = new Pill();
            pl3.setMedicine(md3);
            pl3.setAmount(20);
            pl3.setStrength(500);
        pillRepo.save(pl3);

        List<Pill> pills = new ArrayList<>();
            pills.add(pl);
            pills.add(pl1);
            pills.add(pl2);
            pills.add(pl3);

        MedPack mp = new MedPack();
            mp.setPills(pills);
            mp.setTag("Diabetes medicine");
        medpackRepo.save(mp);

        assertThat(initial_count + 1).isEqualTo(medpackRepo.count());
    }
}

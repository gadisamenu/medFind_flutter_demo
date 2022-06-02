package com.gis.medfind.ServiceImplementationTests;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;
import java.util.ArrayList;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.entity.User;
import com.gis.medfind.entity.WatchList;
import com.gis.medfind.repository.MedPackRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;
import com.gis.medfind.serviceImplem.WatchListServiceImpl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class WatchListServiceImplTest {     
    @Autowired
    private WatchListRepository watchRepo;
     
    @Autowired
    private MedPackRepository medpackRepo;
     
    @Autowired
    private UserRepository userRepo;
    
    @Autowired
    private WatchListServiceImpl watchListService;

    public User createTestUser(String email){
        User user = new User();
            user.setEmail(email);
            user.setFirstName("Amha");
            user.setLastName("Kindu");
            user.setPassword("WARMACHINEROX");
            user.setRoles(null);
        return userRepo.save(user);
    }

    private MedPack createTestMedPack(){
        MedPack medpack = watchListService.createMedpack("Diabetes medicine");

        watchListService.addPillToMedpack(medpack.getId(), "Aceon", 150, 18);
        watchListService.addPillToMedpack(medpack.getId(), "Abilify", 134, 12);
        watchListService.addPillToMedpack(medpack.getId(), "Acular", 110, 10);
        watchListService.addPillToMedpack(medpack.getId(), "AdreView", 85, 25);

        return medpack;
    }

    @Test
    public void test_createWatchList(){
        User user = createTestUser("amha@gmail.com");
        int initial_count = (int)watchRepo.count();

        ////////////////////////////////////////////////////////////////////////
        WatchList watch_list = watchListService.createWatchList(user.getId());//
        ////////////////////////////////////////////////////////////////////////

        assertThat(initial_count + 1).isEqualTo(watchRepo.count());
        assertThat(watch_list.getOwner().getEmail()).isEqualTo(user.getEmail());
    }

    @Test
    public void test_findWatchListByUserId(){
        User user = createTestUser("amha_2@gmail.com");
        WatchList watchlist_created = watchListService.createWatchList(user.getId());

        //////////////////////////////////////////////////////////////////////////////
        WatchList watchlist_fetched = watchRepo.findWatchListByUserId(user.getId());//
        //////////////////////////////////////////////////////////////////////////////

        assertThat(watchlist_created).isEqualTo(watchlist_fetched);
    }

    //Create
    @Test
    public void test_createMedpack(){
        int initial_count = (int)medpackRepo.count();

        //////////////////////////////////////////////////////////
        watchListService.createMedpack("Diabetes medicine");//
        //////////////////////////////////////////////////////////

        assertThat(initial_count + 1).isEqualTo(medpackRepo.count());
    }

    @Test
    public void test_createMedpackInWatchList(){
        User user = createTestUser("amha_7@gmail.com");
        watchListService.createWatchList(user.getId());

        int initial_count = (int)medpackRepo.count();

        /////////////////////////////////////////////////////////////////////////////////////////////////////////
        MedPack new_medpack = watchListService.createMedpackInWatchlist(user.getId(),"Diabetes medicine");//
        ////////////////////////////////////////////////////////////////////////////////////////////////////////

        List<MedPack> medpack_list = watchListService.getMedpacksFromWatchlist(user.getId());
        boolean success = medpack_list.contains(new_medpack);

        assertThat(initial_count + 1).isEqualTo(medpackRepo.count());
        assertThat(success).isTrue();
    }

    //Read
    @Test
    public void test_getMedpacksFromWatchlist(){
        User user = createTestUser("amha_3@gmail.com");
        WatchList watch_list = watchListService.createWatchList(user.getId());
        
        List<MedPack> medpacks = new ArrayList<>();
            MedPack medpack = new MedPack();
                medpack.setPills(new ArrayList<Pill>());
                medpack.setTag("tag_1");
                medpackRepo.save(medpack);

                medpacks.add(medpack);

            MedPack medpack1 = new MedPack();
                medpack1.setPills(new ArrayList<Pill>());
                medpack1.setTag("tag_2");
                medpackRepo.save(medpack1);

                medpacks.add(medpack1);

            MedPack medpack2 = new MedPack();
                medpack2.setPills(new ArrayList<Pill>());
                medpack2.setTag("tag_3");
                medpackRepo.save(medpack2);

                medpacks.add(medpack2);

        watch_list.setMedPacks(medpacks);
        watch_list = watchRepo.save(watch_list);

        /////////////////////////////////////////////////////////////////////////////////////////////////
        List<MedPack> fetched_medpacks = watchListService.getMedpacksFromWatchlist(user.getId());//
        /////////////////////////////////////////////////////////////////////////////////////////////////

        assertThat(medpacks).isEqualTo(fetched_medpacks);
    }

    //Update
    @Test
    public void test_addPillToMedpack(){
        MedPack medpack = createTestMedPack();

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Pill pill = watchListService.addPillToMedpack(medpack.getId(), "Aceon", 150, 18);//
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        List<Pill> pills = medpack.getPills();
        assertThat(pills).contains(pill);
    }

    @Test
    public void test_removePillFromMedpack(){
        MedPack medpack = createTestMedPack();

        Pill new_pill = watchListService.addPillToMedpack(medpack.getId(), "Adenoscan", 70, 10);
        
        ////////////////////////////////////////////////////////////////////////////
        watchListService.removePillFromMedpack(new_pill.getId(), medpack.getId());//
        ////////////////////////////////////////////////////////////////////////////

        assertThat(medpack.getPills()).doesNotContain(new_pill);
    }

    @Test
    public void test_editMedpackTag(){
        MedPack medpack = createTestMedPack();

        String old_tag = medpack.getTag();
        String new_tag = "Heart disease";

        ////////////////////////////////////////////////////////////
        watchListService.editMedpackTag(medpack.getId(), new_tag);//
        ////////////////////////////////////////////////////////////

        assertThat(old_tag).isNotEqualTo(medpack.getTag());
        assertThat(new_tag).isEqualTo(medpack.getTag());
    }

    @Test
    public void test_updatePillAmount(){
        MedPack medpack = createTestMedPack();
    
        Pill pill = watchListService.addPillToMedpack(medpack.getId(), "Acular", 110, 10);
        
        int old_amount = pill.getAmount();
        int new_amount = 15;
        //////////////////////////////////////////////////////////////////////////////
        watchListService.updatePillAmount(pill.getId(), new_amount);//
        //////////////////////////////////////////////////////////////////////////////

        assertThat(old_amount).isNotEqualTo(pill.getAmount());
        assertThat(pill.getAmount()).isEqualTo(new_amount);
    }

    @Test
    public void test_updatePillStregth(){
        MedPack medpack = createTestMedPack();

        Pill pill = watchListService.addPillToMedpack(medpack.getId(), "Acular", 110, 10);
        
        int old_strength = pill.getStrength();
        int new_strength = 93;

        ///////////////////////////////////////////////////////////////////////////////////
        watchListService.updatePillStrength(pill.getId(), new_strength);//
        ///////////////////////////////////////////////////////////////////////////////////
        
        assertThat(old_strength).isNotEqualTo(pill.getStrength());
        assertThat(new_strength).isEqualTo(pill.getStrength());
    }

    //Delete
    @Test
    public void test_deleteMedpack(){
        MedPack medpack = createTestMedPack();
        User user = createTestUser("amha_last@gmail.com");

        WatchList watch_list = watchListService.createWatchList(user.getId());
        watch_list.add_medpack(medpack);
        watch_list = watchRepo.save(watch_list);

        ////////////////////////////////////////////////////////////////
        watchListService.deleteMedpack(user.getId(), medpack.getId());//
        ////////////////////////////////////////////////////////////////

        Optional<MedPack> opt_medpack = medpackRepo.findById(medpack.getId());
        assertThat(opt_medpack.isPresent()).isFalse();
    }

    @Test
    public void test_findMedicinesCloseToUser(){

    }
}
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  WatchListBloc? watchListBloc;
  WatchListRepository watchRepo = WatchListRepository();

  const normal = TypeMatcher<NormalState>();
  const loading = TypeMatcher<LoadingState>();
  const empty = TypeMatcher<NoMedPackState>();
  const success = TypeMatcher<SuccessState>();
  const failure = TypeMatcher<FailureState>();

  setUp(() {
    watchListBloc = WatchListBloc();
  });
  tearDown(() {
    watchListBloc!.close();
  });

  group('Get medpacks', () {
    test('initial get event should be empty', () async {
      watchListBloc!.add(GetMedPacks());
      await expectLater(watchListBloc!.stream, emitsInOrder([loading, empty]));
      expect((watchListBloc!.state as NoMedPackState).message,
          "No medpacks in your watchlist");
    });

    test('A non-empty watchlist should result in normal state(success)',
        () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      expect("Diabetes medicines", addedMedpack.description);

      ///////////////////////////////////////////////////////////////////
      watchListBloc!.add(GetMedPacks());
      await expectLater(watchListBloc!.stream, emitsInOrder([loading, normal]));
      expect(State.medpacks.containsValue(addedMedpack), true);
      ///////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });

  group('Add medpack', () {
    test('adding medpack with valid description', () async {
      watchListBloc!.add(AddMedpack("Alzaimer Disease"));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully created medpack");

      int id = State.medpacks.keys.toList()[0];
      await watchRepo.removeMedPack(id);
    });

    test('adding medpack with an invalid description(length > 100)', () async {
      ///////////////////////////////////////////////////////////////////
      watchListBloc!.add(AddMedpack('''Alzaimer lkDiseasjsldjfsdfsldfskfls
      sfaljdkjfalsd;jfa;lkdjfasdlfkja;lskdjf;alksdf;alkkjsfflkjsflflkjllsff
      lslf;alskjf;alkjsdflkjsflkkjas;ffka;lskjffalskjff;klj;asf;kklj;aljsf
      sdghghjjkkfghhkjkjslj;sfalkjdsf;alksf;alskdfa;lsdf;asffa;lkfaskfalsf
      Alzaimer lkDiseasjsldjfsdfsldfskfls'''));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid description for medpack");
      ///////////////////////////////////////////////////////////////////
    });
  });

  group('Remove medpack', () {
    test('removing medpack', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      State.medpacks[addedMedpack.medpackId] = addedMedpack;

      watchListBloc!.add(RemoveMedpack(addedMedpack.medpackId));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully removed medpack");
      expect(true, State.medpacks.isEmpty);
      ////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });

  group('updating medpack tag', () {
    test('updating medpack with valid description', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      ////////////////////////////////////////////////////////////////////////////////
      watchListBloc!
          .add(UpdateMedPackTag(addedMedpack.medpackId, "Alzaimer Disease"));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully updated medpack tag");
      expect(
          true,
          (State.medpacks[addedMedpack.medpackId])?.description !=
              addedMedpack.description);
      ////////////////////////////////////////////////////////////////////////////////
      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });

    test('updating medpack with an invalid description(length > 100)',
        () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      ///////////////////////////////////////////////////////////////////
      watchListBloc!.add(UpdateMedPackTag(
          addedMedpack.medpackId, '''Alzaimer lkDiseasjsldjfsdfsldfskfls
      sfaljdkjfalsd;jfa;lkdjfasdlfkja;lskdjf;alksdf;alkkjsfflkjsflflkjllsff
      lslf;alskjf;alkjsdflkjsflkkjas;ffka;lskjffalskjff;klj;asf;kklj;aljsf
      sdghghjjkkfghhkjkjslj;sfalkjdsf;alksf;alskdfa;lsdf;asffa;lkfaskfalsf
      Alzaimer lkDiseasjsldjfsdfsldfskfls'''));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid description for medpack");
      ///////////////////////////////////////////////////////////////////
      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });

  group('Add pill', () {
    test('adding pill with valid inputs', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;

      ////////////////////////////////////////////////////////////////////////
      watchListBloc!.add(AddPill(addedMedpack.medpackId, "Aceon", 100, 20));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully added pill");
      ////////////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });

    // test('adding pill with invalid medicine name', () async {
    //   MedPack addedMedpack =
    //       await watchRepo.addMedPack("Diabetes medicines") as MedPack;
    //   /////////////////////////////////////////////////////////////////////////
    //   watchListBloc!
    //       .add(AddPill(addedMedpack.medpackId, "other medicine", 100, 20));
    //   await expectLater(
    //       watchListBloc!.stream, emitsInOrder([loading, failure]));
    //   expect((watchListBloc!.state as FailureState).message,
    //       "Invalid inputs to pill");
    //   ////////////////////////////////////////////////////////////////////////
    //   await watchRepo.removeMedPack(addedMedpack.medpackId);
    // });

    test('adding pill with invalid strength value(strength > 1000)', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      /////////////////////////////////////////////////////////////////////////
      watchListBloc!.add(AddPill(addedMedpack.medpackId, "Aceon", 2000, 20));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid inputs to pill");
      ////////////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });

    test('adding pill with invalid amount value(amount > 100)', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      /////////////////////////////////////////////////////////////////////////
      watchListBloc!.add(AddPill(addedMedpack.medpackId, "Aceon", 100, 1500));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid inputs to pill");
      ////////////////////////////////////////////////////////////////////////
      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });

  group('Remove pill', () {
    test('removing pill', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      State.medpacks[addedMedpack.medpackId] = addedMedpack;

      Pill addedPill_1 = await watchRepo.addPill(
          addedMedpack.medpackId, "Aceon", 100, 20) as Pill;
      State.medpacks[addedMedpack.medpackId]!.addPill(addedPill_1);

      Pill addedPill_2 = await watchRepo.addPill(
          addedMedpack.medpackId, "Abilify", 90, 20) as Pill;
      State.medpacks[addedMedpack.medpackId]!.addPill(addedPill_2);

      watchListBloc!
          .add(RemovePill(addedMedpack.medpackId, addedPill_1.pillId));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully removed pill");

      MedPack updatedMedpack = State.medpacks[addedMedpack.medpackId]!;

      expect(false, (updatedMedpack.getPills().contains(addedPill_1)));
      expect(true, (updatedMedpack.getPills().contains(addedPill_2)));
      ////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });

  group('updating pill', () {
    test('updating pill with invalid strength value(strength > 1000)',
        () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      Pill addedPill_1 = await watchRepo.addPill(
          addedMedpack.medpackId, "Aceon", 100, 20) as Pill;
      State.medpacks[addedMedpack.medpackId] = addedMedpack;
      State.medpacks[addedMedpack.medpackId]?.addPill(addedPill_1);

      /////////////////////////////////////////////////////////////////////////////////////
      watchListBloc!.add(
          UpdatePill(addedMedpack.medpackId, addedPill_1.pillId, 2000, 20));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid inputs to pill");
      /////////////////////////////////////////////////////////////////////////////////////

      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });

    test('updating pill with invalid amount value(amount > 100)', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      Pill addedPill_1 = await watchRepo.addPill(
          addedMedpack.medpackId, "Aceon", 100, 20) as Pill;
      State.medpacks[addedMedpack.medpackId] = addedMedpack;
      State.medpacks[addedMedpack.medpackId]!.addPill(addedPill_1);
      /////////////////////////////////////////////////////////////////////////
      watchListBloc!.add(
          UpdatePill(addedMedpack.medpackId, addedPill_1.pillId, 100, 1500));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, failure]));
      expect((watchListBloc!.state as FailureState).message,
          "Invalid inputs to pill");
      ////////////////////////////////////////////////////////////////////////
      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });

    test('updating pill with valid input', () async {
      MedPack addedMedpack =
          await watchRepo.addMedPack("Diabetes medicines") as MedPack;
      Pill addedPill_1 = await watchRepo.addPill(
          addedMedpack.medpackId, "Aceon", 100, 20) as Pill;
      State.medpacks[addedMedpack.medpackId] = addedMedpack;
      State.medpacks[addedMedpack.medpackId]?.addPill(addedPill_1);
      /////////////////////////////////////////////////////////////////////////
      watchListBloc!
          .add(UpdatePill(addedMedpack.medpackId, addedPill_1.pillId, 100, 25));
      await expectLater(
          watchListBloc!.stream, emitsInOrder([loading, success]));
      expect((watchListBloc!.state as SuccessState).message,
          "Successfully updated pill");
      ////////////////////////////////////////////////////////////////////////
      await watchRepo.removeMedPack(addedMedpack.medpackId);
    });
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

final WatchListRepository watchListRepo = WatchListRepository();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('testing addmedpacks', addMepackTest);
  test('testing getmedpacks', getMedpacksTest);

  test('testing removemedpack', removeMepackTest);
  test('testing updatemedpack', updateMedpackTest);

  test('testing createpill', addPillTest);
  test('testing removepill', removePillTest);
  test('testing update pill', updatePillTest);
}

addMepackTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;
  expect("Diabetes medicines", addedMedpack.description);
  await watchListRepo.removeMedPack(addedMedpack.medpackId);
}

getMedpacksTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  List<MedPack>? medpacks = await watchListRepo.getMedPacks();
  await watchListRepo.removeMedPack(addedMedpack.medpackId);
  print(medpacks);
  bool pass = medpacks!.contains(addedMedpack);

  expect(true, pass);
  expect(true, medpacks.isNotEmpty);
}

removeMepackTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  await watchListRepo.removeMedPack(addedMedpack.medpackId);

  List<MedPack>? medpacks = await watchListRepo.getMedPacks();
  expect(false, medpacks!.contains(addedMedpack));
}

addPillTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  Pill newPill = await watchListRepo.addPill(
      addedMedpack.medpackId, "Aceon", 500, 14) as Pill;

  List<MedPack>? medpacks = await watchListRepo.getMedPacks();
  bool found = false;
  for (MedPack mp in medpacks!) {
    for (Pill pl in mp.getPills()) {
      if (pl == newPill) {
        found = true;
      }
    }
  }
  await watchListRepo.removeMedPack(addedMedpack.medpackId);
  expect(true, found);
}

removePillTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  Pill newPill = await watchListRepo.addPill(
      addedMedpack.medpackId, "Aceon", 500, 14) as Pill;

  await watchListRepo.removePill(addedMedpack.medpackId, newPill.pillId);

  List<MedPack>? medpacks = await watchListRepo.getMedPacks();
  bool found = false;
  for (MedPack mp in medpacks!) {
    for (Pill pl in mp.getPills()) {
      if (pl == newPill) {
        found = true;
      }
    }
  }
  expect(false, found);
  await watchListRepo.removeMedPack(addedMedpack.medpackId);
}

updateMedpackTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  MedPack updatedMedpack = await watchListRepo.updateMedpack(
      addedMedpack.medpackId, "Heart Disease medicines") as MedPack;

  expect("Heart Disease medicines", updatedMedpack.description);
  expect(addedMedpack.medpackId, updatedMedpack.medpackId);

  await watchListRepo.removeMedPack(addedMedpack.medpackId);
}

updatePillTest() async {
  MedPack addedMedpack =
      await watchListRepo.addMedPack("Diabetes medicines") as MedPack;

  Pill newPill = await watchListRepo.addPill(
      addedMedpack.medpackId, "Abilify", 500, 14) as Pill;

  Pill updatedPill = await watchListRepo.updatePill(
      addedMedpack.medpackId, newPill.pillId, 100, 20) as Pill;

  List<MedPack>? medpacks = await watchListRepo.getMedPacks();
  int fetched_strength = 0, fetched_amount = 0;
  for (MedPack mp in medpacks!) {
    for (Pill pl in mp.getPills()) {
      if (pl == newPill) {
        fetched_strength = pl.strength;
        fetched_amount = pl.amount;
      }
    }
  }
  expect(100, updatedPill.strength);
  expect(20, updatedPill.amount);

  expect(100, fetched_strength);
  expect(20, fetched_amount);

  await watchListRepo.removeMedPack(addedMedpack.medpackId);
}

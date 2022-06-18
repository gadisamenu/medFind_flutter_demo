import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_bloc.dart';
import 'package:medfind_flutter/Application/MedicineSearch/medicine_search_event.dart';

Set<Set<void>> handleSubmission(String value, BuildContext context) {
  return {
    if (value.length > 0)
      {
        context.push("/search"),
        BlocProvider.of<MedicineSearchBloc>(context).add(
          Search(9.0474852, 38.7596047, value),
        ),
      }
  };
}

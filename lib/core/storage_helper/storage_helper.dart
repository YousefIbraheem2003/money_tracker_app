import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_money_tracker/core/models/commitment_card_model.dart';

class StorageHelper {
  static const String commitmentsKey = 'commitments';

  static Future<void> saveCommitments(List<CommitmentModel> commitments) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = commitments
        .map((commitment) => commitment.toJson())
        .toList();

    final jsonString = jsonEncode(jsonList);

    await prefs.setString(commitmentsKey, jsonString);
    print('SAVED: $jsonString');
  }

  static Future<List<CommitmentModel>> loadCommitments() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(commitmentsKey);
    print('LOADED: $jsonString');
    if (jsonString == null) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List;

    return jsonList
        .map((commitment) => CommitmentModel.fromJson(commitment))
        .toList();
  }
}

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String phone;
  final String status;
  final String? avatarUrl;
  final int limit;
  final int availableLimit;
  final List<PurchaseModel> purchases;
  final List<ScoringHistoryModel> scoringHistory;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.status,
    this.avatarUrl,
    required this.limit,
    required this.availableLimit,
    this.purchases = const [],
    this.scoringHistory = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      avatarUrl: json['avatar_url'],
      limit: json['limit'] ?? 0,
      availableLimit: json['available_limit'] ?? 0,
      purchases: (json['purchases'] as List?)
              ?.map((e) => PurchaseModel.fromJson(e))
              .toList() ??
          [],
      scoringHistory: (json['scoring_history'] as List?)
              ?.map((e) => ScoringHistoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'status': status,
      'avatar_url': avatarUrl,
      'limit': limit,
      'available_limit': availableLimit,
      'purchases': purchases.map((e) => e.toJson()).toList(),
      'scoring_history': scoringHistory.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        phone,
        status,
        avatarUrl,
        limit,
        availableLimit,
        purchases,
        scoringHistory,
      ];
}

class PurchaseModel extends Equatable {
  final String id;
  final String productName;
  final int amount;
  final String date;
  final String status;

  const PurchaseModel({
    required this.id,
    required this.productName,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'] ?? '',
      productName: json['product_name'] ?? '',
      amount: json['amount'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'amount': amount,
      'date': date,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, productName, amount, date, status];
}

class ScoringHistoryModel extends Equatable {
  final String id;
  final String date;
  final int score;
  final String status;

  const ScoringHistoryModel({
    required this.id,
    required this.date,
    required this.score,
    required this.status,
  });

  factory ScoringHistoryModel.fromJson(Map<String, dynamic> json) {
    return ScoringHistoryModel(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      score: json['score'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'score': score,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, date, score, status];
}

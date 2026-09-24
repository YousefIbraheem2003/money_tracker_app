abstract class MoneyPlansModel {
  final String planName;
  final String planInfo;
  final bool isExpanded;
  final PlanType planType;
  const MoneyPlansModel({
    required this.planName,
    required this.planInfo,
    this.isExpanded = false,
    required this.planType,
  });

  Map<String, double> calculatePlan(double totalIncome);

  MoneyPlansModel copyWith({
    String? planName,
    String? planInfo,
    bool? isExpanded,
  });
}

class FiftyThirtyTwentyPlan extends MoneyPlansModel {
  const FiftyThirtyTwentyPlan({
    super.planName = '50/30/20',
    super.planInfo =
        'Split income into Needs (50%), Wants (30%), & Savings/Debt (20%)',
    super.isExpanded = false,
    super.planType = PlanType.fiftyThirtyTwenty,
  });

  @override
  Map<String, double> calculatePlan(double totalIncome) {
    return {
      'Needs': totalIncome * 0.50,
      'Wants': totalIncome * 0.30,
      'Saving/Debt': totalIncome * 0.20,
    };
  }

  @override
  FiftyThirtyTwentyPlan copyWith({
    String? planName,
    String? planInfo,
    bool? isExpanded,
  }) {
    return FiftyThirtyTwentyPlan(
      planName: planName ?? this.planName,
      planInfo: planInfo ?? this.planInfo,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class PayYourselfFirstPlan extends MoneyPlansModel {
  const PayYourselfFirstPlan({
    super.planName = 'Pay Yourself First',
    super.planInfo =
        'Automatically transfer savings first, then spend whatever is left',
    super.isExpanded = false,
    super.planType = PlanType.payYourselfFirst,
  });
  @override
  Map<String, double> calculatePlan(double totalIncome) {
    return {
      'savings': totalIncome * 0.20,
      'spending Money': totalIncome * 0.80,
    };
  }

  @override
  PayYourselfFirstPlan copyWith({
    String? planName,
    String? planInfo,
    bool? isExpanded,
  }) {
    return PayYourselfFirstPlan(
      planName: planName ?? this.planName,
      planInfo: planInfo ?? this.planInfo,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class ZeroBasedPlan extends MoneyPlansModel {
  const ZeroBasedPlan({
    super.planName = 'Zero-Based',
    super.planInfo =
        'Assign every dollar a specific job until Income minus Expenses equals \$0',
    super.isExpanded = false,
    super.planType = PlanType.zeroBased,
  });

  @override
  Map<String, double> calculatePlan(double totalIncome) {
    return {'Unallocated': totalIncome};
  }

  @override
  ZeroBasedPlan copyWith({
    String? planName,
    String? planInfo,
    bool? isExpanded,
  }) {
    return ZeroBasedPlan(
      planName: planName ?? this.planName,
      planInfo: planInfo ?? this.planInfo,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class EnvelopeSystemPlan extends MoneyPlansModel {
  const EnvelopeSystemPlan({
    super.planName = 'Zero-Based',
    super.planInfo =
        'Assign every dollar a specific job until Income minus Expenses equals \$0',
    super.isExpanded = false,
    super.planType = PlanType.envelopeSystem,
  });

  @override
  Map<String, double> calculatePlan(double totalIncome) {
    return {'Unallocated': totalIncome};
  }

  @override
  ZeroBasedPlan copyWith({
    String? planName,
    String? planInfo,
    bool? isExpanded,
  }) {
    return ZeroBasedPlan(
      planName: planName ?? this.planName,
      planInfo: planInfo ?? this.planInfo,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

enum PlanType { fiftyThirtyTwenty, zeroBased, payYourselfFirst, envelopeSystem }

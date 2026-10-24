/// Obuna darajasi (narx tartibida). Yuqori daraja pastkisining hamma imkoniyatini
/// o'z ichiga oladi: Talaba < Ustoz (+guruhlar) < Mutaxassis (+DMED, atamalar).
enum BillingTier {
  free,
  student,
  teacher,
  specialist;

  bool includes(BillingTier other) => index >= other.index;
}

/// Obuna ochadigan imkoniyat turlari.
enum BillingFeature { study, dmed, groups }

extension BillingTierFeatures on BillingTier {
  Set<BillingFeature> get features => switch (this) {
    BillingTier.free => const {},
    BillingTier.student => const {BillingFeature.study},
    BillingTier.teacher => const {BillingFeature.study, BillingFeature.groups},
    BillingTier.specialist => const {
      BillingFeature.study,
      BillingFeature.dmed,
      BillingFeature.groups,
    },
  };
}

/// 30 kunlik bepul sinov: o'rganish va DMED. Guruhlar (ustoz) sinovga kirmaydi.
const trialFeatures = {BillingFeature.study, BillingFeature.dmed};

enum BillingPeriod { monthly, yearly }

/// Do'kon mahsuloti. Narx faqat zaxira matn: asl narx do'kondan keladi.
class BillingPlan {
  const BillingPlan(this.tier, this.period, this.productId, this.fallbackUsd);

  final BillingTier tier;
  final BillingPeriod period;
  final String productId;
  final String fallbackUsd;

  static const trialDays = 30;

  static const all = <BillingPlan>[
    BillingPlan(
      BillingTier.student,
      BillingPeriod.monthly,
      'uz.nurseguide.app.student.monthly',
      r'$1.49',
    ),
    BillingPlan(
      BillingTier.student,
      BillingPeriod.yearly,
      'uz.nurseguide.app.student.yearly',
      r'$9.99',
    ),
    BillingPlan(
      BillingTier.teacher,
      BillingPeriod.monthly,
      'uz.nurseguide.app.teacher.monthly',
      r'$2.49',
    ),
    BillingPlan(
      BillingTier.teacher,
      BillingPeriod.yearly,
      'uz.nurseguide.app.teacher.yearly',
      r'$24.99',
    ),
    BillingPlan(
      BillingTier.specialist,
      BillingPeriod.monthly,
      'uz.nurseguide.app.pro.monthly',
      r'$3.49',
    ),
    BillingPlan(
      BillingTier.specialist,
      BillingPeriod.yearly,
      'uz.nurseguide.app.pro.yearly',
      r'$34.99',
    ),
  ];

  static Set<String> get productIds => {for (final p in all) p.productId};

  static BillingPlan? byProductId(String id) {
    for (final p in all) {
      if (p.productId == id) return p;
    }
    return null;
  }
}

/// Qaysi yo'l qaysi imkoniyatni talab qiladi (`null` — bepul).
BillingFeature? requiredFeature(String loc) {
  if (loc.startsWith('/learn/classes')) return BillingFeature.groups;
  if (loc == '/library/dmed' || loc == '/library/glossary') {
    return BillingFeature.dmed;
  }
  if (loc.startsWith('/learn/toifa') ||
      loc.startsWith('/learn/exam') ||
      loc.startsWith('/learn/practice') ||
      loc.startsWith('/learn/quiz') ||
      loc == '/library/saved') {
    return BillingFeature.study;
  }
  return null;
}

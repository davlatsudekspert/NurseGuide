/// Obuna darajasi. Yuqori daraja pastkisining hamma imkoniyatini o'z ichiga oladi.
enum BillingTier {
  free,
  student,
  specialist,
  teacher;

  bool includes(BillingTier other) => index >= other.index;
}

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
      r'$12.99',
    ),
    BillingPlan(
      BillingTier.specialist,
      BillingPeriod.monthly,
      'uz.nurseguide.app.pro.monthly',
      r'$2.99',
    ),
    BillingPlan(
      BillingTier.specialist,
      BillingPeriod.yearly,
      'uz.nurseguide.app.pro.yearly',
      r'$24.99',
    ),
    BillingPlan(
      BillingTier.teacher,
      BillingPeriod.monthly,
      'uz.nurseguide.app.teacher.monthly',
      r'$4.99',
    ),
    BillingPlan(
      BillingTier.teacher,
      BillingPeriod.yearly,
      'uz.nurseguide.app.teacher.yearly',
      r'$39.99',
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

/// Qaysi yo'l qaysi darajani talab qiladi (billing yoqilgan bo'lsa).
BillingTier requiredTier(String loc) {
  if (loc.startsWith('/learn/classes') || loc.startsWith('/admin')) {
    return BillingTier.teacher;
  }
  if (loc == '/library/dmed' ||
      loc == '/library/glossary' ||
      loc == '/workplace/dmed') {
    return BillingTier.specialist;
  }
  if (loc.startsWith('/learn/toifa') ||
      loc.startsWith('/learn/exam') ||
      loc.startsWith('/learn/practice') ||
      loc.startsWith('/learn/quiz') ||
      loc == '/library/saved') {
    return BillingTier.student;
  }
  return BillingTier.free;
}

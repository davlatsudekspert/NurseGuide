import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/billing/billing_controller.dart';
import 'package:nurseguide/features/billing/billing_plan.dart';

class _Gw implements PurchaseGateway {
  final ctl = StreamController<List<PurchaseDetails>>.broadcast();
  final completed = <String>[];

  @override
  Stream<List<PurchaseDetails>> get purchases => ctl.stream;
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<Map<String, ProductDetails>> products(Set<String> ids) async => {};
  @override
  Future<bool> buy(ProductDetails product) async => true;
  @override
  Future<void> restore() async {}
  @override
  Future<void> complete(PurchaseDetails p) async => completed.add(p.productID);
}

PurchaseDetails _p(String id, DateTime at, {bool restored = false}) {
  return PurchaseDetails(
    productID: id,
    verificationData: PurchaseVerificationData(
      localVerificationData: '',
      serverVerificationData: '',
      source: 'test',
    ),
    transactionDate: '${at.millisecondsSinceEpoch}',
    status: restored ? PurchaseStatus.restored : PurchaseStatus.purchased,
  )..pendingCompletePurchase = true;
}

void main() {
  final now = DateTime(2026, 11, 1);

  test('narx jadvali: 3 daraja x 2 davr, eng arzoni Talaba oylik 1.49', () {
    expect(BillingPlan.all, hasLength(6));
    expect(BillingPlan.productIds, hasLength(6));
    final cheapest = BillingPlan.all.first;
    expect(cheapest.tier, BillingTier.student);
    expect(cheapest.fallbackUsd, r'$1.49');
    expect(BillingPlan.trialDays, 30);
  });

  test('billing o‘chiq: hamma yo‘l ochiq', () {
    final c = BillingController(store: MemoryKeyValueStore(), enabled: false);
    expect(c.allows('/learn/toifa/test'), isTrue);
    expect(c.allows('/learn/classes'), isTrue);
  });

  test(
    'billing yoqiq: bepul darajada yopiq, daraja oshgach ochiladi',
    () async {
      final gw = _Gw();
      final c = BillingController(
        store: MemoryKeyValueStore(),
        gateway: gw,
        enabled: true,
        now: () => now,
      );
      await c.start();
      expect(c.allows('/home'), isTrue);
      expect(c.allows('/procedures/x'), isTrue);
      expect(c.allows('/learn/daily'), isTrue);
      expect(c.allows('/learn/toifa/test'), isFalse);
      expect(c.allows('/library/dmed'), isFalse);
      expect(c.allows('/learn/classes/g/1'), isFalse);

      gw.ctl.add([_p('uz.nurseguide.app.student.monthly', now)]);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(c.tier, BillingTier.student);
      expect(c.allows('/learn/toifa/test'), isTrue);
      expect(c.allows('/library/dmed'), isFalse);
      expect(gw.completed, ['uz.nurseguide.app.student.monthly']);

      gw.ctl.add([_p('uz.nurseguide.app.teacher.yearly', now, restored: true)]);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(c.tier, BillingTier.teacher);
      expect(c.allows('/library/dmed'), isTrue);
      expect(c.allows('/learn/classes/g/1'), isTrue);
    },
  );

  test('muddati o‘tgan obuna bepulga qaytadi', () async {
    final store = MemoryKeyValueStore();
    final gw = _Gw();
    var t = now;
    final c = BillingController(
      store: store,
      gateway: gw,
      enabled: true,
      now: () => t,
    );
    await c.start();
    gw.ctl.add([_p('uz.nurseguide.app.pro.monthly', now)]);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(c.tier, BillingTier.specialist);

    t = now.add(const Duration(days: 20));
    expect(
      BillingController(store: store, enabled: true, now: () => t).tier,
      BillingTier.specialist,
    );
    t = now.add(const Duration(days: 40));
    expect(
      BillingController(store: store, enabled: true, now: () => t).tier,
      BillingTier.free,
    );
  });

  test('eski xarid (muddati o‘tgan) darajani bermaydi', () async {
    final gw = _Gw();
    final c = BillingController(
      store: MemoryKeyValueStore(),
      gateway: gw,
      enabled: true,
      now: () => now,
    );
    await c.start();
    gw.ctl.add([
      _p(
        'uz.nurseguide.app.pro.monthly',
        now.subtract(const Duration(days: 90)),
      ),
    ]);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(c.tier, BillingTier.free);
  });

  test('yo‘l talablari', () {
    expect(requiredTier('/learn'), BillingTier.free);
    expect(requiredTier('/learn/daily'), BillingTier.free);
    expect(requiredTier('/learn/toifa/oral'), BillingTier.student);
    expect(requiredTier('/library/dmed'), BillingTier.specialist);
    expect(requiredTier('/learn/classes/new'), BillingTier.teacher);
  });
}

import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/storage/kv_store.dart';
import 'billing_plan.dart';

/// Billing yoqilganmi. Do'konda mahsulotlar yaratilmaguncha o'chiq turadi:
/// o'chiq bo'lsa hech qaysi bo'lim yopilmaydi.
const kBillingEnabled = bool.fromEnvironment('NG_BILLING_ENABLED');

/// Do'kon bilan aloqa (test uchun almashtiriladi).
abstract interface class PurchaseGateway {
  Stream<List<PurchaseDetails>> get purchases;
  Future<bool> isAvailable();
  Future<Map<String, ProductDetails>> products(Set<String> ids);
  Future<bool> buy(ProductDetails product);
  Future<void> restore();
  Future<void> complete(PurchaseDetails purchase);
}

class StorePurchaseGateway implements PurchaseGateway {
  StorePurchaseGateway([InAppPurchase? iap])
    : _iap = iap ?? InAppPurchase.instance;

  final InAppPurchase _iap;

  @override
  Stream<List<PurchaseDetails>> get purchases => _iap.purchaseStream;

  @override
  Future<bool> isAvailable() => _iap.isAvailable();

  @override
  Future<Map<String, ProductDetails>> products(Set<String> ids) async {
    final res = await _iap.queryProductDetails(ids);
    return {for (final p in res.productDetails) p.id: p};
  }

  @override
  Future<bool> buy(ProductDetails product) => _iap.buyNonConsumable(
    purchaseParam: PurchaseParam(productDetails: product),
  );

  @override
  Future<void> restore() => _iap.restorePurchases();

  @override
  Future<void> complete(PurchaseDetails purchase) =>
      _iap.completePurchase(purchase);
}

/// Foydalanuvchining joriy darajasi. Daraja qurilmada saqlanadi, do'kon
/// hodisalari bilan yangilanadi (server tekshiruvi keyingi bosqichda).
class BillingController extends ChangeNotifier {
  BillingController({
    required KeyValueStore store,
    PurchaseGateway? gateway,
    bool? enabled,
    DateTime Function()? now,
  }) : _gateway = gateway ?? (kBillingEnabled ? StorePurchaseGateway() : null),
       _store = store, // ignore: prefer_initializing_formals
       _now = now ?? DateTime.now,
       enabled = enabled ?? kBillingEnabled {
    _tier = _readTier();
  }

  final KeyValueStore _store;
  final DateTime Function() _now;
  final PurchaseGateway? _gateway;
  final bool enabled;

  StreamSubscription<List<PurchaseDetails>>? _sub;
  BillingTier _tier = BillingTier.free;
  Map<String, ProductDetails> _products = const {};
  bool _storeReady = false;
  String? _error;
  bool _busy = false;

  BillingTier _granted = BillingTier.free;

  /// Do'kon xaridi yoki admin bergan Pro dan yuqorisi.
  BillingTier get tier => _granted.index > _tier.index ? _granted : _tier;

  /// Server (`/v1/me`) admin bergan Prosini xabar qiladi; `null` — yo'q.
  void applyGrant(String? wire, DateTime? until) {
    final t = BillingTier.values.where((e) => e.name == wire).firstOrNull;
    final live = t != null && (until == null || until.isAfter(_now()));
    final next = live ? t : BillingTier.free;
    if (next == _granted) return;
    _granted = next;
    notifyListeners();
  }

  Map<String, ProductDetails> get products => _products;
  bool get storeReady => _storeReady;
  String? get error => _error;
  bool get busy => _busy;

  /// Yo'l ochiqmi (billing o'chiq bo'lsa — doim ochiq).
  bool allows(String loc) {
    if (!enabled) return true;
    final need = requiredFeature(loc);
    return need == null || has(need);
  }

  /// Daraja yoki faol bepul sinov shu imkoniyatni beradimi.
  bool has(BillingFeature f) =>
      tier.features.contains(f) || (trialActive && trialFeatures.contains(f));

  DateTime? _trialUntil;

  bool get trialActive => _trialUntil?.isAfter(_now()) ?? false;
  DateTime? get trialUntil => trialActive ? _trialUntil : null;

  /// Server (`/v1/me`) bepul sinov muddatini xabar qiladi (hisob + qurilma
  /// bo'yicha bir martalik); `null` — sinov yo'q yoki tugagan.
  void applyTrial(DateTime? until) {
    if (until == _trialUntil) return;
    _trialUntil = until;
    notifyListeners();
  }

  /// Saqlangan daraja, muddati o'tmagan bo'lsa. Do'kon yangilanishlarni
  /// (uzaytirishni) har ishga tushganda yetkazadi; bekor qilingan obuna
  /// muddat tugagach o'zi bepulga qaytadi.
  BillingTier _readTier() {
    final until = DateTime.tryParse(
      _store.getString(StoreKeys.billingUntil) ?? '',
    );
    if (until == null || !until.isAfter(_now())) return BillingTier.free;
    final raw = _store.getString(StoreKeys.billingTier);
    for (final t in BillingTier.values) {
      if (t.name == raw) return t;
    }
    return BillingTier.free;
  }

  /// Xarid sanasidan boshlab amal qilish muddati (sinov 30 kun + zaxira).
  static Duration validFor(BillingPeriod p) => p == BillingPeriod.yearly
      ? const Duration(days: 368)
      : const Duration(days: 33);

  DateTime _purchasedAt(PurchaseDetails p) {
    final ms = int.tryParse(p.transactionDate ?? '');
    return ms == null ? _now() : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> start() async {
    final gw = _gateway;
    if (!enabled || gw == null) return;
    _sub ??= gw.purchases.listen(
      _onPurchases,
      onError: (Object e) {
        _error = e.toString();
        notifyListeners();
      },
    );
    _storeReady = await gw.isAvailable();
    if (_storeReady) _products = await gw.products(BillingPlan.productIds);
    notifyListeners();
  }

  Future<void> buy(BillingPlan plan) async {
    final p = _products[plan.productId];
    final gw = _gateway;
    if (p == null || gw == null) {
      _error = 'unavailable';
      notifyListeners();
      return;
    }
    _error = null;
    _busy = true;
    notifyListeners();
    try {
      await gw.buy(p);
    } catch (e) {
      _error = e.toString();
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> restore() async {
    final gw = _gateway;
    if (gw == null) return;
    _busy = true;
    _error = null;
    notifyListeners();
    try {
      await gw.restore();
    } catch (e) {
      _error = e.toString();
    }
    _busy = false;
    notifyListeners();
  }

  Future<void> _onPurchases(List<PurchaseDetails> list) async {
    var best = BillingTier.free;
    DateTime? until;
    for (final p in list) {
      final plan = BillingPlan.byProductId(p.productID);
      if (plan == null) continue;
      switch (p.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final end = _purchasedAt(p).add(validFor(plan.period));
          if (!end.isAfter(_now())) break;
          if (plan.tier.index > best.index) {
            best = plan.tier;
            until = end;
          }
        case PurchaseStatus.error:
          _error = p.error?.message ?? 'error';
        case PurchaseStatus.pending:
        case PurchaseStatus.canceled:
          break;
      }
      if (p.pendingCompletePurchase) await _gateway?.complete(p);
    }
    _busy = false;
    if (best.index > BillingTier.free.index) {
      _tier = best;
      await _store.setString(StoreKeys.billingTier, best.name);
      await _store.setString(StoreKeys.billingUntil, until!.toIso8601String());
    }
    notifyListeners();
  }

  /// Faqat testlar uchun.
  @visibleForTesting
  Future<void> debugSetTier(BillingTier t) async {
    _tier = t;
    await _store.setString(StoreKeys.billingTier, t.name);
    await _store.setString(
      StoreKeys.billingUntil,
      _now().add(const Duration(days: 30)).toIso8601String(),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

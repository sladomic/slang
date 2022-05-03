import 'package:fast_i18n/api/app_locale_id.dart';

/// Map handling the mapping between the global locale type
/// and the project specific enum
class AppLocaleIdMapper<E> {
  /// Maps locale ids to the enum type
  final Map<AppLocaleId, E> _idToEnumMap;

  /// The same map as [_idToEnumMap] but inversed
  final Map<E, AppLocaleId> _enumToIdMap;

  AppLocaleIdMapper({required Map<AppLocaleId, E> localeMap})
      : _idToEnumMap = localeMap,
        _enumToIdMap = _inverseMap(localeMap);

  /// Returns the corresponding enum of given locale id.
  /// May be null
  E? toEnum(AppLocaleId id) => _idToEnumMap[id];

  /// Returns the corresponding locale id of given enum
  AppLocaleId toId(E e) => _enumToIdMap[e]!;

  /// Returns all locale ids. Unspecified order!
  List<AppLocaleId> getLocaleIds() {
    return _idToEnumMap.keys.toList();
  }
}

Map<E, AppLocaleId> _inverseMap<E>(Map<AppLocaleId, E> originalMap) {
  final result = <E, AppLocaleId>{};
  originalMap.forEach((key, value) {
    result[value] = key;
  });
  return result;
}
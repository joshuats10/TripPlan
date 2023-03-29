import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final customCacheManager = CacheManager(Config(
  'customCacheKey',
  stalePeriod: Duration(days: 15),
  maxNrOfCacheObjects: 100,
  repo: JsonCacheInfoRepository(databaseName: 'customCacheKey'),
));

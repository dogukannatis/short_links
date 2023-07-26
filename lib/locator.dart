import 'package:get_it/get_it.dart';
import 'package:short_links/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=>Api());
}
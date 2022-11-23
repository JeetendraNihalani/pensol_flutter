




import '../../../../../../app/modules/home/domain/services/home_service.dart';

/// > This class is an abstract class that defines the methods that will be used to interact with the
/// database
abstract class HomeRepository {

  factory HomeRepository() => HomeService();

  
   /// A method that is used to get the mobile settings from the database.
  Future getMobileSetting();
}
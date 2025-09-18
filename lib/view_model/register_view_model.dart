import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class RegisterViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoadingLocation = false;

  // final List<Locations> _location = [];

  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _phone = '';
  String _email = '';
  String _searchLocation = '';
  String _error = '';

  Client? _user;

  final _authRepository = AuthRepository();
  final TextEditingController searchLocationController =
      TextEditingController();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _searchLocationFocusNode = FocusNode();

  Client? get user => _user;

  bool get isLoading => _isLoading;
  bool get isLoadingLocation => _isLoadingLocation;

  // List<Locations> get location => _location;
  String? _selectedLocationId;
  String? _selectedLocationName;

  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get email => _email;
  String get searchLocation => _searchLocation;

  String? get selectedLocationId => _selectedLocationId;
  String? get selectedLocationName => _selectedLocationName;
  String get error => _error;

  FocusNode get firstNameFocusNode => _firstNameFocusNode;
  FocusNode get middleNameFocusNode => _middleNameFocusNode;
  FocusNode get lastNameFocusNode => _lastNameFocusNode;
  FocusNode get phoneFocusNode => _phoneFocusNode;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get searchLocationFocusNode => _searchLocationFocusNode;

  void setSelectedLocation(String? locationId) {
    _selectedLocationId = locationId;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  set middleName(String value) {
    _middleName = value;
    notifyListeners();
  }

  set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set searchLocation(String value) {
    _searchLocation = value;
    notifyListeners();
  }

  Future<dynamic> registerApi(BuildContext context) async {
    Map<String, dynamic> data = {
      'first_name': _firstName,
      'middle_name': _middleName,
      'last_name': _lastName,
      'phone': _phone,
      'email': _email,
      'location_id': selectedLocationId,
    };

    setLoading(true);

    try {
      final value = await _authRepository.registerApi(data);
      setLoading(false);

      if (value['statusCode'] != 200) {
        if (!context.mounted) return;
        Utils.flushBar("Taarifa hazikuhifadhiwa, tafadhali jaribu tena",
            context, "warning");
      } else {
        // Remove location_id and add client_id
        data.remove('location_id');
        final String clientId = value['clientId'].toString();
        data['client_id'] = clientId;

        // Map the data to a Client object
        Client client = Client.fromJson(data);

        // DatabaseHelper databaseHelper = DatabaseHelper();
        // await databaseHelper.insertClient(client);

        if (!context.mounted) return;
        Navigator.pushNamed(context, RoutesName.home);
      }
    } catch (error) {
      setLoading(false);

      if (!context.mounted) return;
      Utils.flushBar(error.toString(), context, "error");
    }
  }

  Future<void> getLocation(BuildContext context) async {
    _isLoadingLocation = true;
    _error = '';
    notifyListeners();

    try {
      _authRepository.getLocationApi().then((value) async {
        // final locationData = Location.fromJson(value);
        // _location.clear();
        // _location.addAll(locationData.locations ?? []);
        _isLoadingLocation = false;
        notifyListeners();
      }).onError((errorMsg, stackTrace) {
        _isLoadingLocation = false;
        _error = 'network';
        notifyListeners();

        if (!context.mounted) return;
        Utils.flushBar('Hitilafu ya kimtandao', context, "error");
      });
    } catch (e) {
      _isLoadingLocation = false;
      _error = 'network';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchLocationController.dispose();
    super.dispose();
  }
}

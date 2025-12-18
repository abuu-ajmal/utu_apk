class ApiCall{

  static String apiUrl = "http://192.168.1.26:8000/api";

   static String loginApi = '$apiUrl/login';
   static String registrationApi = '$apiUrl/registration';
   static String locationApi = '$apiUrl/getlocation';
   static String changePasswordApi = '$apiUrl/changePassword';
   static String identityApi = '$apiUrl/identities';
   static String professionalsApi = '$apiUrl/professionals';

  static String addServicesApi = '$apiUrl/services';

  // Dynamic URL builder for deleting a service
  static String deleteServiceApi(int professionalId, int serviceId) {
    return '$apiUrl/services/$professionalId/remove-service/$serviceId';
  }



}
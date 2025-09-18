

class ClientResponse {
  List<Client>? clients;

  ClientResponse({this.clients});

  ClientResponse.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Client>[];
      json['clients'].forEach((v) {
        clients!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  String? clientId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phoneNo;
  String? email;

  Client({
    this.clientId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNo,
    this.email,
  });

  Client.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    return data;
  }
}
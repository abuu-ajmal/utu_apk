import 'package:flutter/material.dart';

import '../../model/professional.dart';


class AddProfessionalPage extends StatefulWidget {
  final ProfessionalModel? professional;

  const AddProfessionalPage({super.key, this.professional});

  @override
  State<AddProfessionalPage> createState() => _AddProfessionalPageState();
}

class _AddProfessionalPageState extends State<AddProfessionalPage> {
  List<ServiceModel> services = [];

  @override
  void initState() {
    super.initState();
    if (widget.professional != null) {
      services = List.from(widget.professional!.services);
    }
  }

  void addService() {
    setState(() {
      services.add(
        ServiceModel(serviceId: 0, serviceName: "New Service"),
      );
    });
  }

  void deleteService(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Professional")),
      floatingActionButton: FloatingActionButton(
        onPressed: addService,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text("Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          ...services.asMap().entries.map(
                (entry) {
              int index = entry.key;
              ServiceModel service = entry.value;

              return Card(
                child: ListTile(
                  title: Text(service.serviceName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteService(index),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

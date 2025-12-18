import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/professional.dart';
import '../../view_model/proffessional_view_model.dart';

class ViewProfessionalPage extends StatelessWidget {
  const ViewProfessionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfessionalViewModel()..loadProfessional(),
      child: Consumer<ProfessionalViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.errorMessage != null) {
            return Scaffold(
              body: Center(child: Text(vm.errorMessage!)),
            );
          }

          if (vm.professional == null) {
            return const Scaffold(
              body: Center(child: Text("No data available")),
            );
          }

          final ProfessionalModel p = vm.professional!;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Professional Profile"),
              backgroundColor: Colors.blueAccent,
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // TODO: open add service dialog
              },
              backgroundColor: Colors.blueAccent,
              icon: const Icon(Icons.add),
              label: const Text("Add Service"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ---------- PROFILE PHOTO ----------
                  if (p.photo != null)
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(p.photo!),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // ---------- SUMMARY CARD ----------
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status: ${p.status}",
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _infoRow("Title", p.title?.title ?? "-"),
                          _infoRow("Specialization", p.specialization?.name ?? "-"),
                          _infoRow("Education", p.education?.level ?? "-"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------- DOCUMENTS ----------
                  const Text(
                    "Documents",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  if (p.cv != null) documentCard(title: "CV", url: p.cv!, icon: Icons.description),
                  if (p.certificate != null) documentCard(title: "Education Certificate", url: p.certificate!, icon: Icons.school),
                  if (p.license != null) documentCard(title: "License", url: p.license!, icon: Icons.verified),
                  if (p.workPermit != null) documentCard(title: "Work Permit", url: p.workPermit!, icon: Icons.badge),

                  const SizedBox(height: 25),

                  // ---------- SERVICES ----------
                  const Text(
                    "Assigned Services",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 15),

                  if (p.services.isEmpty)
                    const Center(
                      child: Text(
                        "No services assigned yet.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    Column(
                      children: p.services.map((s) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.medical_services,
                                  color: Colors.blueAccent),
                            ),
                            title: Text(
                              s.serviceName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteService(context, p.professionalId, s.serviceId);
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- INFO ROW ----------
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- DOCUMENT CARD ----------
  Widget documentCard({required String title, required String url, required IconData icon}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Tap to open"),
        trailing: const Icon(Icons.open_in_new),
        onTap: () async {
          if (!await launchUrl(Uri.parse(url))) {
            debugPrint("Could not open $url");
          }
        },
      ),
    );
  }

  // ---------- DELETE SERVICE ----------
  void _deleteService(BuildContext context, int professionalId, int serviceId) async {
    final vm = Provider.of<ProfessionalViewModel>(context, listen: false);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("This will remove the selected service from this professional."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await vm.deleteAssignedService(professionalId, serviceId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Service removed successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to remove service")),
      );
    }
  }
}

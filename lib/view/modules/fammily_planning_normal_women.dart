import 'package:flutter/material.dart';

class FamilyPlanningForNormalWomenPage extends StatefulWidget {
  final String language;

  const FamilyPlanningForNormalWomenPage({super.key, required this.language});

  @override
  State<FamilyPlanningForNormalWomenPage> createState() =>
      _FamilyPlanningForNormalWomenPageState();
}

class _FamilyPlanningForNormalWomenPageState
    extends State<FamilyPlanningForNormalWomenPage> {
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.language;
  }

  void toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 'sw' ? 'en' : 'sw';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSwahili = currentLanguage == 'sw';

    final title = isSwahili
        ? 'Uzazi wa Mpango kwa Wanawake wa Kawaida'
        : 'Family Planning for Normal Women';

    final content = isSwahili
        ? '''
Uzazi wa mpango kwa wanawake wa kawaida ni hatua muhimu ya kuamua lini na kwa muda gani mwanamke anataka kupata watoto. Wanawake wanaweza kuchagua njia tofauti za uzazi wa mpango kulingana na mahitaji yao ya kiafya, imani zao na hali ya maisha.

Baadhi ya njia ni pamoja na: tembe za kupanga uzazi, sindano, vipandikizi, kitanzi (IUCD), kondomu, na njia asilia kama kufuatilia mzunguko wa hedhi.

Wanawake wanashauriwa kumshirikisha mtoa huduma wa afya ili kupata ushauri juu ya njia bora kulingana na afya na historia yao ya uzazi. Huduma hizi husaidia wanawake kuepuka mimba zisizotarajiwa, kuratibu muda kati ya watoto, na kuboresha hali ya maisha ya familia.

Uzazi wa mpango ni haki ya kila mwanamke na unaleta uhuru wa kufanya maamuzi bora kuhusu afya na maisha yake ya baadaye.
'''
        : '''
Family planning for normal women is a vital step in choosing when and how many children to have. Women can choose from different contraceptive methods depending on their health, beliefs, and lifestyle.

These methods may include: birth control pills, injections, implants, intrauterine devices (IUD), condoms, and natural methods like tracking the menstrual cycle.

Women are encouraged to consult with a healthcare provider to choose the most appropriate method based on their health and reproductive history. These services help prevent unplanned pregnancies, space births, and improve the quality of family life.

Family planning is every woman’s right and allows her the freedom to make informed decisions about her health and future.
''';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isSwahili ? 'English' : 'Kiswahili',
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/mpango4.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

  }
}

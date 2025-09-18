import 'package:flutter/material.dart';

class FamilyPlanningBeforePregnancyPage extends StatefulWidget {
  final String language;

  const FamilyPlanningBeforePregnancyPage({super.key, required this.language});

  @override
  State<FamilyPlanningBeforePregnancyPage> createState() =>
      _FamilyPlanningBeforePregnancyPageState();
}

class _FamilyPlanningBeforePregnancyPageState
    extends State<FamilyPlanningBeforePregnancyPage> {
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
        ? 'Uzazi wa Mpango Kabla ya Ujauzito'
        : 'Family Planning Before Pregnancy';

    final content = isSwahili
        ? '''
Uzazi wa mpango kabla ya ujauzito unalenga kuhakikisha afya bora ya mama na mtoto kabla ya mimba kutungwa. Kupanga mimba kabla ya kutunga husaidia katika maandalizi ya kiafya, kiakili, na kijamii kwa familia yote.

Wanandoa wanashauriwa kuchukua muda wa kujitathmini kiafya, kufuata lishe bora, kuachana na matumizi ya pombe na tumbaku, na kupima magonjwa ya zinaa kabla ya kutafuta ujauzito.

Aidha, ni vyema kuzungumza na mtoa huduma wa afya kuhusu aina ya dawa au njia za uzazi wa mpango wanazotumia ili kuweza kuamua ni wakati gani sahihi wa kuachana nazo na kuanza kutafuta mimba. Baadhi ya njia za uzazi wa mpango huchukua muda kurejesha uwezo wa kushika mimba baada ya kuziacha.

Uamuzi huu wa kupanga ujauzito huongeza nafasi ya ujauzito wenye afya na kupunguza hatari za matatizo wakati wa ujauzito au kujifungua.

Kumbuka: Maandalizi ya kabla ya ujauzito ni sehemu ya msingi ya afya ya uzazi.
'''
        : '''
Family planning before pregnancy focuses on ensuring the health and well-being of the mother and baby before conception. Planning pregnancy ahead of time allows couples to prepare physically, emotionally, and socially.

Couples are advised to undergo medical checkups, eat a balanced diet, avoid alcohol and tobacco, and test for sexually transmitted infections (STIs) before trying to conceive.

It’s also essential to consult a healthcare provider regarding any contraceptives being used to understand when to safely stop them and start trying for pregnancy. Some methods may take time before fertility returns.

Making a decision to plan ahead improves the chances of a healthy pregnancy and lowers risks during pregnancy and childbirth.

Note: Pre-pregnancy planning is a vital part of reproductive health.
''';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
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
              'assets/images/mpango2.jpg',
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

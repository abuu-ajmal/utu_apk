import 'package:flutter/material.dart';

class FamilyPlanningAfterPregnancyPage extends StatefulWidget {
  final String language;
  const FamilyPlanningAfterPregnancyPage({super.key, required this.language});

  @override
  State<FamilyPlanningAfterPregnancyPage> createState() =>
      _FamilyPlanningAfterPregnancyPageState();
}

class _FamilyPlanningAfterPregnancyPageState
    extends State<FamilyPlanningAfterPregnancyPage> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.language;
  }

  final Map<String, String> titles = {
    'en': 'Family Planning After Pregnancy',
    'sw': 'Uzazi wa Mpango Baada ya Kujifungua',
  };

  final Map<String, String> descriptions = {
    'en': '''
Spacing between pregnancies can improve health outcomes. It is recommended to wait at least 6 months, preferably 18 months, before getting pregnant again. Women should start using family planning before resuming sexual activity.

Non-breastfeeding women may ovulate as early as 4-6 weeks postpartum, sometimes earlier. Breastfeeding women often ovulate later (about 6 months), but some may ovulate earlier and become pregnant quickly. Hence, reliable contraception is still important.

🔹 For breastfeeding women:
- Progestin-only pills
- Depo injections
- Implants
- Intrauterine devices (IUD)

🔹 For non-breastfeeding women:
- Combined estrogen-progestin pills
- Vaginal rings

🔹 For women who have completed childbearing:
- Tubal ligation (for women)
- Vasectomy (for men)

💡 Professional counseling helps in choosing the best method based on health conditions like high blood pressure, diabetes, or clotting disorders. Also, discuss with your partner for shared decisions.

Understanding proper usage and timing ensures high effectiveness of chosen methods.
''',
    'sw': '''
Matokeo ya ujauzito unaofuata yanaweza kuwa bora zaidi endapo utasubiri kwa angalau miezi 6 kabla ya kubeba ujauzito mwingine, lakini inapendekezwa kusubiri miezi 18 baada ya kujifungua. Hivyo unapaswa kuanza kutumia uzazi wa mpango kabla ya kuanza tena kushiriki ngono.

Kwa mwanamke ambaye hanyonyeshi, uovuleshaji unaweza kutokea wiki 4 hadi 6 baada ya kujifungua, hata hivyo, unaweza kutokea mapema zaidi. Wakati wanawake wanaonyonyesha huchelewa kuanza uovuleshaji na hedhi, mara nyingi karibu miezi 6 baada ya kujifungua, na wachache wao hupata hedhi mapema, na wanaweza kupata mimba kwa haraka sawa na wale wasionyonyesha. Hivyo bado kuna umuhimu wa kutumia njia ya uzazi wa mpango inayoaminika.

🔹 Kwa mwanamke anaonyonyesha:
- Vidonge vyenye projestini pekee
- Sindano za depo
- Vipandikizi
- IUD

🔹 Kwa mwanamke ambaye hanyonyeshi:
- Vidonge vya mchanganyiko wa estrojeni na projestini
- Pete za uke

🔹 Kwa mwanamke aliyemaliza uzazi:
- Kufunga kizazi kwa upasuaji (mwanamke au mwanaume)

💡 Ili kuhakikisha usalama, mtoa huduma wa afya anapaswa kutoa ushauri kuhusu njia bora kwa kila hali. Pia ni vyema kujadiliana na mwenza wako kabla ya kuchagua njia ya uzazi wa mpango.

Uelewa wa wakati sahihi wa kuanza na jinsi ya kutumia njia husaidia kuhakikisha ufanisi wa hali ya juu.
''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedLanguage]!),
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            icon: const Icon(Icons.language, color: Colors.white),
            underline: const SizedBox(),
            dropdownColor: Colors.blue[50],
            onChanged: (value) {
              setState(() {
                selectedLanguage = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'sw', child: Text('Kiswahili')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/mpango3.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Content
            Text(
              descriptions[selectedLanguage]!,
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

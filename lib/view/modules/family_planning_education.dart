import 'package:flutter/material.dart';

class FamilyPlanningEducationPage extends StatefulWidget {
  final String language; // 'en' or 'sw'

  const FamilyPlanningEducationPage({super.key, required this.language});

  @override
  State<FamilyPlanningEducationPage> createState() =>
      _FamilyPlanningEducationPageState();
}

class _FamilyPlanningEducationPageState
    extends State<FamilyPlanningEducationPage> {
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.language;
  }

  void toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 'en' ? 'sw' : 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSwahili = currentLanguage == 'sw';

    return Scaffold(
      appBar: AppBar(
        title: Text(isSwahili ? 'Elimu ya Uzazi wa Mpango' : 'Family Planning Education'),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate_sharp),
            onPressed: toggleLanguage,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            isSwahili ? 'Uzazi wa Mpango ni Nini?' : 'What is Family Planning?',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            isSwahili
                ? 'Uzazi wa mpango ni maamuzi ya hiari ya mtu au wanandoa kuhusu idadi ya watoto wanaotaka kupata, muda wa kuwapata, na nafasi kati ya watoto.'
                : 'Family planning refers to the voluntary decision made by individuals or couples regarding the number of children they wish to have, the spacing between pregnancies, and the timing of births.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Text(
            isSwahili ? 'Faida za Uzazi wa Mpango' : 'Benefits of Family Planning',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSwahili
                    ? 'Uzazi wa mpango una faida nyingi, zikiwemo:'
                    : 'Family planning offers many benefits, including:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ...[
                isSwahili
                    ? 'Kupunguza vifo vya akina mama na watoto.'
                    : 'Reduces maternal and child deaths.',
                isSwahili
                    ? 'Kuwawezesha wanawake kuendelea na masomo au kazi.'
                    : 'Enables women to pursue education or work.',
                isSwahili
                    ? 'Kusaidia familia kupanga watoto kwa wakati unaofaa.'
                    : 'Helps families plan children at the right time.',
                isSwahili
                    ? 'Kuzuia mimba zisizotarajiwa na utoaji mimba usio salama.'
                    : 'Prevents unplanned pregnancies and unsafe abortions.',
                isSwahili
                    ? 'Kukuza usawa wa kijinsia na haki ya uzazi.'
                    : 'Promotes gender equality and reproductive rights.',
                isSwahili
                    ? 'Kuchangia maendeleo ya jamii na nchi.'
                    : 'Contributes to community and national development.',
              ].map(
                    (benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 16)),
                      Expanded(child: Text(benefit, style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Text(
            isSwahili ? 'Njia za Uzazi wa Mpango' : 'Types of Family Planning Methods',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSwahili
                    ? 'Kuna njia mbalimbali za uzazi wa mpango, zikiwemo:'
                    : 'There are several family planning methods, including:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ...[
                isSwahili
                    ? 'Vidonge vya uzazi wa mpango.'
                    : 'Birth control pills.',
                isSwahili
                    ? 'Kondomu kwa wanaume na wanawake.'
                    : 'Condoms (male and female).',
                isSwahili
                    ? 'Sindano za uzazi wa mpango.'
                    : 'Contraceptive injections.',
                isSwahili
                    ? 'Vipandikizi (implants).'
                    : 'Implants.',
                isSwahili
                    ? 'Vifaa vya kuzuia mimba ndani ya mfuko wa uzazi (IUD).'
                    : 'Intrauterine Devices (IUDs).',
                isSwahili
                    ? 'Njia asilia (kama vile kuhesabu siku salama).'
                    : 'Natural methods (e.g., calendar method).',
                isSwahili
                    ? 'Kufunga kizazi (wanaume au wanawake).'
                    : 'Sterilization (male or female).',
              ].map(
                    (method) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 16)),
                      Expanded(child: Text(method, style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Text(
            isSwahili ? 'Tafadhali tembelea kituo cha afya' : 'Please visit a health center',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.pinkAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSwahili
                      ? 'Ukihitaji msaada, tafadhali wasiliana na mhudumu wa afya.'
                      : 'If you need help, please contact a health provider.',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: isSwahili
                        ? 'Andika dalili zako hapa...'
                        : 'Enter your symptoms here...',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: Text(
                    isSwahili
                        ? 'Wasiliana na Mhudumu wa Afya'
                        : 'Contact Health Worker',
                  ),
                  onPressed: () {
                    // Simulate action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isSwahili
                            ? 'Ujumbe umetumwa kwa mhudumu wa afya.'
                            : 'Message sent to health worker.'),
                      ),
                    );
                  },

                ),

              ],
            ),

          ),

          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

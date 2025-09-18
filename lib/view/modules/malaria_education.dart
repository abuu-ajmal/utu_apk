import 'package:flutter/material.dart';

class MalariaEducationPage extends StatefulWidget {
  final String initialLanguage;

  const MalariaEducationPage({super.key, required this.initialLanguage});

  @override
  State<MalariaEducationPage> createState() => _MalariaEducationPageState();
}

class _MalariaEducationPageState extends State<MalariaEducationPage> {
  late bool isSwahili;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSwahili = widget.initialLanguage.toLowerCase() == 'sw';
  }

  void toggleLanguage() {
    setState(() {
      isSwahili = !isSwahili;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSwahili ? 'Elimu ya Malaria' : 'Malaria Education'),
        actions: [
          TextButton(
            onPressed: toggleLanguage,
            child: Text(
              isSwahili ? 'EN' : 'SW',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              isSwahili ? 'Dalili za Malaria' : 'Symptoms of Malaria',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(isSwahili
                ? 'Dalili za Malaria zimegawanyika katika makundi mawili: Malaria Isiyokuwa ngumu na Malaria kali.'
                : 'Malaria symptoms are grouped into two categories: Uncomplicated Malaria and Severe Malaria.'),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Malaria isiyo ngumu' : 'Uncomplicated Malaria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(isSwahili
                ? '''Dalili zisizo ngumu za malaria kwa kawaida huchukua saa 6 - 10 na hujirudia kila siku ya pili...
• Kuhisi baridi na kutetemeka
• Kichwa cha kichwa, homa, na kutapika
• Mishtuko ya moyo kwa vijana
• Jasho na uchovu baada ya homa'''
                : '''Uncomplicated symptoms usually last 6–10 hours and repeat every second day...
• Cold sensations and shivering
• Headache, fever, and vomiting
• Seizures in young people
• Sweating and fatigue after fever'''),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Malaria kali' : 'Severe Malaria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(isSwahili
                ? '''Ikiwa ushahidi unaonyesha kutofanya kazi kwa kiungo muhimu, ni malaria kali.
Dalili ni:
• Homa na baridi kali
• Ufahamu ulioharibika
• Kupumua kwa shida
• Degedege nyingi
• Anemia na kutokwa damu
• Dalili za kushindwa kwa viungo muhimu'''
                : '''If evidence shows vital organ dysfunction, it is severe malaria.
Symptoms include:
• High fever and chills
• Impaired consciousness
• Breathing difficulty
• Multiple seizures
• Anemia and unusual bleeding
• Organ failure signs'''),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Utambuzi wa Malaria' : 'Diagnosis of Malaria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(isSwahili
                ? '''Utambuzi wa mapema unaokoa maisha. Sampuli ya damu inapaswa kuchukuliwa na kuchunguzwa...
Katika vituo visivyo na hadubini, vipimo vya haraka vinaweza kusaidia.
Matibabu yanaweza kuanza ikiwa viashiria vya kliniki vinaonyesha malaria.'''
                : '''Early diagnosis saves lives. Blood samples should be taken and examined...
Where no microscope is available, rapid diagnostic tests are useful.
Treatment may begin if clinical signs strongly suggest malaria.'''),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Matibabu ya Malaria' : 'Treatment of Malaria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(isSwahili
                ? '''Lengo ni kuondoa vimelea kutoka kwenye damu. WHO inapendekeza tiba mchanganyiko yenye Artemisinin (ACT)...
ACT hupunguza vimelea haraka, na dawa za washirika huua vilivyobaki.'''
                : '''Goal is to eliminate the parasite from blood. WHO recommends artemisinin-based combination therapy (ACT)...
ACT quickly reduces parasites, and partner drugs kill remaining ones.'''),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Kuzuia Malaria' : 'Prevention of Malaria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(isSwahili
                ? '''• Tiba mchanganyiko kwa haraka (ACT)
• Kutumia vyandarua vyenye dawa
• Kunyunyizia nyumba dawa ya kuua mbu
• Kufuata ABCD ya ulinzi:
  - Jihadhari na hatari
  - Epuka kuumwa
  - Tumia dawa za kuzuia
  - Tibiwa mapema baada ya safari'''
                : '''• Prompt ACT treatment
• Use of insecticide-treated bed nets
• Indoor spraying with insecticides
• Follow the ABCD protection rule:
  - Be aware of the risk
  - Avoid bites
  - Take preventive medicine
  - Get tested if fever after travel'''),
            const SizedBox(height: 10),

            Text(
              isSwahili ? 'Chanzo' : 'Source',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              isSwahili
                  ? 'Mbu wa kike aina ya Anopheles ndiye anayesambaza vimelea vya malaria.'
                  : 'The female Anopheles mosquito transmits malaria parasites.',
            ),
            const SizedBox(height: 20),

            Image.asset('assets/images/dalilizamalaria.png'),
            const SizedBox(height: 30),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: isSwahili
                    ? 'Andika ujumbe au dalili zako'
                    : 'Enter your message or symptoms',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                final userInput = controller.text.trim();
                if (userInput.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isSwahili
                          ? 'Ujumbe umetumwa kwa mhudumu wa afya.'
                          : 'Message sent to a health provider.'),
                    ),
                  );
                  controller.clear();
                }
              },
              icon: const Icon(Icons.local_hospital),
              label: Text(
                isSwahili
                    ? 'Ukiwa na dalili yoyote ya malaria tafadhali wasiliana na mhudumu wa afya'
                    : 'If you have any symptoms of malaria, please contact a health provider',
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

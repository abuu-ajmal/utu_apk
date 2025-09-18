import 'package:flutter/material.dart';

class MentalHealth extends StatefulWidget {
  final String initialLanguage; // expects 'en' or 'sw'

  const MentalHealth({Key? key, required this.initialLanguage}) : super(key: key);

  @override
  State<MentalHealth> createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {
  late bool isEnglish;

  final Map<String, String> contentEn = {
    'title': 'What is Mental Health?',
    'intro':
    'Mental health is the least understood term, often mistaken as only mental illnesses like depression, anxiety, schizophrenia and more. It relates to a person\'s psychological, emotional, and social well-being. It affects how we feel, think, and live each day.',
    'signsTitle': 'What are the signs and symptoms of Poor Mental Health?',
    'signs':
    'Mental health causes harm when one focuses on “what is wrong” rather than “what is good and going well.” Many recognize physical illness symptoms but not poor mental health.\n\nSome signs and symptoms include:\n\n- Feeling sad or down all the time\n- Reduced ability to concentrate\n- Withdrawal from social connections and daily activities\n- Major changes in eating and sleeping habits\n- Suicidal thoughts and feelings of loneliness\n- Overthinking and feelings of guilt\n- Mood swings\n- Detachment from reality, paranoia, hallucinations or delusions\n- Inability to cope with everyday stresses\n- Difficulty relating to or understanding others\n- Substance abuse\n- Changes in sex drive\n- Frequent anger, hostility or violence\n- Major changes in eating and sleeping habits',
    'whyImportantTitle': 'Why is Mental Health Important?',
    'whyImportant':
    'Emotional and mental health is important because it affects thoughts, behaviors, and feelings. Good emotional and mental health can promote productivity and efficiency in daily activities. It also plays a crucial role in maintaining social connections, relationships, and coping with life changes and challenges.',
    'howToImproveTitle': 'How to Improve Mental Health?',
    'howToImprove':
    'Emotionally and mentally capable people use mindfulness techniques to handle difficult situations and maintain a positive outlook. Small things or steps can help strengthen mental health. Here are some ways to cope with specific mental health issues, better manage intense feelings, or just feel more positive and empowered:\n\n- Prioritize social connections\n- Aim for 30 minutes of daily activity\n- Eat brain-healthy balanced foods\n- Prioritize leisure time\n- Practice gratitude\n- Aim for 7 to 9 hours of quality sleep each night\n- Set aside time to reflect and appreciate without overdoing it\n- Find purpose that provides motivation',
    'whenToSeekHelpTitle': 'When to Seek Help?',
    'whenToSeekHelp':
    'Mental health can affect people differently. If repeated efforts to improve emotional and mental health haven\'t helped you function well at home, work, or relationships, it may be time to seek professional help. When someone notices changes in overall happiness and relationships, there are always positive ways to get needed support. Some ways to get help:\n\n- Connecting with friends and family - reach out to people in your life who can offer emotional support.\n- Learning about mental health - many resources exist to learn more about emotional health.\n- Seeking professional help - consult a psychologist or mental health professional for personalized support.\n\nMental health is influenced by many factors including life events or even genetics. Ultimately, mental health is a state of well-being and not just the absence or presence of a mental health condition.'
  };

  final Map<String, String> contentSw = {
    'title': 'Afya ya Akili ni nini?',
    'intro':
    'Afya ya akili ndilo neno lisiloeleweka zaidi, mara nyingi watu huchukua \'Afya ya akili\' kama mbadala ya hali za afya ya akili kama vile unyogovu, wasiwasi, matatizo ya kibinafsi, skizophrenia na zaidi. Inahusu #kisaikolojia, kihisia na ustawi wa kijamii wa mtu. Inaathiri jinsi tunavyohisi, kufikiri na kuishi kila siku.',
    'signsTitle': 'Je! ni dalili na dalili za Afya duni ya Akili?',
    'signs':
    'Afya ya akili huleta madhara mtu anapoamua kuzingatia “tatizo ni nini” badala ya “kile kilicho kizuri na kinachoendelea vizuri”. Wengi wanaweza kujua dalili za magonjwa ya kimwili, kama vile mshtuko wa moyo au kiharusi lakini hawajui afya mbaya ya akili.\n\nBaadhi ya ishara na dalili ni pamoja na:\n\n- Kuhisi huzuni au huzuni kila wakati\n- Kupunguza uwezo wa kuzingatia\n- Kujiondoa kutoka kwa miunganisho ya kijamii na shughuli za kila siku za maisha.\n- Mabadiliko makubwa katika tabia ya kula na kulala\n- Mawazo ya kujiua na hisia za upweke\n- Kufikiri kupita kiasi na hisia za hatia\n- Mabadiliko ya hali ya juu\n- Kujitenga na ukweli, paranoia au ndoto au hata udanganyifu\n- Kutokuwa na uwezo wa kukabiliana na shida za kila siku za maisha\n- Shida kuhusiana au kuelewa hali na watu\n- Matumizi mabaya ya dawa\n- Mabadiliko ya ngono\n- Hasira nyingi, uadui au vurugu\n- Mabadiliko makubwa katika kula na kulala',
    'whyImportantTitle': 'Kwa nini Afya ya Akili ni muhimu?',
    'whyImportant':
    'Afya ya kihisia na kiakili ni muhimu kwa kuwa inaathiri mawazo, tabia na hisia. Kuwa na afya njema kihisia na kiakili kunaweza kukuza tija na ufanisi katika shughuli za kila siku za maisha. Pia ina jukumu muhimu kudumisha miunganisho ya kijamii, uhusiano, na inaruhusu mtu kuzoea mabadiliko katika maisha na kukabiliana na shida.',
    'howToImproveTitle': 'Jinsi ya kuboresha Afya ya Akili?',
    'howToImprove':
    'Watu ambao ni wenye uwezo wa kihisia na kiakili hutumia mbinu za kuzingatia ili kukabiliana na hali ngumu na kudumisha mtazamo mzuri. Mambo madogo au hatua zinaweza kusaidia katika kuimarisha afya ya akili. Hapa kuna njia chache za kukabiliana na tatizo mahususi la afya ya akili, kushughulikia hisia kali vizuri zaidi, au tu kujisikia chanya na mwenye nguvu zaidi:\n\n- Fanya uhusiano wa kijamii kuwa kipaumbele\n- Lenga kwa dakika 30 za shughuli kila siku\n- Kula chakula cha ubongo chenye uwiano na afya\n- Fanya wakati wa burudani kuwa kipaumbele\n- Kumbuka kushukuru\n- Lenga kwa saa saba hadi tisa za usingizi bora kila usiku\n- Tenga muda wa kutafakari (kutathmini upya) na kuthamini bila kupita kiasi\n- Kutafuta kusudi ambalo hutoa gari muhimu',
    'whenToSeekHelpTitle': 'Wakati wa kufikia msaada kama walezi?',
    'whenToSeekHelp':
    'Afya ya akili inaweza kuathiri watu tofauti kwa njia tofauti. Ikiwa juhudi zote za mara kwa mara za kuboresha afya ya akili na kihisia bado hazikusaidii  ufanye kazi ipasavyo nyumbani, kazini au katika mahusiano yako, unaweza kuwa wakati wa kutafuta usaidizi wa kitaalamu. Mtu anapoanza kuona mabadiliko katika furaha na mahusiano yao kwa ujumla, daima kuna njia chanya za kupata chakula kinachohitajikabandari. Baadhi ya njia za kupata usaidizi:\n\n- Kuunganishwa na marafiki na familia - Fikia watu maishani ambao wanaweza kusaidia kutoa msaada wa kihemko.\n- Kujifunza juu ya afya ya akili - Kuna nyenzo nyingi ambazo unaweza kugeukia kwa kujifunza zaidi kuhusu afya ya kihisia.\n- Kutafuta msaada wa kitaalamu- Tazama mwanasaikolojia au mtaalamu wa magonjwa ya akili na upate usaidizi wa kibinafsi unaotaka.\n\nAfya ya akili inaweza kuathiriwa na mambo mbalimbali, ikiwa ni pamoja na matukio ya maisha au hata maumbile yako. Hatimaye, afya ya akili ni hali ya ustawi na si tu kutokuwepo au kuwepo kwa hali ya afya ya akili.'
  };

  @override
  void initState() {
    super.initState();
    isEnglish = widget.initialLanguage.toLowerCase() == 'en';
  }

  void toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish;
    });
  }

  Widget _sectionWithImage(String imageAssetPath, String title, String contentText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imageAssetPath,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 12),
        Text(
          contentText,
          style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
        ),
        const SizedBox(height: 44),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = isEnglish ? contentEn : contentSw;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health / Afya ya Akili'),
        actions: [
          TextButton(
            onPressed: toggleLanguage,
            child: Text(
              isEnglish ? 'Kiswahili' : 'English',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro section with image
            _sectionWithImage(
              'assets/images/mental_help.png',
              content['title']!,
              content['intro']!,
            ),
            // Signs and symptoms
            _sectionWithImage(
              'assets/images/mental_help.png',
              content['signsTitle']!,
              content['signs']!,
            ),
            // Why important
            _sectionWithImage(
              'assets/images/mental_health_help.png',
              content['whyImportantTitle']!,
              content['whyImportant']!,
            ),
            // How to improve
            _sectionWithImage(
              'assets/images/mental_help.png',
              content['howToImproveTitle']!,
              content['howToImprove']!,
            ),
            // When to seek help
            _sectionWithImage(
              'assets/images/mental_health_help.png',
              content['whenToSeekHelpTitle']!,
              content['whenToSeekHelp']!,
            ),
          ],
        ),

      ),
    );
  }
}

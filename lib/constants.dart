import 'package:flutter/material.dart';

Color green = const Color(0xFF029933);

List<String> themes = const [
  "Tawhid",
  "Prière",
  "Ramadan",
  "Zakat",
  "Hajj",
  "Le Coran",
  "La Sunna",
  "Prophètes",
  "73 Sectes",
  "Compagnons",
  "Les Savants",
  "Les innovations",
  "La mort",
  "La tombe",
  "Le jour dernier",
  "Les 4 Imams",
  "Les Anges",
  "Les Djinns",
  "Les gens du livre",
  "99 Noms",
  "Femmes",
  "Voyage",
  "Signes",
  "Adkars",
];

List<String> scholars = const [
  "Cheikh Abdesamad Karoum / الشيخ عبد الصمد كروم",
  "Cheikh Abderrazak Al Badr / الشيخ عبد الرزاق البدر",
  "Cheikh Abdelkarim Al Khoudayr / الشيخ عبد الكريم الخضير",
  "Cheikh Abdelmadjid Jumu’a / الشيخ عبد المجيد جمعة",
  "Cheikh Abdelmouhsin Al Abbad Al Badr / الشيخ عبد المحسن العباد البدر",
  "Cheikh Abdellah Al Idrissi / شيخ عبدالله الدراسي",
  "Cheikh Abdellah Al Qussayir / شيخ عبد الله القصير",
  "Cheikh Abdallah Al Ghoudayan / الشيخ عبد الله الغديان",
  "Cheikh Abderahman As-Sa’di / الشيخ عبد الرحمن السعدي",
  "Cheikh Abderahman Mouhyiddine / الشيخ عبد الرحمن محي الدين",
  "Cheikh Abdesalam Ibn Barjas / الشيخ عبد السلام بن برجس",
  "Cheikh Abdesalam Chouway’ir / الشيخ عبد السلام الشويعر",
  "Cheikh Ahmad Bazmoul / الشيخ أحمد بزمول",
  "Cheikh Ahmad Najmi / الشيخ أحمد النجمي",
  "Cheikh Al Albani / الشيخ الألباني",
  "Cheikh Al Uthaymin / شيخ العثيمين",
  "Cheikh Ali Cheikh / شيخ علي شيخ",
  "Cheikh Ali Ramli / الشيخ علي الرملي",
  "Cheikh As Souhaymi / شيخ السحيمي",
  "Cheikh Aziz bin Farhan Al Anizi / الشيخ عزيز بن فرحان العنزي",
  "Cheikh Faleh Mundakar / شيخ فلح مندكار",
  "Cheikh Faqiri / شيخ فقيري",
  "Cheikh Ferkous / الشيخ فركوس",
  "Cheikh Foued Ibn Saoud Al Amri / الشيخ فؤاد بن سعود العمري",
  "Cheikh Hassan Ibn Abdelwahhab Al Bana / الشيخ حسن بن عبد الوهاب البنا",
  "Cheikh Ibrahim Al Mouhaymid / الشيخ إبراهيم المحيميد",
  "Cheikh Ibn Baz / الشيخ ابن باز",
  "Cheikh Mouqbil Al Wadi’i / الشيخ مقبل الوادعي",
  "Cheikh Muhammad Al Aqil / الشيخ محمد العقيل",
  "Cheikh Muhammad Al Fifi / الشيخ محمد الفيفي",
  "Cheikh Muhammad Al Jami / الشيخ محمد الجامي",
  "Cheikh Muhammad Al Shanqiti / الشيخ محمد الشنقيطي",
  "Cheikh Muhammad Al Wussabi / الشيخ محمد الوصابي",
  "Cheikh Muhammad Bazmoul / الشيخ محمد بزمول",
  "Cheikh Muhammad Ibn Hadi Al Madkhali / الشيخ محمد بن هادي المدخلي",
  "Cheikh Muhammad Ibn Ibrahim / الشيخ محمد بن إبراهيم",
  "Cheikh Muhammad Shawkani / الشيخ محمد الشوكاني",
  "Cheikh Mohamed Ghaïth / شيخ محمد غيث",
  "Cheikh Rabi’ Al Madkhali / الشيخ ربيع المدخلي",
  "Cheikh Ramzan Al Hadjiri / الشيخ رمضان الحجيري",
  "Cheikh Raslan / شيخ عسلان",
  "Cheikh Rouhayli (Souleyman) / شيخ سليمان الرحيلي",
  "Cheikh Saad Ibn Nasser Ash Shathry / الشيخ سعد بن ناصر الشثرى",
  "Cheikh Salih Al Fawzan / الشيخ صالح الفوزان",
  "Cheikh Salih Al Louhaydan / الشيخ صالح اللحيدان",
  "Cheikh Salih Al Osaymi / الشيخ صالح العصيمي",
  "Cheikh Salih Al Shaykh / الشيخ صالح الشيخ",
  "Cheikh Salih Ali Cheikh / شيخ صالح علي شيخ",
  "Cheikh Salih Souhaymi / الشيخ صالح السحيمي",
  "Cheikh Salih Sindi / شيخ صالح سندي",
  "Cheikh Salmane At Tawil / شيخ سلمان الطويلة",
  "Cheikh Tal’at Zahran / الشيخ طلعت زهران",
  "Cheikh Ussamah Ibn Saoud Al Amri / الشيخ أسامة بن سعود العمري",
  "Cheikh Wassiyullah Al Abbas / الشيخ وصي الله عباس",
  "Cheikh Zayd Al Madkhali / الشيخ زيد المدخلي",
];

List<String> imams = [
  "Cheikh Djily Cheikh Abou Maymouna / الشيخ جيلي شيخ أبو ميمونة",
  "Cheikh Ismaïl Ibn Hādī / الشيخ اسماعيل بن هادي",
  "Cheikh Mehdi Ben naceur / الشيخ مهدي بن ناصر",
  "Cheikh Samy Philippe Chaouche / الشيخ سامي بن عبد الكريم الشاوش",
  "Cheikh Tahir Abu Sany / الشيخ طاهر أبو سني",
];

List<String> services_titles = [
  "Service 1 : Location voitures Maroc 🇲🇦",
  "Service 2 : Développement applications",
  "Service 3 : Produit naturels",
  "Service 4 : Vêtements pour femme",
  "Service 5 : Omra",
  "Service 6 : Boutique en ligne",
  "Service 7 : Montres",
];

List<String> services_links = [
  "http://onelink.to/5n88za",
  "Contacter sur WhatsApp",
  "https://monjardinprophetique.com",
  "https://www.anaqacollection.fr",
  "https://omraprivee.com",
  "https://www.maktaba-abou-daoud.fr",
  "https://al-almass.com",
];

List<String> services_images = [
  'assets/images/services/s1.jpg',
  'assets/images/services/s2.jpg',
  'assets/images/services/s3.jpg',
  'assets/images/services/s4.jpg',
  'assets/images/services/s5.jpg',
  'assets/images/services/s6.jpg',
  'assets/images/services/s7.jpg',
]
;

Map<String, Map<String, String>> themesIDs = {
  "Tawhid": {
    "id": "92a89d9e-ebf2-4ed3-9ce4-03d06f7a6690"
  },
  "Prière": {
    "id": "33b5b607-10f7-4b40-a1ad-8becbcfa7983"
  },
  "Ramadan": {
    "id": "3ae58ae9-1178-48eb-b243-0a6a80b152fc"
  },
  "Zakat": {
    "id": "6265bc0c-da24-485a-ba44-624e993fe142"
  },
  "Hajj": {
    "id": "f63b2ecf-e196-4057-b357-45f33461a838"
  },
  "Le Coran": {
    "id": "8a50dbd8-8923-4e34-ac02-e7d720dad88d"
  },
  "La Sunna": {
    "id": "352f15b9-c261-4a3c-99ce-e1c5cbfa0124"
  },
  "Prophètes": {
    "id": "46c17b28-18fa-4e4b-9ff1-0ce9dbdfab8a"
  },
  "73 Sectes": {
    "id": "2e2c05ea-78bd-408d-a4b7-4211706c2a7b"
  },
  "Compagnons": {
    "id": "59bd80d8-6062-4b9a-87d8-aa5b3c35c132"
  },
  "Les Savants": {
    "id": "f112e63a-6a48-4c5f-ad65-c7104173323c"
  },
  "Les innovations": {
    "id": "bb190f80-c716-4d5e-8536-ab47cf4c1631"
  },
  "La mort": {
    "id": "cf875d8b-6f5e-4997-bcf2-fc607c093016"
  },
  "La tombe": {
    "id": "5ca65b2a-eef1-44f5-a5a0-80a27ec9f1e9"
  },
  "Le jour dernier": {
    "id": "bce54aa7-6d2e-42f3-8060-4981361ae608"
  },
  "Les 4 Imams": {
    "id": "d66f7970-5705-4d24-bd9a-416b8bb87da2"
  },
  "Les Anges": {
    "id": "335366ac-0609-437b-8406-4c7a23fdd5b6"
  },
  "Les Djinns": {
    "id": "b1e66682-3d08-4f97-91a2-93653d6cd30f"
  },
  "Les gens du livre": {
    "id": "155a63ac-fc32-42f8-8279-de65c64aede0"
  },
  "99 Noms": {
    "id": "9cb2ef65-2872-4a6f-9ca6-216b4b353066"
  },
  "Femmes": {
    "id": "470d3f3d-648f-4e1d-975a-3c95a05324bd"
  },
  "Voyage": {
    "id": "f0ae858f-0957-4795-939b-138503bb2d64"
  },
  "Signes": {
    "id": "932e21e2-19ee-47b8-98c2-4b0f65723dfd"
  },
  "Adkars": {
    "id": "54187de6-a52c-4209-843a-efcdca5ee780"
  }
};

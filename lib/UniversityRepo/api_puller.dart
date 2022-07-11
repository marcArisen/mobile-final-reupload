import 'dart:collection';

import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/UniversityRepo/university.dart';

import '../model/student_model.dart';

class ApiPuller {

  // Record({
  //   this.id,
  //   this.year,
  //   this.semester,
  //   this.nationalityNameEng,
  //   this.univNameTh,
  //   this.univMasterName,
  //   this.amount,
  // });
  //
  // int? id;
  // int? year;
  // int? semester;
  // String? nationalityNameEng;
  // String? univNameTh;
  // String? univMasterName;
  // int? amount;

  Future<List<int>>? updateNumberToDatabase(List<Record>? lst){

    var nationalities = listAllNationalityNameEng(lst);

    var map = HashMap();
    for (int i = 0; i < lst!.length; i++) {
      map[lst[i].univMasterName!] = {...nationalities};
    }

    for (int i = 0; i < lst.length; i++) {
      // map[lst[i].univMasterName!] = map[lst[i].univMasterName!] + lst[i].amount!;
      map[lst[i].univMasterName!][lst[i].nationalityNameEng] += 1;
      // UniversityDatabase.databaseManager.addUniversity(university)

      // UniversityDatabase.databaseManager.updateUniversity()
    }

    // print(map);
    print(map['จุฬาลงกรณ์มหาวิทยาลัย']);

    return null;
  }

  HashMap listAllNationalityNameEng(List<Record>? lst){
    var map = HashMap();
    for (int i = 0; i < lst!.length; i++) {
      map[lst[i].nationalityNameEng] = 0;
    }
    // there are 98 Nationalities
    return map;
  }

  List listAllUniversities(List<Record>? lst){
    var to_return = [];
    for (int i = 0; i < lst!.length; i++) {
      to_return.add(lst[i].univMasterName!);
    }
    // there are 97 universities
    return to_return.toSet().toList();
  }

  HashMap listAllUniversities2(List<Record>? lst){
    var map = HashMap();
    var to_return = [];
    for (int i = 0; i < lst!.length; i++) {
      map[lst[i].univMasterName!] = 0;
    }
    // there are 97 universities
    print(map.length);
    return map;
  }

  void mockDatabase(){
    var temp1 = University(
      id: 1,
      name: 'Chulalongkorn University',
      thaiName: 'จุฬาลงกรณ์มหาวิทยาลัย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp2 = University(
      id: 2,
      name: 'Kasetsart University',
      thaiName: 'มหาวิทยาลัยเกษตรศาสตร์',
      imageUrl: 'assets/universities/images/2.jpeg',
      logo:'assets/universities/logo/2.jpeg',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp3 = University(
      id: 3,
      name: 'Khon Kaen University',
      thaiName: 'มหาวิทยาลัยขอนแก่น',
      imageUrl: 'assets/universities/images/3.jpeg',
      logo:'assets/universities/logo/3.png',
      province: 'Khon Kaen',
      description: '',
      map: '',
      numbers: null,
    );
    var temp4 = University(
      id: 4,
      name: 'Chiang Mai University',
      thaiName: 'มหาวิทยาลัยเชียงใหม่',
      imageUrl: 'assets/universities/images/4.jpeg',
      logo:'assets/universities/logo/4.png',
      province: 'Chiang Mai',
      description: '',
      map: '',
      numbers: null,
    );
    var temp5 = University(
      id: 5,
      name: 'Burapha University',
      thaiName: 'มหาวิทยาลัยบูรพา',
      imageUrl: 'assets/universities/images/5.jpeg',
      logo:'assets/universities/logo/5.png',
      province: 'Chonburi',
      description: '',
      map: '',
      numbers: null,
    );
    var temp6 = University(
      id: 6,
      name: 'Thammasat University',
      thaiName: 'มหาวิทยาลัยธรรมศาสตร์',
      imageUrl: 'assets/universities/images/6.jpeg',
      logo:'assets/universities/logo/6.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp7 = University(
      id: 7,
      name: 'Silpakorn University',
      thaiName: 'มหาวิทยาลัยศิลปากร',
      imageUrl: 'assets/universities/images/7.jpeg',
      logo:'assets/universities/logo/7.png',
      province: 'Nakhon Phathom',
      description: '',
      map: '',
      numbers: null,
    );
    var temp8 = University(
      id: 8,
      name: 'Mahidol University',
      thaiName: 'มหาวิทยาลัยมหิดล',
      imageUrl: 'assets/universities/images/mahidol.jpg',
      logo:'assets/universities/logo/mahidol.png',
      province: 'Nakhon Phathom',
      description: '',
      map: '',
      numbers: null,
    );
    var temp9 = University(
      id: 9,
      name: 'Ramkhamhaeng University',
      thaiName: 'มหาวิทยาลัยรามคำแหง',
      imageUrl: 'assets/universities/images/9.jpeg',
      logo:'assets/universities/logo/9.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp10 = University(
      id: 10,
      name: 'Srinakharinwirot University',
      thaiName: 'มหาวิทยาลัยศรีนครินทรวิโรฒ',
      imageUrl: 'assets/universities/images/10.jpeg',
      logo:'assets/universities/logo/10.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp11 = University(
      id: 11,
      name: 'Songklanakarin University',
      thaiName: 'มหาวิทยาลัยสงขลานครินทร์',
      imageUrl: 'assets/universities/images/11.jpeg',
      logo:'assets/universities/logo/11.png',
      province: 'Songkla',
      description: '',
      map: '',
      numbers: null,
    );
    var temp12 = University(
      id: 12,
      name: 'Sukhothai Thammathirat Open University',
      thaiName: 'มหาวิทยาลัยสุโขทัยธรรมาธิราช',
      imageUrl: 'assets/universities/images/12.jpeg',
      logo:'assets/universities/logo/12.jpeg',
      province: 'Sukhothai',
      description: '',
      map: '',
      numbers: null,
    );
    var temp13 = University(
      id: 13,
      name: 'NIDA',
      thaiName: 'สถาบันบัณฑิตพัฒนบริหารศาสตร์',
      imageUrl: 'assets/universities/images/13.jpeg',
      logo:'assets/universities/logo/13.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp14 = University(
      id: 14,
      name: 'Maejo University',
      thaiName: 'มหาวิทยาลัยแม่โจ้',
      imageUrl: 'assets/universities/images/14.jpeg',
      logo:'assets/universities/logo/14.png',
      province: 'Chiang Mai',
      description: '',
      map: '',
      numbers: null,
    );
    var temp15 = University(
      id: 15,
      name: "King Mongkut's University of Technology Thonburi",
      thaiName: 'มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี',
      imageUrl: 'assets/universities/images/15.jpeg',
      logo:'assets/universities/logo/15.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp16 = University(
      id: 16,
      name: "King Mongkut's University of Technology North Bangkok ",
      thaiName: 'มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ',
      imageUrl: 'assets/universities/images/16.jpeg',
      logo:'assets/universities/logo/16.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp17 = University(
      id: 17,
      name: "King Mongkut's Institute of Technology Ladkrabang",
      thaiName: 'สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง',
      imageUrl: 'assets/universities/images/17.jpeg',
      logo:'assets/universities/logo/17.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp18 = University(
      id: 18,
      name: 'Suranaree University of Technology',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีสุรนารี',
      imageUrl: 'assets/universities/images/18.jpeg',
      logo:'assets/universities/logo/18.png',
      province: 'Nakron Ratchasima',
      description: '',
      map: '',
      numbers: null,
    );
    var temp19 = University(
      id: 19,
      name: 'Ubon Ratchathani University',
      thaiName: 'มหาวิทยาลัยอุบลราชธานี',
      imageUrl: 'assets/universities/images/19.jpeg',
      logo:'assets/universities/logo/19.png',
      province: 'Ubon Ratchathani',
      description: '',
      map: '',
      numbers: null,
    );
    var temp20 = University(
      id: 20,
      name: 'Thaksin University',
      thaiName: 'มหาวิทยาลัยทักษิณ',
      imageUrl: 'assets/universities/images/20.jpeg',
      logo:'assets/universities/logo/20.png',
      province: 'Songkhla',
      description: '',
      map: '',
      numbers: null,
    );
    var temp21 = University(
      id: 21,
      name: 'Walailak University',
      thaiName: 'มหาวิทยาลัยวลัยลักษณ์',
      imageUrl: 'assets/universities/images/21.jpeg',
      logo:'assets/universities/logo/21.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp22 = University(
      id: 22,
      name: 'Mae Fah Luang University',
      thaiName: 'มหาวิทยาลัยแม่ฟ้าหลวง',
      imageUrl: 'assets/universities/images/22.jpeg',
      logo:'assets/universities/logo/22.png',
      province: 'Chiang Rai',
      description: '',
      map: '',
      numbers: null,
    );
    var temp23 = University(
      id: 23,
      name: 'Phayao University',
      thaiName: 'มหาวิทยาลัยพะเยา',
      imageUrl: 'assets/universities/images/23.jpeg',
      logo:'assets/universities/logo/23.png',
      province: 'Phayao',
      description: '',
      map: '',
      numbers: null,
    );
    var temp24 = University(
      id: 24,
      name: 'Bangkok University',
      thaiName: 'มหาวิทยาลัยกรุงเทพ',
      imageUrl: 'assets/universities/images/24.jpeg',
      logo:'assets/universities/logo/24.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp25 = University(
      id: 25,
      name: 'Payap University',
      thaiName: 'มหาวิทยาลัยพายัพ',
      imageUrl: 'assets/universities/images/25.jpeg',
      logo:'assets/universities/logo/25.png',
      province: 'Chaing Mai',
      description: '',
      map: '',
      numbers: null,
    );
    var temp26 = University(
      id: 26,
      name: 'Sripatum University',
      thaiName: 'มหาวิทยาลัยศรีปทุม',
      imageUrl: 'assets/universities/images/26.jpeg',
      logo:'assets/universities/logo/26.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp27 = University(
      id: 27,
      name: 'University of the Thai Chamber of Commerce',
      thaiName: 'มหาวิทยาลัยหอการค้าไทย',
      imageUrl: 'assets/universities/images/27.jpeg',
      logo:'assets/universities/logo/27.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp28 = University(
      id: 28,
      name: 'Krirk University',
      thaiName: 'มหาวิทยาลัยเกริก',
      imageUrl: 'assets/universities/images/28.png',
      logo:'assets/universities/logo/28.png',
      province: 'Bangkok',
      description: '',
      map: '',
      numbers: null,
    );
    var temp29 = University(
      id: 29,
      name: 'Christian University Thailand',
      thaiName: 'มหาวิทยาลัยคgริสเตียน',
      imageUrl: 'assets/universities/images/29.jpeg',
      logo:'assets/universities/logo/29.png',
      province: 'Nakhon Pathom',
      description: '',
      map: '',
      numbers: null,
    );
    var temp30 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีมหานคร',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp31 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยรังสิต',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp32 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยหัวเฉียวเฉลิมพระเกียรติ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp33 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยอัสสัมชัญ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp34 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยธนบุรี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp35 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยชินวัตร',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp36 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยธุรกิจบัณฑิตย์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp37 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยภาคตะวันออกเฉียงเหนือ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp38 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยวงษ์ชวลิตกุล',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp39 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเว็บสเตอร์(ประเทศไทย)',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp40 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยทองสุข',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp41 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเอเชียอาคเนย์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp42 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยอีสเทิร์นเอเชีย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp43 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยกรุงเทพธนบุรี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp44 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยนานาชาติเซนต์เทเรซา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp45 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยเซาธ์อีสท์บางกอก',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp46 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยดุสิตธานี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp47 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยนอร์ทกรุงเทพ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp48 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยนอร์ทเชียงใหม่',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp49 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยนานาชาติแสตมฟอร์ด',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp50 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยนานาชาติ เอเชีย-แปซิฟิก',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp51 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏเชียงใหม่',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp52 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยหาดใหญ่',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp53 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยแสงธรรม',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp54 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏกาญจนบุรี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp55 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏเชียงราย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp56 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏนครปฐม',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp57 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏนครราชสีมา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp58 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏนครศรีธรรมราช',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp59 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏพิบูลสงคราม',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp60 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏราชนครินทร์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp61 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏรำไพพรรณี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp62 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏลำปาง',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp63 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏเลย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp64 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏศรีสะเกษ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp65 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏสงขลา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp66 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยสวนดุสิต',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp67 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏสวนสุนันทา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp68 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏอุดรธานี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp69 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏอุบลราชธานี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp70 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏสุราษฏร์ธานี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp71 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชภัฏบ้านสมเด็จเจ้าพระยา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp72 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเกษมบัณฑิต',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp73 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยสยาม',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp74 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยพุทธศาสนานานาชาติ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp75 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยนครราชสีมา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp76 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp77 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลกรุงเทพ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp78 = University(
      id: 0,
      name: 'มหาวิทยาลัยเทคโนโลยีราชมงคลตะวันออก',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลตะวันออก',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp79 = University(
      id: 0,
      name: 'มหาวิทยาลัยเทคโนโลยีราชมงคลพระนคร',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลพระนคร',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp80 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลรัตนโกสินทร์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp81 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลล้านนา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp82 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลศรีวิชัย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp83 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยเทคโนโลยีสยาม',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp84 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยเทคโนโลยีราชมงคลอีสาน',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp85 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันวิทยาลัยชุมชน',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp86 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยการกีฬาแห่งชาติ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp87 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยกรุงเทพสุวรรณภูมิ',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp88 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยราชพฤกษ์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp89 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'ราชวิทยาลัยจุฬาภรณ์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp90 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันเทคโนโลยีไทย-ญี่ปุ่น',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp91 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันอาศรมศิลป์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp92 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันเทคโนโลยีปัญญาภิวัฒน์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp93 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันการเรียนรู้เพื่อปวงชน',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp94 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันเทคโนโลยียานยนต์มหาชัย',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp95 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'มหาวิทยาลัยนวมินทราธิราช',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp96 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'สถาบันเทคโนโลยีจิตรลดา',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );
    var temp97 = University(
      id: 0,
      name: 'Chulalongkorn University',
      thaiName: 'วิทยาลัยนานาชาติราฟเฟิลส์',
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      province: '',
      description: '',
      map: '',
      numbers: null,
    );



  }


}
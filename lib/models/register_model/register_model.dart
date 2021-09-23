import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
@JsonSerializable()
class RegisterModel {
  String? odataContext;
  List<RegisterValue>? registerValue;

  RegisterModel({required this.odataContext, required this.registerValue});

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}

@JsonSerializable()
class RegisterValue {
  int id;
  String? guid;
  int? sicilNo;
  dynamic sicilKod;
  String? sicilTipId;
  bool? isCari;
  dynamic ad;
  dynamic soyad;
  String unvan;
  dynamic tcKimlikNo;
  String? vergiDairesi;
  int? vergiNumarasi;
  dynamic pasaportNo;
  int? cinsiyetLookupId;
  dynamic dogumTarih;
  dynamic dogumYer;
  dynamic egitimDurumLookupId;
  dynamic meslekLookupId;
  dynamic ilisikKesildi;
  String? cepTelefonu;
  dynamic isCepTelefonu;
  String? ePosta;
  dynamic isePosta;
  dynamic uyrukLookupId;
  dynamic varisSicilId;
  dynamic tuzelKisiTipLookupId;
  dynamic ticaretSicilNo;
  dynamic emeklilikTarih;
  dynamic sgkTipLookupId;
  dynamic sgkSicilNo;
  dynamic ehliyetTipLookupId;
  dynamic ehliyetAldigiYer;
  dynamic ehliyetNo;
  dynamic eskiSicilNo;
  dynamic eskiSicilKaynakId;
  dynamic olumTarih;
  dynamic smsBilgilendirme;
  dynamic ePostaBilgilendirme;
  dynamic fizikselArsivDosyaNo;
  dynamic kepEPosta;
  dynamic tasimaId;
  dynamic bagliUstSicilId;
  dynamic icra;
  dynamic icraTakip;
  dynamic aciklama;
  dynamic operatorUyarisi;
  String? webKullaniciUyarisi;
  dynamic babaAdi;
  dynamic anneAdi;
  dynamic eskiSoyadi;
  dynamic medeniDurumLookupId;
  dynamic kanGrupLookupId;
  dynamic dinLookupId;
  dynamic nfsCuzdanSeriNo;
  dynamic nfsCuzdanNo;
  dynamic nfsKayitIlId;
  dynamic nfsKayitIlceId;
  dynamic nfsKayitMahalle;
  dynamic nfsCiltNo;
  dynamic nfsAileSiraNo;
  dynamic nfsSiraNo;
  dynamic nfsVerilisTarih;
  dynamic nfsVerilisNedeni;
  dynamic nfsVerildigiYer;
  dynamic nfsKayitYer;
  dynamic nfsKayitNo;
  dynamic nfsVerildigiIlId;
  dynamic nfsVerildigiIlceId;
  dynamic nfsSonGecerlilikTarih;
  dynamic kutukIlkTescilTarih;
  dynamic dogumIlId;
  dynamic dogumIlceId;
  dynamic organizasyonId;
  dynamic gorevYerId;
  int? createdUserId;
  int? lastUpdatedUserId;
  String? dataStatus;
  String? createdAt;
  String? lastUpdatedAt;

  RegisterValue({
    required this.id,
    this.guid,
    this.sicilNo,
    this.sicilKod,
    this.sicilTipId,
    this.isCari,
    this.ad,
    this.soyad,
    required this.unvan,
    this.tcKimlikNo,
    this.vergiDairesi,
    this.vergiNumarasi,
    this.pasaportNo,
    this.cinsiyetLookupId,
    this.dogumTarih,
    this.dogumYer,
    this.egitimDurumLookupId,
    this.meslekLookupId,
    this.ilisikKesildi,
    this.cepTelefonu,
    this.isCepTelefonu,
    this.ePosta,
    this.isePosta,
    this.uyrukLookupId,
    this.varisSicilId,
    this.tuzelKisiTipLookupId,
    this.ticaretSicilNo,
    this.emeklilikTarih,
    this.sgkTipLookupId,
    this.sgkSicilNo,
    this.ehliyetTipLookupId,
    this.ehliyetAldigiYer,
    this.ehliyetNo,
    this.eskiSicilNo,
    this.eskiSicilKaynakId,
    this.olumTarih,
    this.smsBilgilendirme,
    this.ePostaBilgilendirme,
    this.fizikselArsivDosyaNo,
    this.kepEPosta,
    this.tasimaId,
    this.bagliUstSicilId,
    this.icra,
    this.icraTakip,
    this.aciklama,
    this.operatorUyarisi,
    this.webKullaniciUyarisi,
    this.babaAdi,
    this.anneAdi,
    this.eskiSoyadi,
    this.medeniDurumLookupId,
    this.kanGrupLookupId,
    this.dinLookupId,
    this.nfsCuzdanSeriNo,
    this.nfsCuzdanNo,
    this.nfsKayitIlId,
    this.nfsKayitIlceId,
    this.nfsKayitMahalle,
    this.nfsCiltNo,
    this.nfsAileSiraNo,
    this.nfsSiraNo,
    this.nfsVerilisTarih,
    this.nfsVerilisNedeni,
    this.nfsVerildigiYer,
    this.nfsKayitYer,
    this.nfsKayitNo,
    this.nfsVerildigiIlId,
    this.nfsVerildigiIlceId,
    this.nfsSonGecerlilikTarih,
    this.kutukIlkTescilTarih,
    this.dogumIlId,
    this.dogumIlceId,
    this.organizasyonId,
    this.gorevYerId,
    this.createdUserId,
    this.lastUpdatedUserId,
    this.dataStatus,
    this.createdAt,
    this.lastUpdatedAt,
  });

  factory RegisterValue.fromJson(Map<String, dynamic> json) =>
      _$RegisterValueFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterValueToJson(this);
}

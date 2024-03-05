import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/image/image_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('supabase select popular', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final List<Map<String, dynamic>> data =
        await supabase.rpc(FUNC_GET_POPULAR_IMAGE_COUNT);

    logger.info(data);

    // expect(cnt, 0);
    expect(data.length, 10);
  });

  test('supabase select get_tag_counts', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final List<dynamic> data = await supabase.rpc(FUNC_GET_TAG_COUNT);

    logger.info(data);

    // expect(cnt, 0);
    // expect(data.length, 10);
  });

  test('supabase counting test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final response = await supabase
        .from(TB_IMAGE_INFO)
        .select('*')
        .eq('is_deleted', false)
        .count();

    final data = response.data;
    final int cnt = response.count;

    // logger.info(data);

    // expect(cnt, 0);
    expect(cnt, 64);
  });

  test('supabase select eq test', () async {
    int selectCount = 30;

    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final dataList = await supabase
        .from(TB_IMAGE_INFO)
        .select('*')
        .eq('is_deleted', false)
        .limit(selectCount)
        .order('image_id');

    List<ImageModel> imageList =
        dataList.map((e) => ImageModel.fromJson(e)).toList();

    for (final image in imageList) {
      logger.info(image.imageId);
    }

    expect(dataList.length, selectCount);

    expect(imageList.length, selectCount);
  });
  test('supabsae select image one test 002', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final data = await supabase
        .from(TB_IMAGE_INFO)
        .select()
        .eq('image_id', 4493420)
        .single();

    ImageModel image = ImageModel.fromJson(data);

    expect(image.imageId, 4493420);
  });

  test('supabsae select image one', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    final data =
        await supabase.from(TB_IMAGE_INFO).select().eq('image_id', 4493420);

    logger.info(data);
    logger.info((data[0]["image_id"]).runtimeType);

    List<ImageModel> imageList =
        data.map((e) => ImageModel.fromJson(e)).toList();

    ImageModel image = imageList[0];

    logger.info(image.imageId);

    expect(image.imageId, 4493420);
  });

  // test('pixaApi => supabase test 001', () async {
  //   final pixabayApiRepositoryImpl = PixabayRepositoryImpl();
  //   List<HitDTO> hitList =
  //       await pixabayApiRepositoryImpl.get('sing');

  //   List<PhotoModel> photoList =
  //       hitList.map((e) => PhotoMapper.fromDTO(e)).toList();
  //   final jsonPhotoList = photoList.map((e) => e.toJson()).toList();

  //   final supabase = SupabaseClient(
  //     Env.supabaseUrl,
  //     Env.supabaseApiKey,
  //   );

  //   final response = await supabase
  //       .from(TB_IMAGE_INFO)
  //       .upsert(jsonPhotoList, onConflict: 'image_id');
  // });

  group('Supabase CRUD Tests', () {
    late SupabaseClient client;

    setUpAll(() async {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseApiKey,
      );
      client = Supabase.instance.client;
    });

    test('Insert data into Supabase table', () async {
      final data = await client.from(TB_USER_PROFILE).select();
      logger.info(data);
    });
  });

  test('supabase test 004', () async {
    final supabase = SupabaseClient(
      Env.supabaseUrl,
      Env.supabaseApiKey,
    );

    List<HitDTO> hitList = mockDataList.map((e) => HitDTO.fromJson(e)).toList();
    logger.info(hitList.length);
    // List<ImageModel> imageList =
    //     hitList.map((e) => ImageMapper.fromDTO(e)).toList();
    // final jsonImageList = imageList.map((e) => e.toJson()).toList();
    // logger.info(jsonImageList[0]);

    // final response =
    //     await supabase.from('tb_image_info_duplicate').insert(jsonImageList);

    // for (ImageModel image in imageList) {
    //   logger.info(image);
    // }
  });
}

final mockDataList = [
  {
    "id": 715540,
    "pageURL":
        "https://pixabay.com/photos/yellow-flower-blossom-bloom-petals-715540/",
    "type": "photo",
    "tags": "yellow, flower, flower background",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/04/10/00/41/yellow-715540_150.jpg",
    "previewWidth": 150,
    "previewHeight": 84,
    "webformatURL":
        "https://pixabay.com/get/gf8ad6fca26f1fd474c515c0682c9d9c5973a36af318d02d70738f4e0764492618f0f279ff8b1cc4d24cdbfa88f78a59c_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 360,
    "largeImageURL":
        "https://pixabay.com/get/gdcbe9f07039850a2236f741085b07838d4b61d140f9b2ed940972d50af89104e3439f38e012bf1d20fe53881cde2c130b6fc3d776b26479aacef999de23406e6_1280.jpg",
    "imageWidth": 3020,
    "imageHeight": 1703,
    "imageSize": 974940,
    "views": 169317,
    "downloads": 102647,
    "collections": 476,
    "likes": 391,
    "comments": 53,
    "user_id": 916237,
    "user": "Wow_Pho",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/04/07/14-10-15-590_250x250.jpg"
  },
  {
    "id": 273391,
    "pageURL":
        "https://pixabay.com/photos/flower-yellow-petals-yellow-flower-273391/",
    "type": "photo",
    "tags": "flower, yellow petals, yellow flower",
    "previewURL":
        "https://cdn.pixabay.com/photo/2014/02/24/05/11/flower-273391_150.jpg",
    "previewWidth": 150,
    "previewHeight": 112,
    "webformatURL":
        "https://pixabay.com/get/ge131271606284bbb42bc16026e138d097b1059f1c11064dc28c790cfdee778bbbc230994d91268bdebe601d8b3db4f1f_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 480,
    "largeImageURL":
        "https://pixabay.com/get/g4f3bd0718cc2352f7d5ce6121085b4953f54b82c0253c490cd7b707d38add0f9b415432d94420eb6ac186483e5a633cfba059afbd344a1918a2792fe4ef05c0f_1280.jpg",
    "imageWidth": 2607,
    "imageHeight": 1956,
    "imageSize": 890318,
    "views": 22301,
    "downloads": 6572,
    "collections": 196,
    "likes": 72,
    "comments": 13,
    "user_id": 152861,
    "user": "angelac72",
    "userImageURL":
        "https://cdn.pixabay.com/user/2014/02/10/02-47-32-118_250x250.jpg"
  },
  {
    "id": 6520851,
    "pageURL":
        "https://pixabay.com/photos/flower-yellow-flower-bloom-blossom-6520851/",
    "type": "photo",
    "tags": "flower, yellow flower, bloom",
    "previewURL":
        "https://cdn.pixabay.com/photo/2021/08/04/02/02/flower-6520851_150.jpg",
    "previewWidth": 150,
    "previewHeight": 103,
    "webformatURL":
        "https://pixabay.com/get/g2a2b4f792d00a726e036212ff9c9953f3dcffefc8f023f0f272974690ae13566c48f145da021a01a936159915feb30d4588f5a2592fca81b1a047403708487d3_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 439,
    "largeImageURL":
        "https://pixabay.com/get/g226e0170259e5620f5ed63b612e04248f90264829665a356d44f721ddea6233da098d44f0ead8dbfd4270ab6d7d315ca9946496e8b8e757e05231673d710e9ef_1280.jpg",
    "imageWidth": 3910,
    "imageHeight": 2680,
    "imageSize": 3171422,
    "views": 11947,
    "downloads": 5439,
    "collections": 83,
    "likes": 89,
    "comments": 18,
    "user_id": 6246704,
    "user": "fernandozhiminaicela",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/02/27/14-16-13-192_250x250.jpg"
  },
  {
    "id": 4750726,
    "pageURL":
        "https://pixabay.com/photos/flower-petals-bloom-yellow-yellow-4750726/",
    "type": "photo",
    "tags": "flower, petals, beautiful flowers",
    "previewURL":
        "https://cdn.pixabay.com/photo/2020/01/08/17/32/flower-4750726_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g8dae969dee3cec4176f39cf9a2809dc043580e4bace0a676ddd846a336165d925ff9904236a0563b6e92f85eac9a4a793ea31dcac49a8afc79befe983d275151_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 425,
    "largeImageURL":
        "https://pixabay.com/get/g8010a66105749bf16236025b972d27753b733ef01a63230d2ec93ac2922f69ddad1fab56c9d6cada1a355fe6e047c70fd917b986fc3a8c5d17463ba3fab94296_1280.jpg",
    "imageWidth": 3008,
    "imageHeight": 2000,
    "imageSize": 1453867,
    "views": 5189,
    "downloads": 2694,
    "collections": 55,
    "likes": 48,
    "comments": 23,
    "user_id": 14174246,
    "user": "Zotx",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/11/20/20-56-12-836_250x250.jpg"
  },
  {
    "id": 1512813,
    "pageURL":
        "https://pixabay.com/photos/lilies-yellow-flowers-petals-1512813/",
    "type": "photo",
    "tags": "lilies, beautiful flowers, yellow",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/07/12/18/54/lilies-1512813_150.jpg",
    "previewWidth": 150,
    "previewHeight": 75,
    "webformatURL":
        "https://pixabay.com/get/gbf70ae22f6fc62a80036fa7ed0f0c3a97d700dc2d2575ba77ee42c78ce7417123e16a48705a528cefe6f5edb33fc20ff480af89cce0dd4fd6d1fbda000fc800d_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 323,
    "largeImageURL":
        "https://pixabay.com/get/g9b2b5eecf458d79e729d32cb974d34c76b28177c3f0a69879d4414d0fc0cd7acd9f53dac52da5d107bfd33d35879e03b6248b62fd8343fc2fa3865fd206ec8eb_1280.jpg",
    "imageWidth": 3861,
    "imageHeight": 1952,
    "imageSize": 1037708,
    "views": 214716,
    "downloads": 133040,
    "collections": 645,
    "likes": 634,
    "comments": 65,
    "user_id": 2364555,
    "user": "NoName_13",
    "userImageURL":
        "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
  },
  {
    "id": 4384750,
    "pageURL":
        "https://pixabay.com/photos/flower-yellow-flower-plant-macro-4384750/",
    "type": "photo",
    "tags": "flower, yellow flower, plant",
    "previewURL":
        "https://cdn.pixabay.com/photo/2019/08/04/20/48/flower-4384750_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g38646e3a560129d2f189b41c4ee440f22dbc71f7a939d0817099758184e0d367f7e5f5c466ebb99dce26ef624201613d2101993d8095a45f5f6d33a27a7969fc_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/gcd4a59f11aafdae9e2fcff9b093cea0325461891de600d79abc9c5f03441a52328f15d451f2fba0031f8e70815985ea6573c95cdee53b93ab06d3c545453a65d_1280.jpg",
    "imageWidth": 5286,
    "imageHeight": 3532,
    "imageSize": 1161871,
    "views": 2164,
    "downloads": 1099,
    "collections": 12,
    "likes": 39,
    "comments": 25,
    "user_id": 7520060,
    "user": "DerWeg",
    "userImageURL":
        "https://cdn.pixabay.com/user/2023/07/09/08-27-31-784_250x250.jpg"
  },
  {
    "id": 113735,
    "pageURL":
        "https://pixabay.com/photos/flower-rose-garden-yellow-rose-113735/",
    "type": "photo",
    "tags": "flower, flower background, rose",
    "previewURL":
        "https://cdn.pixabay.com/photo/2013/05/26/12/14/flower-113735_150.jpg",
    "previewWidth": 150,
    "previewHeight": 83,
    "webformatURL":
        "https://pixabay.com/get/ga7d261ebaaf562b448c5f9e9d134e929df1b6ef3a5ae3564130a3c6d05eda29153de88c7520af37d2378951e40df9dd1_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 355,
    "largeImageURL":
        "https://pixabay.com/get/g926b7c313e0597112ae96235a55ab15240534380de2a58d91409d13f27e9b5b8e139ccfc5ad10356c4b14322cf036f0bde5238644947f0177335aae21fb68f83_1280.jpg",
    "imageWidth": 2410,
    "imageHeight": 1337,
    "imageSize": 299425,
    "views": 170467,
    "downloads": 64157,
    "collections": 353,
    "likes": 328,
    "comments": 52,
    "user_id": 817,
    "user": "blizniak",
    "userImageURL":
        "https://cdn.pixabay.com/user/2013/06/28/17-07-05-714_250x250.jpg"
  },
  {
    "id": 4042853,
    "pageURL": "https://pixabay.com/photos/sulphur-anemone-flowers-4042853/",
    "type": "photo",
    "tags": "sulphur anemone, flowers, yellow flower",
    "previewURL":
        "https://cdn.pixabay.com/photo/2019/03/08/17/43/sulphur-anemone-4042853_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g14b6a689337edf07472c8ef3a01042d42254b4cc962f5968e883e4b009564ee709669b035bc53f600f4e5c904f913d7b03fe302572ccd67af113c59ccc0def0d_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/gb8728683c2d299e7bb367c00eb5ef55928040cb7ff820fa035d4b00407a22d57005c781d50d1ac0a86323bb46f0dcb975ee60d5d42031c2bcd7d81dc033e3322_1280.jpg",
    "imageWidth": 5394,
    "imageHeight": 3593,
    "imageSize": 7268701,
    "views": 18422,
    "downloads": 13355,
    "collections": 51,
    "likes": 81,
    "comments": 20,
    "user_id": 6482,
    "user": "gsibergerin",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/03/09/16-09-22-778_250x250.jpg"
  },
  {
    "id": 4936511,
    "pageURL":
        "https://pixabay.com/photos/flowers-yellow-flowers-nature-4936511/",
    "type": "photo",
    "tags": "flowers, yellow flowers, beautiful flowers",
    "previewURL":
        "https://cdn.pixabay.com/photo/2020/03/16/10/27/flowers-4936511_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g9c641af6ef5856457651c12c39b1d4267e2121b5a00791d722311959798879e81f47db29e34527c565580b225f44edcedddb34789f8a4f0930c2195c34dd6f55_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/g9f4bd0b89f9cfad88ca646420859730f9b8c33c023c8ad664edf85a37276ef8325c2d5cf13e11863b8d69a03e1301e7e9335e653f7dbba43d7420088ca89e0e6_1280.jpg",
    "imageWidth": 5000,
    "imageHeight": 3333,
    "imageSize": 2156782,
    "views": 30372,
    "downloads": 18434,
    "collections": 118,
    "likes": 112,
    "comments": 20,
    "user_id": 3603324,
    "user": "phtorxp",
    "userImageURL":
        "https://cdn.pixabay.com/user/2022/11/27/11-56-03-466_250x250.jpg"
  },
  {
    "id": 1972411,
    "pageURL":
        "https://pixabay.com/photos/drip-yellow-petals-globules-water-1972411/",
    "type": "photo",
    "tags": "drip, yellow, petals",
    "previewURL":
        "https://cdn.pixabay.com/photo/2017/01/11/17/27/drip-1972411_150.jpg",
    "previewWidth": 150,
    "previewHeight": 87,
    "webformatURL":
        "https://pixabay.com/get/gc41a9f178e129e81865e337046a0349cce4f4ec79d22e23cb200af57463edae4e448043f02cf5306a65e3b2070d180f0c20eab7b7e5e5b34db65b8849d882b9d_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 372,
    "largeImageURL":
        "https://pixabay.com/get/g8218349141f219e480ae0eeef5bac7a4b57c25c66a14f6c1bc50e7d5bcbbded9f991e1645310084a8bbbcf9a09d209bc6f73c036de0e48b0a307eca5ac743320_1280.jpg",
    "imageWidth": 4288,
    "imageHeight": 2499,
    "imageSize": 1510459,
    "views": 170773,
    "downloads": 142469,
    "collections": 438,
    "likes": 457,
    "comments": 63,
    "user_id": 1777190,
    "user": "susannp4",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/12/16/17-56-55-832_250x250.jpg"
  },
  {
    "id": 208299,
    "pageURL": "https://pixabay.com/photos/rapeseeds-flowers-field-208299/",
    "type": "photo",
    "tags": "rapeseeds, flowers, field",
    "previewURL":
        "https://cdn.pixabay.com/photo/2013/11/10/14/47/rapeseeds-208299_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g4682a3e0da97d889a88cd5defe91b0bca4cc9c7853dcc8b76a122309ab45715bad6b5382b93a458cfd0cfa2a798aae74_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 428,
    "largeImageURL":
        "https://pixabay.com/get/gbc9ac26f1c58784d51ffefccaa2ad95eddc2efb220d3c52dc5b03a56007e71c86ccb09d22f4d3d4d923bfa168fe7db22de6ccf34b0963a6691f5dc9e705eb246_1280.jpg",
    "imageWidth": 1936,
    "imageHeight": 1296,
    "imageSize": 991014,
    "views": 36551,
    "downloads": 16184,
    "collections": 142,
    "likes": 121,
    "comments": 19,
    "user_id": 83702,
    "user": "Tihomir",
    "userImageURL":
        "https://cdn.pixabay.com/user/2013/11/05/19-31-44-620_250x250.jpg"
  },
  {
    "id": 4251915,
    "pageURL":
        "https://pixabay.com/photos/yellow-rose-flower-rose-dewdrops-4251915/",
    "type": "photo",
    "tags": "yellow rose, flower, rose flower",
    "previewURL":
        "https://cdn.pixabay.com/photo/2019/06/04/17/24/yellow-rose-4251915_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g84fbe4fa67928c21f57a43f7ea8b97b21d4718ab883e5127dcc959a92e53953b701acd04d90a15a6277a28fc7395d76e409b9719a056c27ec90a73cb906348ad_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g11bcd1df819fa4bef8615577de34efd172998ae5fc64d08a91bb589fa53a9f0dae01696c3edc85aeecada39396f55fba958215d121bec3662420fb5d6d9bb79b_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 1374672,
    "views": 69058,
    "downloads": 46167,
    "collections": 247,
    "likes": 288,
    "comments": 64,
    "user_id": 9097212,
    "user": "armennano",
    "userImageURL":
        "https://cdn.pixabay.com/user/2022/08/30/09-41-39-759_250x250.jpeg"
  },
  {
    "id": 2107024,
    "pageURL":
        "https://pixabay.com/photos/crocus-flowers-yellow-bloom-2107024/",
    "type": "photo",
    "tags": "crocus, flowers, yellow",
    "previewURL":
        "https://cdn.pixabay.com/photo/2017/02/28/22/37/crocus-2107024_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g1b67e31d3eb5815e52b56bcf8e55fdcaa1952f5f0cb429020d21733fbbc5463b6d31fa7662e1895f1f9cea87101af28edaf50f073101a94aec567b57fb352acc_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g459446e7b52adee27b85f820b45bb198e7b7fb9ebdbbf130e5677c03acea11f272bd0f629b7ca4705e908c5e788ddcd6148a526c4bf95c9400baeede64b77010_1280.jpg",
    "imageWidth": 4896,
    "imageHeight": 3264,
    "imageSize": 2596169,
    "views": 105140,
    "downloads": 67087,
    "collections": 209,
    "likes": 295,
    "comments": 50,
    "user_id": 1195798,
    "user": "Couleur",
    "userImageURL":
        "https://cdn.pixabay.com/user/2023/10/01/05-24-36-74_250x250.jpg"
  },
  {
    "id": 6558487,
    "pageURL":
        "https://pixabay.com/photos/flowers-coast-sea-yellow-flowers-6558487/",
    "type": "photo",
    "tags": "flowers, coast, flower wallpaper",
    "previewURL":
        "https://cdn.pixabay.com/photo/2021/08/19/16/31/flowers-6558487_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g8da7d2675ca582273d5bbb462190d749b28f2962d19753cbe2fccfd34b5ae58ed762392c1b69c2e443ad77c10e3f721846b83e3b4d391791d576d729423e4378_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g0ae9bf04bb94ea1a4fa809c49b80fa5d6e037e50498b006fcaa5b824d4cb6411049d34913f3556ca6304444361c1651a3231b7d674b4f5951bf883a0a1880b13_1280.jpg",
    "imageWidth": 4256,
    "imageHeight": 2832,
    "imageSize": 4587665,
    "views": 168398,
    "downloads": 143241,
    "collections": 233,
    "likes": 310,
    "comments": 40,
    "user_id": 21633244,
    "user": "lillolillolillo",
    "userImageURL":
        "https://cdn.pixabay.com/user/2021/06/09/06-56-51-212_250x250.jpg"
  },
  {
    "id": 6162613,
    "pageURL":
        "https://pixabay.com/photos/yellow-rose-rose-flower-cereal-6162613/",
    "type": "photo",
    "tags": "yellow rose, rose, flower",
    "previewURL":
        "https://cdn.pixabay.com/photo/2021/04/08/18/59/yellow-rose-6162613_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g4867b74780005b74b5998b43d2fe49d30fba7e61890d13d638f5a15d0171dafa0ae3b7757248ff183ce304dc765247bc5e778f6cf2457d91fdcf58e4c969b0e4_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/g79733cc69af97bbb27e4f7e3c73e393367a292ac76e89281304dae562f90cdea5f3b861ccf732805bbf9d5daeaa8cabee61ad3b9b0119e1833d9f5fbbd1d60d2_1280.jpg",
    "imageWidth": 4240,
    "imageHeight": 2832,
    "imageSize": 2389361,
    "views": 48952,
    "downloads": 36862,
    "collections": 114,
    "likes": 251,
    "comments": 199,
    "user_id": 9363663,
    "user": "Nowaja",
    "userImageURL":
        "https://cdn.pixabay.com/user/2020/09/15/15-16-12-52_250x250.jpg"
  },
  {
    "id": 7193390,
    "pageURL":
        "https://pixabay.com/photos/flower-ranunculus-petals-dark-7193390/",
    "type": "photo",
    "tags": "flower, ranunculus, petals",
    "previewURL":
        "https://cdn.pixabay.com/photo/2022/05/13/10/35/flower-7193390_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g9f503625b2762ee3e4fe116a3482be6912224643d8970dd36d80b426cfb9115fa7de7762a2e4dc90b91f1281a7dbbb4cb1e38b923e22f81ffde869ce7b43ff94_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/g5dad16a3d588081d1d6572ef90ca9db96226681bf23bfff2bc6229109408b72dcbc8e60163be4796433d5585b8b67bbb3ef5bf651073c2aa58127b50d6a8f377_1280.jpg",
    "imageWidth": 5472,
    "imageHeight": 3648,
    "imageSize": 2311191,
    "views": 9529,
    "downloads": 6196,
    "collections": 78,
    "likes": 96,
    "comments": 11,
    "user_id": 25590070,
    "user": "nohopuku_photography",
    "userImageURL":
        "https://cdn.pixabay.com/user/2023/10/17/09-33-11-665_250x250.jpg"
  },
  {
    "id": 6316445,
    "pageURL": "https://pixabay.com/photos/rapeseeds-yellow-flowers-6316445/",
    "type": "photo",
    "tags": "rapeseeds, yellow, flowers",
    "previewURL":
        "https://cdn.pixabay.com/photo/2021/06/06/21/55/rapeseeds-6316445_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g02f208d77886b128b2671abed6a262c1e4753f45aad90ca4ca83458cfcd6ece91c45ac1e93ad5f0d0cf52c6376090ff99f6b949654d0c66e6a7fb589bac9e371_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/gaa91388560be5927321ddadb11c76f54f62cc5b791379a7a07993fed4753078175f386ca31fa51169f8af3c3a43b6b9364b011171af7861ecbd51b542af14f02_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 7735260,
    "views": 31816,
    "downloads": 25753,
    "collections": 53,
    "likes": 75,
    "comments": 18,
    "user_id": 11378535,
    "user": "__Tatius__",
    "userImageURL":
        "https://cdn.pixabay.com/user/2020/10/16/11-47-36-873_250x250.jpeg"
  },
  {
    "id": 4989694,
    "pageURL":
        "https://pixabay.com/photos/rananculus-flowers-plant-nature-4989694/",
    "type": "photo",
    "tags": "rananculus, flowers, plant",
    "previewURL":
        "https://cdn.pixabay.com/photo/2020/04/01/01/13/rananculus-4989694_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/gccd6ed4213e96a05569b5e04d94617c2baa3b4a56dd945608e6dddceaf1ffc80d0c0792618bdf7a1aad7b2a8d138404a8a20343ae6e052d8344c714a0270a349_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/gd3bf230214e5559fe47417cbcca264675b301e8600886c5875b375b2f674b470502ff616fbb4af70788edf5a0a25c2c1a177e0727798e739a364bdda3b402f65_1280.jpg",
    "imageWidth": 4752,
    "imageHeight": 3168,
    "imageSize": 1475741,
    "views": 10263,
    "downloads": 7482,
    "collections": 74,
    "likes": 67,
    "comments": 9,
    "user_id": 13405528,
    "user": "tayphuong388",
    "userImageURL":
        "https://cdn.pixabay.com/user/2020/04/06/08-25-05-747_250x250.jpg"
  },
  {
    "id": 4298808,
    "pageURL":
        "https://pixabay.com/photos/sunflowers-flowers-yellow-flowers-4298808/",
    "type": "photo",
    "tags": "sunflowers, flowers, yellow flowers",
    "previewURL":
        "https://cdn.pixabay.com/photo/2019/06/25/18/50/sunflowers-4298808_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g2e42e9ab2b8a67e2b3950a2b6281f7ef8b8c2560f66ad8200c09de0453584e0839cfeb3262e4d26dab283febd0d0676ae56e549f3ccc80208f1a764c1d3dbd62_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/gbcd1e7cdea5832285dde82d8dde399f1d7208936385ef017b7a7c7e178382a72e857d47872e4a071c85d3c5b2fe4a70261a788c557b814238f3ed1adeac1db22_1280.jpg",
    "imageWidth": 5658,
    "imageHeight": 3772,
    "imageSize": 4953436,
    "views": 127976,
    "downloads": 81980,
    "collections": 358,
    "likes": 405,
    "comments": 76,
    "user_id": 1161770,
    "user": "Bru-nO",
    "userImageURL":
        "https://cdn.pixabay.com/user/2023/04/18/15-01-28-484_250x250.jpg"
  },
  {
    "id": 7341288,
    "pageURL":
        "https://pixabay.com/photos/flower-yellow-flower-petals-7341288/",
    "type": "photo",
    "tags": "flower, yellow flower, petals",
    "previewURL":
        "https://cdn.pixabay.com/photo/2022/07/24/09/32/flower-7341288_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/gb40104489d1e85bc6569bbcf06e11781880315b254877d553e6f47ce206cacd285819f88fd6f1c3dfb1e02ace67dcccf7b9add3490de0d4f72c43b709e59b120_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/gde47d98dbc8b1ccff99b2908776f45e664f4d683971992f1fd92ed668df5cccdea1834c6cec08fdc814956795a9c1ef101d363388b465f3021b8b8682869f435_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 4490213,
    "views": 22203,
    "downloads": 17820,
    "collections": 43,
    "likes": 88,
    "comments": 18,
    "user_id": 37761,
    "user": "Lolame",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/05/19/22-51-58-56_250x250.jpg"
  }
];

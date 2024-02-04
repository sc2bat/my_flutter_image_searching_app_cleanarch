import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/pixabay.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:http/http.dart' as http;

import 'pixabay_api_repository_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('pixabay data test', () async {
    final pixabayApiRepositoryImpl = PixabayRepositoryImpl();

    List<Hit> hits = await pixabayApiRepositoryImpl.getPixabayImages('apple');

    // expect(images, MockData['hits']);

    // expect(images[0].id, 1122537);
    // expect(images[1].id, 256261);
    for (Hit hit in hits) {
      logger.info(hit.id);
    }

    expect(hits.length, 20);
  });

  test('Mokito pixabay data test', () async {
    final pixabayApiRepositoryImpl = PixabayRepositoryImpl();

    final mockClient = MockClient();

    when(mockClient.get(Uri.parse('${pixabayApiUrl}apple')))
        .thenAnswer((_) async => http.Response(mockData, 200));

    List<Hit> hits = await pixabayApiRepositoryImpl
        .getPixabayImagesTest('apple', client: mockClient);

    expect(hits.first.id, 1122537);

    verify(mockClient.get(Uri.parse('${pixabayApiUrl}apple')));
  });

  test('Mokito pixabay photo data test', () async {
    final pixabayApiRepositoryImpl = PixabayRepositoryImpl();

    final mockClient = MockClient();

    when(mockClient.get(Uri.parse('${pixabayApiUrl}apple')))
        .thenAnswer((_) async => http.Response(mockData, 200));

    List<Photo> photos = await pixabayApiRepositoryImpl
        .getPixabayPhotosByClient('apple', client: mockClient);

    expect(photos.first.id, 1122537);

    verify(mockClient.get(Uri.parse('${pixabayApiUrl}apple')));
  });
}

String mockData = """
    {
  "total": 9380,
  "totalHits": 500,
  "hits": [
    {
      "id": 1122537,
      "pageURL":
          "https://pixabay.com/photos/apple-water-droplets-fruit-moist-1122537/",
      "type": "photo",
      "tags": "apple, water droplets, fruit",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537_150.jpg",
      "previewWidth": 150,
      "previewHeight": 95,
      "webformatURL":
          "https://pixabay.com/get/gdd45e41c0574f4a9085dc9fd0fb7d87237ead925352101058ac74a7c6d34594ec8a496b957952d83fe53fcf160ce176ed86f26685a62bb1552f54622d17a5327_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 409,
      "largeImageURL":
          "https://pixabay.com/get/gfc3cbf568905cede556e70071fefcef5778160bc9d2a5630207d4656646a83f3868aab3a6e2cd2e3a0bd34a0c0b7335b0adf48940a023e4f426f73dc7d758b67_1280.jpg",
      "imageWidth": 4752,
      "imageHeight": 3044,
      "imageSize": 5213632,
      "views": 382689,
      "downloads": 230144,
      "collections": 1141,
      "likes": 1250,
      "comments": 198,
      "user_id": 1445608,
      "user": "mploscar",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/01/05/14-08-20-943_250x250.jpg"
    },
    {
      "id": 256261,
      "pageURL":
          "https://pixabay.com/photos/apple-books-still-life-fruit-food-256261/",
      "type": "photo",
      "tags": "apple, books, still life",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/02/01/17/28/apple-256261_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g59c541a0f67891e554e651f7df1b151ccdd4409e3a75a8d072bb50e6cae1085c7745a5e33e94fc786c03729b9e5d0342_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 423,
      "largeImageURL":
          "https://pixabay.com/get/g19148f617731dea089f9a97263aceea2904d68ad06a37278983e2581ca34f5a832b1dae6dc3951dcfd44cd3943bbb1a768e487c6e71ef19e7130478e4029250a_1280.jpg",
      "imageWidth": 4928,
      "imageHeight": 3264,
      "imageSize": 2987083,
      "views": 582380,
      "downloads": 321618,
      "collections": 1011,
      "likes": 1030,
      "comments": 250,
      "user_id": 143740,
      "user": "jarmoluk",
      "userImageURL":
          "https://cdn.pixabay.com/user/2019/09/18/07-14-26-24_250x250.jpg"
    },
    {
      "id": 1873078,
      "pageURL":
          "https://pixabay.com/photos/apples-orchard-apple-trees-1873078/",
      "type": "photo",
      "tags": "apples, orchard, apple trees",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/11/30/15/23/apples-1873078_150.jpg",
      "previewWidth": 150,
      "previewHeight": 95,
      "webformatURL":
          "https://pixabay.com/get/g5f05d9b2bff5f6ba11f50ed5a24ae3a58ecddd55c8a9276c34a46341b7c9d9309e254c1241dc20ab94442ff363d2ef3f84696ced3d46c86cddd8790b2f642428_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 408,
      "largeImageURL":
          "https://pixabay.com/get/g2d0c2520fa21daa8a1b7c2857fa42c34c24238c6c309dbde3b8d3d5fa96e3ac8c2fab2cab719a6cec972fdcdd4db277ee1c6b5020a60f6229a0b54ff40c6509e_1280.jpg",
      "imageWidth": 3212,
      "imageHeight": 2051,
      "imageSize": 2581012,
      "views": 530603,
      "downloads": 324519,
      "collections": 1260,
      "likes": 1295,
      "comments": 197,
      "user_id": 3890388,
      "user": "lumix2004",
      "userImageURL": ""
    },
    {
      "id": 634572,
      "pageURL":
          "https://pixabay.com/photos/apples-fruits-red-ripe-vitamins-634572/",
      "type": "photo",
      "tags": "apples, fruits, red",
      "previewURL":
          "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
      "previewWidth": 100,
      "previewHeight": 150,
      "webformatURL":
          "https://pixabay.com/get/g6d225410a12be6716612ad4ac80acc5d1758c6748b5ea2c6c11e26cc8fd29c87e581a5e597f0e2338de6c415194f195a_640.jpg",
      "webformatWidth": 427,
      "webformatHeight": 640,
      "largeImageURL":
          "https://pixabay.com/get/g1e435bc2d501b225bdebe85175ebb963d6704084f5c91742dc96dd72db4875f87cd47362a5a73b712a175fb1c8b35d7c0ff37f25492dc9696a310efecc27aea9_1280.jpg",
      "imageWidth": 3345,
      "imageHeight": 5017,
      "imageSize": 811238,
      "views": 556044,
      "downloads": 339842,
      "collections": 1384,
      "likes": 2467,
      "comments": 208,
      "user_id": 752536,
      "user": "Desertrose7",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/03/14/13-25-18-933_250x250.jpg"
    },
    {
      "id": 1868496,
      "pageURL":
          "https://pixabay.com/photos/apple-computer-desk-workspace-1868496/",
      "type": "photo",
      "tags": "apple, computer, desk",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/11/29/08/41/apple-1868496_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/gd53a142c93203dccdaa8ebc88c2f4c3b7d2870c6b856d84afb1d0c67edae54261e92165fc5aefb81ecc118ed43a9ec61e8f0a94cfdc60a6035c93a5a282fe1d5_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/ga8fbb796c1a9bd8dbc958cc3577dd9d9bfe56885de8bfacb5a3ef25ff41d67bbb2a272f3c9bd0575356a52ba86d580dbf9460abdb5dfa305f81bd4c1826762d4_1280.jpg",
      "imageWidth": 5184,
      "imageHeight": 3456,
      "imageSize": 2735519,
      "views": 802939,
      "downloads": 595410,
      "collections": 1516,
      "likes": 1163,
      "comments": 290,
      "user_id": 2286921,
      "user": "Pexels",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
    },
    {
      "id": 2788599,
      "pageURL":
          "https://pixabay.com/photos/apples-red-apple-ripe-apple-orchard-2788599/",
      "type": "photo",
      "tags": "apples, red apple, ripe",
      "previewURL":
          "https://cdn.pixabay.com/photo/2017/09/26/13/21/apples-2788599_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g54cb50e8ff18a0d24b278ecde0c9c4e26c32aaef8713337c767283a28a0bc46c843cb29780ca1d62b49bc0a28d14ad416e01d41b92f5f7ce34ce27b9e8af4aca_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/gec368f9c7818b15b820cb4911658e983baca068263f940485e0c344f3c73ea248f9940fd6e613f79896259b76d62045ec8497b898018d14867117fb56a665950_1280.jpg",
      "imageWidth": 6000,
      "imageHeight": 4000,
      "imageSize": 3660484,
      "views": 155745,
      "downloads": 86309,
      "collections": 577,
      "likes": 637,
      "comments": 74,
      "user_id": 2364555,
      "user": "NoName_13",
      "userImageURL":
          "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
    },
    {
      "id": 256263,
      "pageURL":
          "https://pixabay.com/photos/apple-books-classroom-red-apple-256263/",
      "type": "photo",
      "tags": "apple, books, classroom",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/02/01/17/28/apple-256263_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g1cf8f03257c33ea004a3aa09b780fd20c0568cc4dd388f447b189416110d7970005ed7909b942291843635b38cfe2c61_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 423,
      "largeImageURL":
          "https://pixabay.com/get/g03156d684643e1505de331bf709c939b4879743661e6e5a2bef707ec1ac52dbbd2ce8232b6b0d1897021d9397847ac23e8daabea5f2f96bcd00596f2313a9f55_1280.jpg",
      "imageWidth": 4928,
      "imageHeight": 3264,
      "imageSize": 2864273,
      "views": 272649,
      "downloads": 154448,
      "collections": 619,
      "likes": 551,
      "comments": 108,
      "user_id": 143740,
      "user": "jarmoluk",
      "userImageURL":
          "https://cdn.pixabay.com/user/2019/09/18/07-14-26-24_250x250.jpg"
    },
    {
      "id": 2788662,
      "pageURL":
          "https://pixabay.com/photos/apple-red-hand-apple-plantation-2788662/",
      "type": "photo",
      "tags": "apple, red, hand",
      "previewURL":
          "https://cdn.pixabay.com/photo/2017/09/26/13/42/apple-2788662_150.jpg",
      "previewWidth": 150,
      "previewHeight": 88,
      "webformatURL":
          "https://pixabay.com/get/g1b45481266d2c061994dd977b6e31fe71186dd7d245e37a4a892e2f8ca97e740bc097d097d5ec05bcd0a914315712e06c101b248a5b6d6f584d7443d300a68ed_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 377,
      "largeImageURL":
          "https://pixabay.com/get/g39b669f55a2c2f6c8ed7b05dd645f3d5ad6f7e86a4d7211ebc1028e55ae72b6856ff2a8c9b1382b11f93c975bb80febce7ff1071489ff2c69f5be805f84ee19f_1280.jpg",
      "imageWidth": 6000,
      "imageHeight": 3539,
      "imageSize": 2042422,
      "views": 208859,
      "downloads": 131795,
      "collections": 620,
      "likes": 646,
      "comments": 94,
      "user_id": 2364555,
      "user": "NoName_13",
      "userImageURL":
          "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
    },
    {
      "id": 606761,
      "pageURL": "https://pixabay.com/photos/apple-imac-ipad-workplace-606761/",
      "type": "photo",
      "tags": "apple, imac, ipad",
      "previewURL":
          "https://cdn.pixabay.com/photo/2015/01/21/14/14/apple-606761_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g8a772f547f39cbad9b3272da2179894d33e2a0807294f479a3f7df5ead6d38a8e27826a47afe357dfd0aa7c24360e7ee_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 425,
      "largeImageURL":
          "https://pixabay.com/get/g34a8f5d3b68025678bc9bd55858d305805277a04b174688d56223be30d59401a782e563ef17295c20c055f57a52626fe2f1a18a0676ea38f5a832c33eb81151a_1280.jpg",
      "imageWidth": 4209,
      "imageHeight": 2796,
      "imageSize": 1649126,
      "views": 471401,
      "downloads": 269603,
      "collections": 716,
      "likes": 544,
      "comments": 121,
      "user_id": 663163,
      "user": "Firmbee",
      "userImageURL":
          "https://cdn.pixabay.com/user/2020/11/25/09-38-28-431_250x250.png"
    },
    {
      "id": 1368187,
      "pageURL":
          "https://pixabay.com/photos/apple-blossom-flowers-tree-1368187/",
      "type": "photo",
      "tags": "apple blossom, flowers, tree",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/05/02/22/16/apple-blossom-1368187_150.jpg",
      "previewWidth": 150,
      "previewHeight": 88,
      "webformatURL":
          "https://pixabay.com/get/g8d23d3998372e7efa5adb3411cb6484de03c498fe6fcd6b913d260722c238ad13d80e434b5877fd8bc1a4afe9607c1d50f4d65e61d58c17155bef68cde13e2ec_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 379,
      "largeImageURL":
          "https://pixabay.com/get/g0080b7eef12d092ab3608c2bfb393a57e214c66e7e025aa28e0f514c17311b6a188d67a9d280eff892fd6c14c2baad83e1dcfc2d58341ab75f9335f92fd0dae3_1280.jpg",
      "imageWidth": 3966,
      "imageHeight": 2352,
      "imageSize": 860935,
      "views": 283059,
      "downloads": 178945,
      "collections": 692,
      "likes": 805,
      "comments": 137,
      "user_id": 2367988,
      "user": "kie-ker",
      "userImageURL": ""
    },
    {
      "id": 2788651,
      "pageURL":
          "https://pixabay.com/photos/apples-apple-tree-fruits-orchard-2788651/",
      "type": "photo",
      "tags": "apples, apple tree, fruits",
      "previewURL":
          "https://cdn.pixabay.com/photo/2017/09/26/13/39/apples-2788651_150.jpg",
      "previewWidth": 150,
      "previewHeight": 77,
      "webformatURL":
          "https://pixabay.com/get/g7a4266027cadef3968e441c17ce86e5352612385264273823ea49d158367144d450557caa9b332de64be9a6d689d0c798acadf2b07870fb5599a8e67388513e4_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 330,
      "largeImageURL":
          "https://pixabay.com/get/g162bf8f540f010117fa1f199c4f111324187c89c1c2c9092425e5bd47c12db8926f55e5ff9873b31f6774f6957de43b1e604a73d81004c0b0480ca58b7ee1585_1280.jpg",
      "imageWidth": 6000,
      "imageHeight": 3103,
      "imageSize": 2518838,
      "views": 88427,
      "downloads": 56926,
      "collections": 486,
      "likes": 474,
      "comments": 53,
      "user_id": 2364555,
      "user": "NoName_13",
      "userImageURL":
          "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
    },
    {
      "id": 2788616,
      "pageURL": "https://pixabay.com/photos/apple-red-red-apple-2788616/",
      "type": "photo",
      "tags": "apple, red, red apple",
      "previewURL":
          "https://cdn.pixabay.com/photo/2017/09/26/13/31/apple-2788616_150.jpg",
      "previewWidth": 150,
      "previewHeight": 90,
      "webformatURL":
          "https://pixabay.com/get/gea987e4fed0afac487c90060d98f49b86ec5cf7a4ea180f8a47f18c7ec319e3d095d992823c3c6dc4a404133da8ec5d24515e4779c16b759c7325cc247c01853_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 384,
      "largeImageURL":
          "https://pixabay.com/get/gb5ef93cd435352f8508804b1a7e7bf969f64db976b5bf0d8a66956f602925a90460992890fe94c645cabc75e8121e71ad7cde71e640451eb66b66ec30d457637_1280.jpg",
      "imageWidth": 6000,
      "imageHeight": 3601,
      "imageSize": 2758033,
      "views": 145121,
      "downloads": 87771,
      "collections": 435,
      "likes": 502,
      "comments": 41,
      "user_id": 2364555,
      "user": "NoName_13",
      "userImageURL":
          "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
    },
    {
      "id": 805124,
      "pageURL":
          "https://pixabay.com/photos/apples-basket-fruits-apple-basket-805124/",
      "type": "photo",
      "tags": "apples, basket, fruits",
      "previewURL":
          "https://cdn.pixabay.com/photo/2015/06/10/19/56/apples-805124_150.jpg",
      "previewWidth": 150,
      "previewHeight": 129,
      "webformatURL":
          "https://pixabay.com/get/gdc587de681b9c994dec7d0c0e4060803db07f295eeb6683839995d7d1f5fec791b97db600fcc76dbc7f24158829818f7_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 553,
      "largeImageURL":
          "https://pixabay.com/get/g895b45199cf7afd38830c652ade159813158418b90d0ee631d7bb059697c43026f5bfb0c7c4dc64ddb68b827590196f1b09fb061a3252cda136522ca4b71ef1d_1280.jpg",
      "imageWidth": 3101,
      "imageHeight": 2683,
      "imageSize": 998659,
      "views": 179000,
      "downloads": 110101,
      "collections": 516,
      "likes": 532,
      "comments": 107,
      "user_id": 1107275,
      "user": "Larisa-K",
      "userImageURL":
          "https://cdn.pixabay.com/user/2015/06/13/06-38-56-116_250x250.jpg"
    },
    {
      "id": 1872997,
      "pageURL":
          "https://pixabay.com/photos/apples-fruits-orchard-nature-trees-1872997/",
      "type": "photo",
      "tags": "apples, fruits, orchard",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/11/30/15/00/apples-1872997_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/gc3691bf602a0d3bb36fb2e94cd1af6f6112d15fe91dc4ace7a469e11bb9d404f35e2a46b6f3bc748c0f687c88f01a4a27fba530c346cce9c46002c30d69b6e37_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/gc0eba3e1b6a392ddaeee5167e5addb59d14e9db1a3355866ee384697fb753746be7780c5a4d772174fffce244ee22c7df793efa7ca4b9ed577e18808a10c186f_1280.jpg",
      "imageWidth": 3504,
      "imageHeight": 2336,
      "imageSize": 2019234,
      "views": 236146,
      "downloads": 151357,
      "collections": 699,
      "likes": 703,
      "comments": 102,
      "user_id": 3890388,
      "user": "lumix2004",
      "userImageURL": ""
    },
    {
      "id": 1702316,
      "pageURL":
          "https://pixabay.com/photos/apple-red-fruit-red-chief-1702316/",
      "type": "photo",
      "tags": "apple, red, fruit",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/09/29/08/33/apple-1702316_150.jpg",
      "previewWidth": 150,
      "previewHeight": 116,
      "webformatURL":
          "https://pixabay.com/get/g853dfb5641827e743501677cb16eba037a5bdf1dc646534efee5999993c03435444c829869812de3c538fe313985bcd94bb717f70e472bc6072e7f9a0c3b3de1_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 495,
      "largeImageURL":
          "https://pixabay.com/get/g1a764dd56870c058ce6d0be46b339c499dc351a850449a8bc4ed50c5b4a4fcaa54da1eaba4eb4fb95c95cc46f4c609adb5cde58b662820414ac842d23ab905b1_1280.jpg",
      "imageWidth": 4000,
      "imageHeight": 3099,
      "imageSize": 1930833,
      "views": 163604,
      "downloads": 108567,
      "collections": 358,
      "likes": 370,
      "comments": 32,
      "user_id": 2364555,
      "user": "NoName_13",
      "userImageURL":
          "https://cdn.pixabay.com/user/2022/12/12/07-40-59-226_250x250.jpg"
    },
    {
      "id": 2391,
      "pageURL":
          "https://pixabay.com/photos/apple-diet-female-food-fresh-2391/",
      "type": "photo",
      "tags": "apple, diet, female",
      "previewURL":
          "https://cdn.pixabay.com/photo/2010/12/13/10/09/apple-2391_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/gbccb1b6010dffda13bed73ce64fe5fb1afe6770ce17d9bd58f0ba31623789fa7ae4d0053b6bdc01e41f35d81e2e5819f_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/g8c15a791dfe7a6a47965ba8458d3f5336298ead79ff821e826e1b0c44f6bddcec139233d74e3031c7445cb7a984549f6_1280.jpg",
      "imageWidth": 4752,
      "imageHeight": 3168,
      "imageSize": 752002,
      "views": 149843,
      "downloads": 99548,
      "collections": 384,
      "likes": 299,
      "comments": 41,
      "user_id": 14,
      "user": "PublicDomainPictures",
      "userImageURL":
          "https://cdn.pixabay.com/user/2012/03/08/00-13-48-597_250x250.jpg"
    },
    {
      "id": 569153,
      "pageURL":
          "https://pixabay.com/photos/home-office-notebook-home-couch-569153/",
      "type": "photo",
      "tags": "home office, notebook, home",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/12/15/14/05/home-office-569153_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/gf0ea5c8e43e3a5deacc43b781a154c0aaa7c48f92cd06da512044a0aa5de4f175bc6a3058421a812b7bab1e9799d70cd_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/g68a0069b40ab9689a1546a19b62fb649b2dfaa4d088aa613615295874627b39edada10042dd59ffecf3a27849ade416e0f4ab1e8af6e69edbaf83cf826c3a775_1280.jpg",
      "imageWidth": 5760,
      "imageHeight": 3840,
      "imageSize": 3991496,
      "views": 365067,
      "downloads": 206139,
      "collections": 683,
      "likes": 499,
      "comments": 90,
      "user_id": 364018,
      "user": "Life-Of-Pix",
      "userImageURL":
          "https://cdn.pixabay.com/user/2014/08/21/23-01-42-554_250x250.jpg"
    },
    {
      "id": 256268,
      "pageURL":
          "https://pixabay.com/photos/apple-red-delicious-fruit-vitamins-256268/",
      "type": "photo",
      "tags": "apple, red, delicious",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/02/01/17/30/apple-256268_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g8ac1dca579f5792ecd612e6a1f275a270b1ca2b57cf7e3cd480e7906bfd02c3858b3dff3e3ae71e8325a14555f10d739_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 423,
      "largeImageURL":
          "https://pixabay.com/get/g913715a7e1af571006361f0d5b49d8ef4ba4fa34243df3697fe45742fbfcccf646f9ac796e44681d3f9a4d77754082ceeba98603f2e3a8fda6c4e34e146ca323_1280.jpg",
      "imageWidth": 4928,
      "imageHeight": 3264,
      "imageSize": 2942037,
      "views": 94956,
      "downloads": 48715,
      "collections": 318,
      "likes": 266,
      "comments": 41,
      "user_id": 143740,
      "user": "jarmoluk",
      "userImageURL":
          "https://cdn.pixabay.com/user/2019/09/18/07-14-26-24_250x250.jpg"
    },
    {
      "id": 1776744,
      "pageURL":
          "https://pixabay.com/photos/apples-leaves-fall-still-life-1776744/",
      "type": "photo",
      "tags": "apples, leaves, fall",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/10/27/22/52/apples-1776744_150.jpg",
      "previewWidth": 150,
      "previewHeight": 100,
      "webformatURL":
          "https://pixabay.com/get/g22585aaed0e9ec9b13bb2fc3072d734e26f5514f75c7f9f3fa1262c8820aefe4a2febe87f15100924ca8623e061708b91d6c1726c3f2fafcb4a169b745c2cebd_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 427,
      "largeImageURL":
          "https://pixabay.com/get/g728678e8ae22e2b1dd4d307a32af1e65409a92c2fcb16d82e265a9652545f7a1950ab3fdc801be4c09b42fd6dcac2d3c1eec1efe01c257ca00c2245b6aa56475_1280.jpg",
      "imageWidth": 4193,
      "imageHeight": 2798,
      "imageSize": 2002268,
      "views": 259150,
      "downloads": 166668,
      "collections": 802,
      "likes": 750,
      "comments": 105,
      "user_id": 2970404,
      "user": "castleguard",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/09/18/22-38-35-578_250x250.jpg"
    },
    {
      "id": 581131,
      "pageURL":
          "https://pixabay.com/photos/office-home-office-creative-apple-581131/",
      "type": "photo",
      "tags": "office, home office, creative",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/12/27/15/40/office-581131_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g0dbb484ea616bd24ccb5a7acdd4a747c02bd03f7dd0e87c58759df9a0a851406264be1309eaedddc673facf2fe2b2da2_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 426,
      "largeImageURL":
          "https://pixabay.com/get/g6ab0b6f6e6026d62c11c49f92596c4fb8cb638fd02dc41fb7bf0bc1369d4907a6c363c07184bfc6485380a1c40ca407995e8b4ee561f20a2fac938a41e112b16_1280.jpg",
      "imageWidth": 5760,
      "imageHeight": 3840,
      "imageSize": 5987170,
      "views": 387295,
      "downloads": 233792,
      "collections": 694,
      "likes": 448,
      "comments": 84,
      "user_id": 670330,
      "user": "markusspiske",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/07/06/12-50-00-288_250x250.jpg"
    }
  ]
}
""";

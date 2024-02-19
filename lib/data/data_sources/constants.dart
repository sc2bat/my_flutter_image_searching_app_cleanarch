// ignore_for_file: constant_identifier_names

import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';

// pixabay api url
const String pixabayApiUrl =
    'https://pixabay.com/api/?key=${Env.pixabayApiKey}&image_type=photo&q=';

const String sampleImageUrl =
    'https://place-hold.it/300x300/666/fff/000?text=sample&fontsize=40';

const String supabaseLoginCallback =
    'io.supabase.flutterquickstart://login-callback/';

// supabase tables
const String TB_VIEW_HISTORY = 'tb_view_history';
const String TB_DOWNLOAD_HISTORY = 'tb_download_history';
const String TB_IMAGE_INFO = 'tb_image_info';
const String TB_LIKE_HISTORY = 'tb_like_history';
const String TB_SHARE_HISTORY = 'tb_share_history';
const String TB_USER_COMMENT = 'tb_user_comment';
const String TB_USER_PROFILE = 'tb_user_profile';

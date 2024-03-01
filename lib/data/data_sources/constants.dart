// ignore_for_file: constant_identifier_names

import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';

// pixabay api url
const String pixabayApiByQuery =
    'https://pixabay.com/api/?key=${Env.pixabayApiKey}&image_type=photo&q=';

const String pixabayApiById =
    'https://pixabay.com/api/?key=${Env.pixabayApiKey}&image_type=photo&id=';

const String sampleUserProfileUrl =
    'https://place-hold.it/60x60/666/fff/000?text=user&fontsize=24';

const String userProfileUrlWithFirstCharacter =
    'https://place-hold.it/60x60/666/fff/000?fontsize=24&text=';

const String sampleImageUrl =
    'https://place-hold.it/300x300/666/fff/000?text=sample&fontsize=40';

const String noneImageUrl =
    'https://place-hold.it/300x300/666/fff/000?text=none&fontsize=40';

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

// supabase function
const String FUNC_GET_POPULAR_IMAGE_COUNT = 'get_popular_image_count';
const String FUNC_GET_TAG_COUNT = 'get_tag_counts';
const String FUNC_GET_IMAGE_COMMENT = 'get_image_comments';
const String FUNC_GET_IMAGE_COUNT_INFO = 'get_image_count_info';
const String FUNC_GET_USER_COMMENTS = 'get_user_comments';
const String FUNC_GET_PAGINATED_USER_COMMENTS = 'get_paginated_user_comments';

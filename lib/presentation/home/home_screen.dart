import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

import '../widget/common/common_text_field_widget.dart';
import '../widget/common/main_logo_text_widget.dart';
import '../widget/common/sign_elevated_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _serachTextFieldController;

  @override
  void initState() {
    Future.microtask(() {
      final homeViewModel = context.read<HomeViewModel>();
      homeViewModel.init();
    });

    _serachTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _serachTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch();
    final HomeState homeState = homeViewModel.homeState;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SignElevatedButtonWidget(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainLogoTextWidget(),
              const SizedBox(
                height: 16.0,
              ),
              CommonTextFieldWidget(
                  serachTextFieldController: _serachTextFieldController),
              const SizedBox(
                height: 32.0,
              ),
              const Text(
                'Top Searches',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 56.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    homeState.topTags.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          logger
                              .info('button press ${homeState.topTags[index]}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          '${homeState.topTags[index]['tag']}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              const Text(
                'Popular Images',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 260.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    homeState.populars.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          logger.info(
                              'popular on tap ${homeState.populars[index]['image_id']}');
                          context.push(
                            '/detail',
                            extra: {
                              'imageId': homeState.populars[index]['image_id'],
                            },
                          );
                        },
                        onDoubleTap: () {
                          logger.info(
                              'popular double tap ${homeState.populars[index]['image_id']}');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                            children: [
                              Image.network(
                                homeState.populars[index]['preview_url'],
                                height: 260.0,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8.0,
                                right: 8.0,
                                child: Container(
                                  width: 80.0,
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    color: weakBlack,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.star_outlined,
                                        color: whiteColor,
                                      ),
                                      Text(
                                        '${homeState.populars[index]['cnt']}',
                                        style:
                                            const TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

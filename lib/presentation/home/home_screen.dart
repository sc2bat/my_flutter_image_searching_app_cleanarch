import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

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

  List<String> topSearches = [
    'apple',
    'orange',
    'fire',
    'water',
    'flower',
    'shoe',
    'cloth'
  ];
  @override
  void initState() {
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
                    topSearches.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          logger.info('button press ${topSearches[index]}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          topSearches[index],
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
                    20,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          sampleImageUrl,
                          height: 260.0,
                          fit: BoxFit.cover,
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

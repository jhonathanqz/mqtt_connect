import 'package:flutter/material.dart';

import 'package:beer_mqtt/shared/style/app_colors.dart';

class Loading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const Loading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Visibility(
            visible: isLoading,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.blurredBackground,
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(AppColors.primaryColorButton),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

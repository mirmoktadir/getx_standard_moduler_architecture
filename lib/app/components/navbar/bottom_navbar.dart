// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_standard/app/modules/home/views/home_view.dart';
import 'package:iconly/iconly.dart';

import '../../modules/Graphql/views/graphql_view.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({Key? key}) : super(key: key);

  List navigation = [
    const HomeView(),
    const GraphQLView(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    void _onTap(int index) {
      _selectedIndex = index;

      (context as Element).markNeedsBuild();
    }

    return Scaffold(
      extendBody: true,
      body: navigation[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            bottom: 35.h,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80.h,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                      color: theme.colorScheme.secondary.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 20.r),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 65.w),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 75.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// ITEM 1
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              _onTap(0);
                            },
                            child: Center(
                              child: Icon(
                                _selectedIndex == 0
                                    ? IconlyBold.home
                                    : IconlyLight.home,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),

                    /// ITEM 2
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              _onTap(1);
                            },
                            child: Center(
                              child: Icon(
                                _selectedIndex == 1
                                    ? IconlyBold.graph
                                    : IconlyLight.graph,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedIndex == 1
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

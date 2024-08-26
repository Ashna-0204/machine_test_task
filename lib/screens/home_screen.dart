import 'package:flutter/material.dart';

import '../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              backgroundColor: whiteColor,
              flexibleSpace: Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/swan_logo.png',
                        height: 30,
                      ),
                    ),

                    const Row(
                      children: [

                         Icon(
                          Icons.search_outlined,
                          size: 25,
                          color: blackColor,
                        ),
                         SizedBox(width: 8),

                         Icon(
                          Icons.favorite_border,
                          size: 25,
                          color: blackColor,
                        ),
                         SizedBox(width: 8),
                         Icon(
                          Icons.notifications_none_outlined,
                          size: 25,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        )
    );
  }
}

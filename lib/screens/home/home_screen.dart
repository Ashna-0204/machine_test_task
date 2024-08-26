import 'package:assignment_allisons/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../api_services/api_service.dart';
import '../../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<HomeModel> futureHomeData;

  @override
  void initState() {
    super.initState();
    futureHomeData = ApiService.fetchHomeData();
  }

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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/banner2.jpg',
                  width: double.infinity,
                ),

                const SizedBox(height: 12),

                //brands
                const Padding(
                  padding:  EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Brands',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: blackColor
                        ),
                      ),

                      Text(
                        'View All',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                //products
                const Padding(
                  padding:  EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: blackColor
                        ),
                      ),

                      Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ourProductList(),

                const SizedBox(height: 15),
                //suggestions
                const Padding(
                  padding:  EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suggested For You',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: blackColor
                        ),
                      ),

                      Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                suggestedProductList(),

                const SizedBox(height: 14),
                Image.asset('assets/images/new_arrival.png'),
                const SizedBox(height: 8),
                newArrivalList(),

                const SizedBox(height: 15),
                //best seller list
                const Padding(
                  padding:  EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Sellers',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: blackColor
                        ),
                      ),

                      Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                bestSellerList()
              ],
            ),
          ),
        )
    );
  }

  Widget ourProductList(){
    return FutureBuilder<HomeModel>(
      future: futureHomeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.ourProducts!.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                  child: Text('No Data found')
              )
          );
        } else {
          final item = snapshot.data!.ourProducts ?? [];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 15),
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.length - 1,
                itemBuilder: (context, index) => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://swan.alisonsnewdemo.online/images/product/'+ '${item[index + 1].image}',
                                height: 150,
                              ),
                              const Positioned(
                                top: 8.0,  // Adjust the value as needed
                                right: 8.0,
                                child: Icon(
                                    Icons.favorite_border,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                            '${item[index + 1].name}',
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'OMR'+'${item[index + 1].price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: blackColor
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget suggestedProductList(){
    return FutureBuilder<HomeModel>(
      future: futureHomeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.suggestedProducts!.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                  child: Text('No Data found')
              )
          );
        } else {
          final item = snapshot.data!.suggestedProducts ?? [];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 15),
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://swan.alisonsnewdemo.online/images/product/'+ '${item[index].image}',
                                height: 150,
                              ),
                              const Positioned(
                                top: 8.0,  // Adjust the value as needed
                                right: 8.0,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.left,
                            '${item[index].name}',
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'OMR'+'${item[index].price}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: blackColor
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget bestSellerList(){
    return FutureBuilder<HomeModel>(
      future: futureHomeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.bestSeller!.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                  child: Text('No Data found')
              )
          );
        } else {
          final item = snapshot.data!.bestSeller ?? [];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 15),
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://swan.alisonsnewdemo.online/images/product/'+ '${item[index].image}',
                                height: 150,
                              ),
                              const Positioned(
                                top: 8.0,  // Adjust the value as needed
                                right: 8.0,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${item[index].name}',
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'OMR'+'${item[index].price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: blackColor
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget newArrivalList(){
    return FutureBuilder<HomeModel>(
      future: futureHomeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.bestSeller!.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                  child: Text('No Data found')
              )
          );
        } else {
          final item = snapshot.data!.bestSeller ?? [];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 15),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: item.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              'https://swan.alisonsnewdemo.online/images/product/'+
                              '${item[index].image}'),
                        ),
                        const Positioned(
                          top: 8.0,  // Adjust the value as needed
                          right: 8.0,
                          child: Icon(
                            Icons.favorite_border,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${item[index].name}'
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'OMR'+'${item[index].price}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: blackColor
                      ),
                    )
                  ],
                ),
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
          );
        }
      },
    );
  }
}

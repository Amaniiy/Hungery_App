import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/features/home/ui/widgets/card_item.dart';
import 'package:sonic_app/features/home/ui/widgets/categorys.dart';
import 'package:sonic_app/features/home/ui/widgets/header.dart';
import 'package:sonic_app/features/home/ui/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categories = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 190,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 40, left: 15, right: 15),
                child: Column(children: [Header(), SearchItem()]),
              ),
              elevation: 0,
              scrolledUnderElevation: 0,
              pinned: true,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CategoryItem(
                  categories: categories,
                  selectedIndex: selectedIndex,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CardItem(
                    image: 'assets/images/card.png',
                    text: 'Cheese Burger\n Wendy\'s Burger',
                    desc: 'With cheddar cheese',
                    rate: '4.9',
                  );
                }, childCount: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  childAspectRatio: 0.53,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

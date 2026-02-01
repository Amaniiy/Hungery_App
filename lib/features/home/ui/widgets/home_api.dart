/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sonic_app/features/home/data/product_model.dart';
import 'package:sonic_app/features/home/data/product_repo.dart';
import 'package:sonic_app/features/home/ui/widgets/card_item.dart';
import 'package:sonic_app/features/home/ui/widgets/categorys.dart';
import 'package:sonic_app/features/home/ui/widgets/header.dart';
import 'package:sonic_app/features/home/ui/widgets/search.dart';
import 'package:sonic_app/features/products/ui/product.dart';
*/

// تعريف الشاشة الرئيسية HomeScreenApi
/*
class HomeScreenApi extends StatefulWidget {
  const HomeScreenApi({super.key});

  @override
  State<HomeScreenApi> createState() => _HomeScreenState();
}
*/

// تعريف حالة الشاشة _HomeScreenState
/*
class _HomeScreenState extends State<HomeScreenApi> {
  List categories = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;

  // API
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();

  Future<void> getProducts() async {
    final res = await productRepo.getProducts();
    setState(() {
      products = res; 
    });
  }
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  ////////////////////
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // عند الضغط خارج عناصر الشاشة، يتم اخفاء لوحة المفاتيح
      onTap: () => FocusScope.of(context).unfocus(),

      // استخدام Skeletonizer لعرض تأثير التحميل
      child: Skeletonizer(
        //enabled: products == null,
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

              // عرض الفئات
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CategoryItem(
                    categories: categories,
                    selectedIndex: selectedIndex,
                  ),
                ),
              ),

              // عرض المنتجات في شبكة
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    // جلب المنتج الحالي
                    final product = products![index];

                    // إذا كانت البيانات لم تأتي بعد، عرض مؤشر التحميل
                    if (products == null) {
                      return CupertinoActivityIndicator();
                    }

                    return GestureDetector(
                      // عند الضغط على المنتج، الانتقال لتفاصيل المنتج
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetails(),
                          ),
                        );
                      },

                      // عرض المنتج باستخدام CardItem
                      child: CardItem(
                        image: product.image,
                        text: product.name,
                        desc: product.desc,
                        rate: product.rate.toString(),
                      ),
                    );
                  }, childCount: products?.length ?? 6), // عدد العناصر
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عدد الأعمدة في الشبكة
                    childAspectRatio: 0.53, // نسبة عرض/ارتفاع البطاقة
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
*/

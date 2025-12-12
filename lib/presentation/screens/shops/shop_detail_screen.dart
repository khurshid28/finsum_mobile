import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class ShopDetailScreen extends StatefulWidget {
  final Map<String, dynamic> shop;

  const ShopDetailScreen({super.key, required this.shop});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  String _selectedCategory = 'Barchasi';
  String _searchQuery = '';

  final List<String> _categories = [
    'Barchasi',
    'Smartfonlar',
    'Noutbuklar',
    'Planshetlar',
    'Televizorlar',
    'Muzlatgichlar',
    'Kir yuvish mashinalari',
    'Konditsionerlar',
    'Mikroto\'lqinli pechlar',
  ];

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _branches = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _generateProducts();
    _generateBranches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _generateBranches() {
    final districts = [
      'Yunusobod',
      'Chilonzor',
      'Sergeli',
      'Yakkasaroy',
      'Mirzo Ulug\'bek',
      'Shayxontohur',
      'Mirobod',
      'Olmazor',
      'Bektemir',
      'Yashnobod',
    ];

    final streets = [
      'Amir Temur',
      'Bunyodkor',
      'Mustaqillik',
      'Yangi Sergeli',
      'Lutfiy',
      'Bobur',
      'Kichik Halqa',
      'Qoratosh',
    ];

    _branches = List.generate(
      widget.shop['branchesCount'] ?? 15,
      (index) => {
        'id': '${index + 1}',
        'name': 'Filial №${index + 1}',
        'address':
            '${districts[index % districts.length]} tumani, ${streets[index % streets.length]} ko\'chasi ${10 + index * 2}',
        'phone':
            '+998 71 ${200 + index} ${(index * 11) % 100} ${(index * 13) % 100}',
        'workTime': index % 3 == 0 ? '09:00 - 20:00' : '10:00 - 21:00',
        'isOpen': index % 5 != 0,
      },
    );
  }

  void _generateProducts() {
    final categories = [
      'Smartfonlar',
      'Noutbuklar',
      'Planshetlar',
      'Televizorlar',
      'Muzlatgichlar',
      'Kir yuvish mashinalari',
      'Konditsionerlar',
      'Mikroto\'lqinli pechlar',
    ];

    final brands = [
      'Samsung',
      'LG',
      'Artel',
      'Apple',
      'Xiaomi',
      'Shivaki',
      'Haier'
    ];

    final categoryImages = {
      'Smartfonlar':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
      'Noutbuklar':
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
      'Planshetlar':
          'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=400',
      'Televizorlar':
          'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400',
      'Muzlatgichlar':
          'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400',
      'Kir yuvish mashinalari':
          'https://images.unsplash.com/photo-1626806819282-2c1dc01a5e0c?w=400',
      'Konditsionerlar':
          'https://images.unsplash.com/photo-1631545806609-7e0b03ad4a0c?w=400',
      'Mikroto\'lqinli pechlar':
          'https://images.unsplash.com/photo-1585659722983-3a675dabf23d?w=400',
    };

    for (int i = 1; i <= 240; i++) {
      final category = categories[i % categories.length];
      final brand = brands[i % brands.length];

      _products.add({
        'id': '$i',
        'name': '$brand $category ${i % 20 + 1}',
        'category': category,
        'price': (i * 100000) + (i % 10) * 50000,
        'monthlyPrice': ((i * 100000) + (i % 10) * 50000) ~/ 12,
        'image': categoryImages[category] ??
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        'rating': 4.0 + (i % 10) / 10,
        'inStock': i % 5 != 0,
      });
    }
  }

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      final matchesCategory = _selectedCategory == 'Barchasi' ||
          product['category'] == _selectedCategory;
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return '${formatter.format(amount)} so\'m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.shop['name']),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/svg/chevron-right.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Mahsulotlar'),
                Tab(text: 'Filiallar'),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsTab(),
                _buildBranchesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: EdgeInsets.all(16.w),
          color: Colors.white,
          child: FadeInDown(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                decoration: InputDecoration(
                  hintText: 'Mahsulot qidirish...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/icons/svg/search.svg',
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/svg/delete.svg',
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              AppColors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Categories
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          height: 68.h,
          child: FadeInLeft(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return InkWell(
                  onTap: () {
                    setState(() => _selectedCategory = category);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : AppColors.background,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Products Count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_filteredProducts.length} ta mahsulot topildi',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Products Grid
        Expanded(
          child: _filteredProducts.isEmpty
              ? _buildEmptyState()
              : GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      delay: Duration(milliseconds: index * 50),
                      child: _buildProductCard(_filteredProducts[index]),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/svg/search.svg',
            width: 100.w,
            height: 100.h,
            colorFilter: ColorFilter.mode(
              AppColors.textSecondary.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Hech narsa topilmadi',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Qidiruv so\'rovini o\'zgartiring',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final bool inStock = product['inStock'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              Container(
                height: 140.h,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 60.sp,
                    color: AppColors.textSecondary.withOpacity(0.3),
                  ),
                ),
              ),
              // Stock Badge
              if (!inStock)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Tugagan',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // Rating
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/star.svg',
                        width: 12.w,
                        height: 12.h,
                        colorFilter: ColorFilter.mode(
                          Colors.amber,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        product['rating'].toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Product Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product['category'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatMoney(product['price']),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        'Oyiga: ',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        _formatMoney(product['monthlyPrice']),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchesTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _branches.length,
      itemBuilder: (context, index) {
        final branch = _branches[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        branch['name'],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: branch['isOpen']
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        branch['isOpen'] ? 'Ochiq' : 'Yopiq',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: branch['isOpen']
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/location.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        branch['address'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/phone.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      branch['phone'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/clock.svg',
                      width: 18.w,
                      height: 18.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      branch['workTime'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

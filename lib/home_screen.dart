import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Campus Vibrant Modern - Color System
class AppColors {
  static const Color primary = Color(0xFFFF5A26); // Signature electric coral
  static const Color primaryDark = Color(0xFFB02F00); // Deep brand coral
  static const Color secondary = Color(0xFFFFA114); // Warm amber
  static const Color secondaryDark = Color(0xFF875200);
  static const Color neutralPrimary = Color(0xFF1A1A1A); // Deep charcoal
  static const Color neutralSecondary = Color(0xFF6E7682); // Slate gray
  static const Color surfaceCanvas = Color(0xFFFCF9F8); // Gentle low-glare backdrop
  static const Color surfaceLayer = Color(0xFFFFFFFF); // Pure white card surface
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color surfaceContainer = Color(0xFFF0EDED);
  static const Color border = Color(0xFFF0F2F5);
  static const Color borderDivider = Color(0xFFEAEAEA);
  static const Color badgeCoralBg = Color(0xFFFFECE5);
  static const Color error = Color(0xFFBA1A1A);
}

/// Data model for category filters
class CategoryItem {
  final String title;
  final String emoji;
  final IconData? icon;

  const CategoryItem({
    required this.title,
    this.emoji = '',
    this.icon,
  });
}

/// Data model for restaurant entries
class RestaurantItem {
  final String id;
  final String name;
  final String campusHub;
  final String cuisines;
  final String deliveryTime;
  final String deliveryFee;
  final String highlightText;
  final bool highlightIsPrimary;
  final double rating;
  final String reviewsCount;
  final String promoBadgeText;
  final Color promoBadgeBg;
  final Color promoBadgeTextColor;
  final IconData? promoBadgeIcon;
  final bool isFavorite;

  const RestaurantItem({
    required this.id,
    required this.name,
    required this.campusHub,
    required this.cuisines,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.highlightText,
    this.highlightIsPrimary = false,
    required this.rating,
    required this.reviewsCount,
    required this.promoBadgeText,
    required this.promoBadgeBg,
    required this.promoBadgeTextColor,
    this.promoBadgeIcon,
    this.isFavorite = false,
  });

  RestaurantItem copyWith({bool? isFavorite}) {
    return RestaurantItem(
      id: id,
      name: name,
      campusHub: campusHub,
      cuisines: cuisines,
      deliveryTime: deliveryTime,
      deliveryFee: deliveryFee,
      highlightText: highlightText,
      highlightIsPrimary: highlightIsPrimary,
      rating: rating,
      reviewsCount: reviewsCount,
      promoBadgeText: promoBadgeText,
      promoBadgeBg: promoBadgeBg,
      promoBadgeTextColor: promoBadgeTextColor,
      promoBadgeIcon: promoBadgeIcon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _bottomNavIndex = 0;

  final List<CategoryItem> _categories = const [
    CategoryItem(title: 'All', icon: Icons.lunch_dining_rounded),
    CategoryItem(title: 'Burgers', emoji: '🍔'),
    CategoryItem(title: 'Pizza', emoji: '🍕'),
    CategoryItem(title: 'Chicken', emoji: '🍗'),
    CategoryItem(title: 'Drinks', emoji: '🥤'),
    CategoryItem(title: 'Local', emoji: '🍲'),
  ];

  late List<RestaurantItem> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = [
      const RestaurantItem(
        id: '1',
        name: 'Chicken Republic',
        campusHub: 'Faculty Hub',
        cuisines: 'Fast Food • Local Delights • Chicken',
        deliveryTime: '25–35 min',
        deliveryFee: '₦500 delivery',
        highlightText: 'Free over ₦3,000',
        highlightIsPrimary: true,
        rating: 4.7,
        reviewsCount: '1.2k+',
        promoBadgeText: 'Free delivery',
        promoBadgeBg: AppColors.primary,
        promoBadgeTextColor: Colors.white,
        promoBadgeIcon: Icons.two_wheeler_rounded,
        isFavorite: false,
      ),
      const RestaurantItem(
        id: '2',
        name: 'Campus Crust Pizza',
        campusHub: 'New Hall Walk',
        cuisines: 'Italian • Pizza • Wings',
        deliveryTime: '20–30 min',
        deliveryFee: '₦400 delivery',
        highlightText: '₦1,500 min order',
        highlightIsPrimary: false,
        rating: 4.8,
        reviewsCount: '850',
        promoBadgeText: 'Popular with Hall 3',
        promoBadgeBg: Colors.white,
        promoBadgeTextColor: AppColors.neutralPrimary,
        promoBadgeIcon: Icons.local_fire_department_rounded,
        isFavorite: false,
      ),
      const RestaurantItem(
        id: '3',
        name: 'Mama Put Express',
        campusHub: 'Sub Center',
        cuisines: 'Nigerian • Jollof • Suya',
        deliveryTime: '15–25 min',
        deliveryFee: '₦350 delivery',
        highlightText: 'Top Rated',
        highlightIsPrimary: true,
        rating: 4.9,
        reviewsCount: '2.4k',
        promoBadgeText: 'Fastest Campus Drop',
        promoBadgeBg: AppColors.secondary,
        promoBadgeTextColor: AppColors.neutralPrimary,
        promoBadgeIcon: Icons.bolt_rounded,
        isFavorite: false,
      ),
    ];
  }

  void _toggleFavorite(int index) {
    setState(() {
      _restaurants[index] = _restaurants[index].copyWith(
        isFavorite: !_restaurants[index].isFavorite,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildGreetingHeader(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildPromoBanner(),
            const SizedBox(height: 24),
            _buildCategoriesSection(),
            const SizedBox(height: 24),
            _buildPopularSectionHeader(),
            const SizedBox(height: 12),
            _buildPopularList(),
            const SizedBox(height: 8),
            _buildGroupOrderBanner(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// 1. Top App Bar with brand logo, campus indicator, bag icon & profile avatar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surfaceCanvas,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          // CampusEats Brand Icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          // Brand Title and Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CampusEats',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neutralPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Explore Campus',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Shopping bag icon with indicator badge
        IconButton(
          onPressed: () {},
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.neutralPrimary,
                size: 26,
              ),
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        // User Profile Avatar (Placeholder)
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _buildAvatarPlaceholder(),
        ),
      ],
    );
  }

  /// 2. User Avatar Placeholder
  Widget _buildAvatarPlaceholder() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceContainer,
        border: Border.all(color: AppColors.borderDivider, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      // TODO: Replace with Image.asset('assets/avatar.png') or Image.network(...)
      child: const Icon(
        Icons.person_rounded,
        size: 24,
        color: AppColors.neutralSecondary,
      ),
    );
  }

  /// 3. Greeting Header with User name, location indicator and bell notification
  Widget _buildGreetingHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good afternoon, Bashir 👋',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.neutralPrimary,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Faculty of Science, North Gate',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4A4A4A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xFF4A4A4A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Notification Bell Button with badge '2'
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.neutralPrimary,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 4. Search and Filter Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Search Input Container
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceLayer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutralPrimary.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.neutralSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'What are you craving?',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutralSecondary,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceLayer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutralPrimary.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.tune_rounded,
                color: AppColors.neutralPrimary,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  /// 5. Student Exclusive Promo Banner
  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE24312),
              Color(0xFF8F1D00),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Text & Button Column
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Student Exclusive Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          color: Colors.white,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'STUDENT EXCLUSIVE',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Offer headline
                  Text(
                    '20% OFF first 3 orders',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Promo code
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(text: 'Use code '),
                        TextSpan(
                          text: 'CAMPUS20',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: ' at\ncheckout'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Claim Deal Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryDark,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    child: Text(
                      'Claim Deal',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Right Side Meal Box Image Placeholder
            Expanded(
              flex: 9,
              child: _buildPromoImagePlaceholder(),
            ),
          ],
        ),
      ),
    );
  }

  /// 6. Banner Meal Box Image Placeholder
  Widget _buildPromoImagePlaceholder() {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      // TODO: Replace with Image.asset('assets/promo_box.png') or Image.network(...)
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.takeout_dining_rounded,
                color: Colors.white.withValues(alpha: 0.85),
                size: 38,
              ),
              const SizedBox(height: 6),
              Text(
                'Meal Box',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '[Image Placeholder]',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 7. Categories Section with header and horizontal chips
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Categories',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutralPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                'Swipe for more',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Horizontal Scrollable Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(_categories.length, (index) {
              final category = _categories[index];
              final isSelected = _selectedCategoryIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _buildCategoryChip(
                  category: category,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  /// 8. Single Category Chip
  Widget _buildCategoryChip({
    required CategoryItem category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neutralPrimary : AppColors.surfaceLayer,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: isSelected ? AppColors.neutralPrimary : AppColors.borderDivider,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neutralPrimary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.icon != null) ...[
              Icon(
                category.icon,
                size: 16,
                color: isSelected ? Colors.white : AppColors.neutralPrimary,
              ),
              const SizedBox(width: 6),
            ] else if (category.emoji.isNotEmpty) ...[
              Text(
                category.emoji,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              category.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.neutralPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 9. "Popular Near You" Section Header
  Widget _buildPopularSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Popular Near You',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutralPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7E6D7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.secondaryDark,
                  size: 16,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                'See All',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 10. Popular Restaurants List
  Widget _buildPopularList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = _restaurants[index];
        return _buildRestaurantCard(
          restaurant: restaurant,
          onFavoriteToggle: () => _toggleFavorite(index),
        );
      },
    );
  }

  /// 11. Restaurant Card
  Widget _buildRestaurantCard({
    required RestaurantItem restaurant,
    required VoidCallback onFavoriteToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLayer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralPrimary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Cover with Overlaid Badges
          Stack(
            children: [
              // Image Placeholder Area
              _buildRestaurantImagePlaceholder(restaurant.name),
              // Overlaid Top-Left: Rating Badge
              Positioned(
                top: 12,
                left: 12,
                child: _buildRatingBadge(
                  rating: restaurant.rating,
                  reviewsCount: restaurant.reviewsCount,
                ),
              ),
              // Overlaid Top-Right: Favorite Button
              Positioned(
                top: 12,
                right: 12,
                child: _buildFavoriteButton(
                  isFavorite: restaurant.isFavorite,
                  onTap: onFavoriteToggle,
                ),
              ),
              // Overlaid Bottom-Left: Feature/Promo Badge
              Positioned(
                bottom: 12,
                left: 12,
                child: _buildPromoTagBadge(
                  text: restaurant.promoBadgeText,
                  backgroundColor: restaurant.promoBadgeBg,
                  textColor: restaurant.promoBadgeTextColor,
                  icon: restaurant.promoBadgeIcon,
                ),
              ),
            ],
          ),
          // Bottom Information Container
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Campus Hub Tag Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        restaurant.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.neutralPrimary,
                          letterSpacing: -0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        restaurant.campusHub,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5B4039),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Cuisine tags
                Text(
                  restaurant.cuisines,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutralSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                // Delivery time, fee and highlight text
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.neutralSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.deliveryTime,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutralSecondary,
                      ),
                    ),
                    _buildDotSeparator(),
                    Text(
                      restaurant.deliveryFee,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutralSecondary,
                      ),
                    ),
                    _buildDotSeparator(),
                    Text(
                      restaurant.highlightText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: restaurant.highlightIsPrimary
                            ? AppColors.primary
                            : AppColors.neutralSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 12. Restaurant Image Placeholder
  Widget _buildRestaurantImagePlaceholder(String restaurantName) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        height: 175,
        width: double.infinity,
        color: AppColors.surfaceContainer,
        // TODO: Replace this placeholder container with Image.asset(...) or Image.network(...)
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    color: AppColors.neutralSecondary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$restaurantName Photo',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutralSecondary,
                  ),
                ),
                Text(
                  '[Replace with Image]',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.neutralSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 13. Rating Badge overlaid on card
  Widget _buildRatingBadge({
    required double rating,
    required String reviewsCount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.secondary,
            size: 15,
          ),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.neutralPrimary,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            '($reviewsCount)',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.neutralSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// 14. Favorite Heart Button
  Widget _buildFavoriteButton({
    required bool isFavorite,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9999),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isFavorite ? AppColors.error : AppColors.neutralPrimary,
          size: 19,
        ),
      ),
    );
  }

  /// 15. Overlaid Promo Tag Badge
  Widget _buildPromoTagBadge({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: textColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 16. Group Order Card Banner
  Widget _buildGroupOrderBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDivider),
        ),
        child: Row(
          children: [
            // Left Group Order Icon in soft tint circle
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.badgeCoralBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group Order with Coursemates',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutralPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Split the delivery fee automatically',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.neutralSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Circular forward arrow button
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.neutralPrimary,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 17. Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLayer,
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                index: 0,
                icon: Icons.restaurant_rounded,
                label: 'Home',
              ),
              _buildBottomNavItem(
                index: 1,
                icon: Icons.search_rounded,
                label: 'Search',
              ),
              _buildBottomNavItem(
                index: 2,
                icon: Icons.receipt_long_rounded,
                label: 'Orders',
                badgeCount: 2,
              ),
              _buildBottomNavItem(
                index: 3,
                icon: Icons.person_outline_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 18. Single Bottom Nav Item
  Widget _buildBottomNavItem({
    required int index,
    required IconData icon,
    required String label,
    int? badgeCount,
  }) {
    final isSelected = _bottomNavIndex == index;
    final color = isSelected ? AppColors.primary : AppColors.neutralSecondary;

    return InkWell(
      onTap: () {
        setState(() {
          _bottomNavIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                if (badgeCount != null)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Center(
                        child: Text(
                          '$badgeCount',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Utility Dot Separator for meta row
  Widget _buildDotSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '•',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          color: const Color(0xFFA0A0A0),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart'; // Update import path as needed

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Sample wishlist data
  List<Map<String, dynamic>> wishlistBooks = [
    {
      "title": "Harry Potter and the Deathly Hallows",
      "imageUrl": "https://example.com/hp_deathly_hallows.jpg",
      "rating": 4.9,
      "price": 9.99,
    },
    {
      "title": "The Lost Metal: A Mistborn Novel by Brandon Sanderson",
      "imageUrl": "https://example.com/the_lost_metal.jpg",
      "rating": 4.8,
      "price": 4.99,
    },
    {
      "title": "The Most Powerful Quotes: 400 Motivational Quotes and Sayings",
      "imageUrl": "https://example.com/most_powerful_quotes.jpg",
      "rating": 4.9,
      "price": 2.50,
    },
    {
      "title": "Free Life Fantasy Online: Immortal Princess (Light Novel) Vol. 2",
      "imageUrl": "https://example.com/free_life_fantasy.jpg",
      "rating": 4.7,
      "price": 4.99,
    },
    {
      "title": "Harry Potter and the Prisoner of Azkaban",
      "imageUrl": "https://example.com/hp_prisoner_azkaban.jpg",
      "rating": 4.7,
      "price": 7.99,
    },
  ];

  void _showBookMenu(int index) async {
    final selectedAction = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBottomSheetAction(
                  icon: Icons.delete_outline,
                  label: 'Remove from Wishlist',
                  onTap: () {
                    Navigator.pop(context, 'remove');
                  },
                ),
                const SizedBox(height: 16),
                _buildBottomSheetAction(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: () {
                    Navigator.pop(context, 'share');
                  },
                ),
                const SizedBox(height: 16),
                _buildBottomSheetAction(
                  icon: Icons.info_outline_rounded,
                  label: 'About Ebook',
                  onTap: () {
                    Navigator.pop(context, 'about');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedAction == 'remove') {
      setState(() {
        wishlistBooks.removeAt(index);
      });
    } else if (selectedAction == 'share') {
      // Implement share logic
    } else if (selectedAction == 'about') {
      // Implement about logic
    }
  }

  Widget _buildBottomSheetAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final appBarHeight = kToolbarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      // If you have a bottom nav bar in your main app, you can remove it here or integrate as needed.
      // bottomNavigationBar: BottomNavigationBar(...),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: isDesktop ? 24.0 : 16.0,
        leading: Padding(
          padding: EdgeInsets.only(left: isDesktop ? 24.0 : 16.0),
          child: Icon(Icons.menu_book, color: AppColors.primary, size: 28),
        ),
        title: Text(
          'Wishlist',
          style: GoogleFonts.urbanist(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () {
              // Implement filter functionality
            },
          ),
          SizedBox(width: isDesktop ? 24 : 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24.0 : 16.0,
          vertical: isDesktop ? 24.0 : 16.0,
        ),
        child: ListView.separated(
          itemCount: wishlistBooks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final book = wishlistBooks[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book["imageUrl"],
                    width: isDesktop ? 120 : 80,
                    height: isDesktop ? 180 : 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      width: isDesktop ? 120 : 80,
                      height: isDesktop ? 180 : 120,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book title
                      Text(
                        book["title"],
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            book["rating"].toStringAsFixed(1),
                            style: GoogleFonts.urbanist(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Price
                      Text(
                        "\$${book["price"].toStringAsFixed(2)}",
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black87),
                  onPressed: () => _showBookMenu(index),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

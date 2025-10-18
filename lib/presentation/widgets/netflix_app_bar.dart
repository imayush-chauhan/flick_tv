import 'package:flick_tv/main.dart';
import 'package:flutter/material.dart';

class FlickTvAppBar extends StatelessWidget {
  const FlickTvAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Text(
              'FlickTv',
              style: TextStyle(
                color: Color(0xFFE50914),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const Spacer(),
            if (!isMobile) ...[
              _NavButton('Home', isActive: true),
              _NavButton('TV Shows'),
              _NavButton('Movies'),
              _NavButton('New & Popular'),
              _NavButton('My List'),
              const SizedBox(width: 20),
            ],
            IconButton(
              icon: const Icon(Icons.search, size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications, size: 28),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE50914),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  'U',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final bool isActive;

  const _NavButton(this.text, {this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[400],
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
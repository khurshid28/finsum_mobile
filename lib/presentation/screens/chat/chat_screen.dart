import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import 'chat_history_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'Qo\'llab-quvvatlash',
      'lastMessage': 'Sizga qanday yordam bera olamiz?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
      'unreadCount': 2,
      'isOnline': true,
      'avatar': 'S',
    },
    {
      'id': '2',
      'name': 'Artel',
      'lastMessage': 'Mahsulotingiz haqida savol',
      'time': DateTime.now().subtract(const Duration(hours: 1)),
      'unreadCount': 0,
      'isOnline': true,
      'avatar': 'A',
    },
    {
      'id': '3',
      'name': 'Samsung',
      'lastMessage': 'Rahmat, juda yaxshi xizmat',
      'time': DateTime.now().subtract(const Duration(hours: 3)),
      'unreadCount': 0,
      'isOnline': false,
      'avatar': 'S',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(time);
    } else if (difference.inDays == 1) {
      return 'Kecha';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE', 'uz_UZ').format(time);
    } else {
      return DateFormat('dd.MM.yyyy').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/history.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _chats.isEmpty ? _buildEmptyState() : _buildChatList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/svg/chat.svg',
            width: 100.w,
            height: 100.h,
            colorFilter: ColorFilter.mode(
              AppColors.textSecondary.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Hali chat yo\'q',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Yangi chat boshlang',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildChatItem(_chats[index]),
        );
      },
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    final hasUnread = chat['unreadCount'] > 0;
    final isOnline = chat['isOnline'];

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: ListTile(
        contentPadding: EdgeInsets.all(12.w),
        leading: Stack(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  chat['avatar'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          chat['name'],
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          chat['lastMessage'],
          style: TextStyle(
            fontSize: 14.sp,
            color: hasUnread ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: hasUnread ? FontWeight.w500 : FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatTime(chat['time']),
              style: TextStyle(
                fontSize: 12.sp,
                color: hasUnread ? AppColors.primary : AppColors.textSecondary,
                fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (hasUnread) ...[
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat['unreadCount'].toString(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          // Open chat detail
        },
      ),
    );
  }
}

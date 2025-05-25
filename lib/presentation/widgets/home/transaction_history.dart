// This should represent the transaction history
import 'package:flutter/material.dart';
import 'package:libra_ui/domain/data/home/activity/activities.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    super.key,
    this.activities = fakeActivities,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });
  final List<Map<String, dynamic>> activities;
  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _TransactionTile(
          cardBackgroundColor: cardBackgroundColor,
          activity: activity,
          accentColorTeal: accentColorTeal,
          primaryTextColor: primaryTextColor,
          secondaryTextColor: secondaryTextColor,
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.cardBackgroundColor,
    required this.activity,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final Color cardBackgroundColor;
  final Map<String, dynamic> activity;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // ignore: deprecated_member_use
        backgroundColor: cardBackgroundColor.withOpacity(0.9),
        child: Icon(
          activity['icon'] as IconData,
          color: accentColorTeal,
          size: 20,
        ),
      ),
      title: Text(
        activity['name'] as String,
        style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        activity['type'] as String,
        style: TextStyle(color: secondaryTextColor, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            activity['amount'] as String,
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            activity['date'] as String,
            style: TextStyle(color: secondaryTextColor, fontSize: 10),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }
}

import 'package:flutter/material.dart';

class Activity {
  final IconData icon;
  final String name;
  final String type;
  final String amount;
  final String date;

  const Activity({
    required this.icon,
    required this.name,
    required this.type,
    required this.amount,
    required this.date,
  });
}

const fakeActivities = <Activity>[
  Activity(
    icon: Icons.shopping_cart_outlined,
    name: 'Amazon',
    type: 'Purchase',
    amount: '-USD 30.50',
    date: '02/05/2025',
  ),
  Activity(
    icon: Icons.directions_car_filled_outlined,
    name: 'Cabify',
    type: 'Purchase',
    amount: '-USD 115.00',
    date: '01/05/2025',
  ),
  Activity(
    icon: Icons.receipt_long_outlined,
    name: 'Gas Bill',
    type: 'Bill Payment',
    amount: '-USD 75.80',
    date: '30/04/2025',
  ),
  const Activity(
    icon: Icons.fastfood_outlined,
    name: 'Restaurant',
    type: 'Purchase',
    amount: '-USD 42.00',
    date: '29/04/2025',
  ),
  Activity(
    icon: Icons.movie_outlined,
    name: 'Cinema Ticket',
    type: 'Entertainment',
    amount: '-USD 15.00',
    date: '28/04/2025',
  ),
];

import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_chart.dart';
import 'package:mazraaty/Features/history/presentation/views/widgets/history_pie_chart.dart';
import 'package:mazraaty/constants.dart';

class HistoryChartsView extends StatefulWidget {
  final List<HistoryDisease> diseases;

  const HistoryChartsView({super.key, required this.diseases});

  @override
  State<HistoryChartsView> createState() => _HistoryChartsViewState();
}

class _HistoryChartsViewState extends State<HistoryChartsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom tab bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kMainColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: kMainColor,
            labelStyle: Styles.textStyle15.copyWith(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Bar Chart'),
              Tab(text: 'Pie Chart'),
            ],
          ),
        ),
        
        // Tab content with animated transition
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.1, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _tabController.index == 0
                ? HistoryChart(key: const ValueKey('bar'), diseases: widget.diseases)
                : HistoryPieChart(key: const ValueKey('pie'), diseases: widget.diseases),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrainTimelineTile extends StatelessWidget {
  final bool isFirst;
  final Widget endchild;
  final bool isLast;
  final bool isPast;
  final bool isLeft;
  final int idx;

  const TrainTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.endchild,
    required this.isPast,
    required this.isLeft,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: false,
        isLast: false,
        indicatorStyle: IndicatorStyle(
          color: isPast ? Colors.green : Colors.green.shade100,
          width: 40,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isPast ? Colors.yellow.shade300 : Colors.green.shade100,
          ),
        ),
        afterLineStyle: LineStyle(
            color: isPast && (isLeft || idx != 1)
                ? Colors.green
                : Colors.green.shade100),
        beforeLineStyle:
            LineStyle(color: isPast ? Colors.green : Colors.green.shade100),
        alignment: TimelineAlign.start,
        endChild: endchild,
      ),
    );
  }
}

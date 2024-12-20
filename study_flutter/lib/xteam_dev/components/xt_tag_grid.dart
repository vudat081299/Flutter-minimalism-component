import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/xt_color_tag.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';

class XtTagGrid extends StatelessWidget {
  const XtTagGrid({
    super.key,
    this.data = const [],
  });

  final List<XtTagModel> data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: data.map((item) {
        return XtColorTag(
          color: item.color,
          onPressed: item.onPressed,
          child: Text(
            item.tag.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}

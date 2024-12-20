import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/xt_color_tag.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';

class XtTagRow extends StatelessWidget {
  const XtTagRow({
    super.key,
    this.data = const [],
  });

  final List<XtTagModel> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
      child: Row(
        children: data.map(
          (item) {
            return Row(
              children: [
                const SizedBox(width: 4),
                XtColorTag(
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
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

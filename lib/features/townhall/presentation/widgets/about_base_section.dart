import 'package:flutter/material.dart';
import '../../../home/models/layout_model.dart';

class AboutBaseSection extends StatefulWidget {
  final LayoutModel layout;

  const AboutBaseSection({super.key, required this.layout});

  @override
  State<AboutBaseSection> createState() => _AboutBaseSectionState();
}

class _AboutBaseSectionState extends State<AboutBaseSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final descriptionText =
        (widget.layout.description != null &&
            widget.layout.description!.isNotEmpty)
        ? widget.layout.description!
        : 'Powerful anti 3 star war base for ${widget.layout.thLevel}.\nWorks great in CWL and regular wars.';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(
            text: descriptionText,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              fontSize: 13,
              height: 1.4,
            ),
          );

          final tp = TextPainter(
            text: span,
            maxLines: 2,
            textDirection: TextDirection.ltr,
          );
          tp.layout(maxWidth: constraints.maxWidth);
          final isOverflowing = tp.didExceedMaxLines;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About This Base',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                descriptionText,
                maxLines: _isExpanded ? null : 2,
                overflow: _isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              if (isOverflowing) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        _isExpanded ? 'Read Less ' : 'Read More ',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.blueAccent,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

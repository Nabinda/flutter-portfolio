part of '../main_section.dart';

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return ListView.builder(
      controller: scrollProvider.controller,
      itemCount: BodyUtils.views.length,
      itemBuilder: (context, index) => AutoScrollTag(
          key: ValueKey(index),
          controller: scrollProvider.controller,
          index: index,
          child: BodyUtils.views[index]),
    );
  }
}

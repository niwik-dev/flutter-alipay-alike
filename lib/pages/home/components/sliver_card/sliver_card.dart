import 'package:flutter/material.dart';


class SliverCardRow extends StatelessWidget {
  SliverCardRow({
    super.key,
    this.backgroundColor,
    this.weights,
    required this.children,
    this.spacing = 8,
  });

  final Color? backgroundColor;

  late List<int>? weights;

  final List<Widget> children;

  final double spacing;

  List<Widget> buildRow(){
    List<Widget> rowChildren = [];
    assert(weights == null || children.length == weights?.length);
    weights ??= List.generate(children.length, (index) => 1);
    for(int i = 0;i < children.length;i++){
      rowChildren.add(
          Expanded(
            flex: weights![i],
            child: children[i],
          )
      );
      if(i < children.length - 1){
        rowChildren.add(
            SizedBox(width: spacing)
        );
      }
    }
    return rowChildren;
  }

  @override
  Widget build(BuildContext context){

    return SliverToBoxAdapter(
        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: buildRow(),
            ),
          ),
        )
    );
  }
}

class CardInSliver extends StatelessWidget {
  const CardInSliver({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
    this.decoration = const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white),
    this.hasDivider = true,
    required this.child,
  }) : super(key: key);

  final List<Widget>? leading;

  final Widget? title;

  final List<Widget>? trailing;

  final BoxDecoration decoration;

  final bool hasDivider;

  final Widget child;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: decoration,
      child: Column(
        children: [
          Row(
            children: [
              ...?leading,
              if(title != null)
                ...[const Spacer(), title!,],
              const Spacer(),
              ...?trailing
            ],
          ),
          hasDivider?const Divider(height: 16):const SizedBox(height: 8),
          child
        ],
      ),
    );
  }
}

class SliverCard extends StatelessWidget {
  const SliverCard({
    super.key,
    this.backgroundColor,
    this.decoration = const BoxDecoration(color: Colors.white),
    required this.child,
  });

  final Color? backgroundColor;

  final BoxDecoration decoration;

  final Widget child;

  @override
  Widget build(BuildContext context){
    return SliverToBoxAdapter(
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: child,
          ),
        )
    );
  }
}

class SliverTitleCard extends StatelessWidget {
  const SliverTitleCard({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.backgroundColor,
    this.decoration = const BoxDecoration(color: Colors.white),
    this.hasDivider = true,
    required this.child,
  });

  final List<Widget>? leading;

  final Widget? title;

  final List<Widget>? trailing;

  final Color? backgroundColor;

  final BoxDecoration decoration;

  final bool hasDivider;

  final Widget child;

  @override
  Widget build(BuildContext context){
    return SliverToBoxAdapter(
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: decoration,
              child: Column(
                children: [
                  Row(
                    children: [
                      ...?leading,
                      if(title != null)
                        ...[const Spacer(), title!],
                      const Spacer(),
                      ...?trailing
                    ],
                  ),
                  hasDivider?const Divider(height: 16):const SizedBox(height: 8),
                  child
                ],
              ),
            ),
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';

import './cards.dart';
import './matches.dart';

class TinderSwapCard extends StatefulWidget {
  TinderSwapCard(
      {Key? key, this.title, required this.demoProfiles, this.myCallback, this.mySlideTo})
      : super(key: key);
  final bool? mySlideTo;
  final String? title;
  final List demoProfiles;

  final Function(Decision?, Function)? myCallback;

  @override
  _TinderSwapCardState createState() => _TinderSwapCardState();
}

class _TinderSwapCardState extends State<TinderSwapCard> {
  Match match = new Match();

  Widget _buildBottomBar(MatchEngine matchEngine) {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new RoundIconButton.small(
                icon: Icons.refresh,
                iconColor: Colors.orange,
                onPressed: () {},
              ),
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                onPressed: () {
                  matchEngine.currentMatch?.nope();
                  matchEngine.cycleMatch();
                },
              ),
              new RoundIconButton.small(
                icon: Icons.star,
                iconColor: Colors.blue,
                onPressed: () {
                  matchEngine.currentMatch!.superLike();
                  matchEngine.cycleMatch();
                },
              ),
              new RoundIconButton.large(
                icon: Icons.favorite,
                iconColor: Colors.green,
                onPressed: () {
                  matchEngine.currentMatch?.like();
                  matchEngine.cycleMatch();
                },
              ),
              new RoundIconButton.small(
                icon: Icons.lock,
                iconColor: Colors.purple,
                onPressed: () {},
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final MatchEngine matchEngine = new MatchEngine(
        matches: widget.demoProfiles.map((final profile) {
      return Match(profile: profile);
    }).toList());

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: new CardStack(
          matchEngine: matchEngine,
          onSwipeCallback: (match, showOverlay) {
            widget.myCallback?.call(match, showOverlay);
          },
          mySlideTo: widget.mySlideTo,
        ),
      ),
      // bottomNavigationBar: _buildBottomBar(matchEngine),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final double size;
  final VoidCallback? onPressed;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 60.0;

  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    required this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            new BoxShadow(color: const Color(0x11000000), blurRadius: 10.0),
          ]),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

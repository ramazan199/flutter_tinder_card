import 'package:flutter/widgets.dart';

class MatchEngine extends ChangeNotifier {
  final List<Match> _matches;
  int _currrentMatchIndex;
  int _nextMatchIndex;

  int get recomCount {
    return _matches.length;
  }

  int get currentMatchIdx {
    return _currrentMatchIndex;
  }

  int get nextMatchIdx {
    return _nextMatchIndex;
  }

  void addMatches(List<Match> matches) {
    _matches.addAll(matches);
    // no next match if there is only 1 match which is current one
    _nextMatchIndex = _matches.length < 2 ? 0 : 1;

    // notifyListeners();
  }

  MatchEngine({
    List<Match> matches,
  }) : _matches = matches {
    _currrentMatchIndex = 0;
    _nextMatchIndex = 1;
  }

  Match get currentMatch =>
      _matches.length > 0 ? _matches[_currrentMatchIndex] : null;
  Match get nextMatch => _matches.length > 0 ? _matches[_nextMatchIndex] : null;

  void cycleMatch() {
    if (currentMatch.decision != Decision.indecided) {
      currentMatch.reset();

      _matches.removeAt(0);
      _nextMatchIndex = _matches.length < 2 ? 0 : 1;
      

      // _currrentMatchIndex = _nextMatchIndex;
      // _nextMatchIndex =
      //     _nextMatchIndex < _matches.length - 1 ? _nextMatchIndex + 1 : 0;
      notifyListeners();
    }
  }
}

class Match extends ChangeNotifier {
  final profile;
  var decision = Decision.indecided;

  Match({this.profile, this.decision});

  void like() {
    //  if (decision == Decision.indecided) {
    decision = Decision.like;
    notifyListeners();
    // }
  }

  void nope() {
    // if (decision == Decision.indecided) {
    decision = Decision.nope;
    notifyListeners();
    //  }
  }

  void superLike() {
    // if (decision == Decision.indecided) {
    decision = Decision.superLike;
    notifyListeners();
    // }
  }

  void reset() {
    // if (decision != Decision.indecided) {
    decision = Decision.indecided;
    notifyListeners();
    // }
  }
}

enum Decision {
  indecided,
  nope,
  like,
  superLike,
}

part of the_youtube_player;

typedef Wire<T> = ValueNotifier<T>;

extension ExtraWire<T> on Wire<T> {
  // -----------------------------------------------------------------------------

  /// SET

  // --------------------
  /// TESTED : WORKS PERFECT
  bool set({
    required T value,
    bool mounted = true,
  }){
    return setNotifier(notifier: this, mounted: mounted, value: value);
  }
  // -----------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  ///
  void clear(){
    dispose();
  }
// -----------------------------------------------------------------------------

/// BUILDERS

// --------------------
/// BAD PRACTICE
/*
  /// TESTED : WORKS PERFECT
  Widget liveWire({
    required Widget Function(T value, Widget? child) builder,
    Widget? child,
  }){
    return LiveWire<T>(
      wire: this,
      builder: builder,
      child: child,
    );
  }
   */
// --------------------
/// BAD PRACTICE
/*
  /// TESTED : WORKS PERFECT
  Widget singleWire({
    required Widget Function(T value) builder,
  }){
    return SingleWire<T>(
      wire: this,
      builder: builder,
    );
  }
   */
// -----------------------------------------------------------------------------
}

class LiveWire<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LiveWire({
    required this.wire,
    required this.builder,
    this.child,
    this.nullChild,
    super.key
  });
  // --------------------
  final Wire<T>? wire;
  final Widget Function(T value, Widget? child) builder;
  final Widget? child;
  final Widget? nullChild;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return UnNullify<Wire<T>>(
        value: wire,
        nullChild: nullChild,
        builder: (Wire<T> _wire){

          return ValueListenableBuilder<T>(
              valueListenable: _wire,
              child: child,
              builder: (_, T value, Widget? child){
                return builder(value, child);
              }
          );

        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class SingleWire<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SingleWire({
    required this.wire,
    required this.builder,
    this.nullChild,
    super.key
  });
  // --------------------
  final Wire<T>? wire;
  final Widget Function(T value) builder;
  final Widget? nullChild;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return LiveWire(
        wire: wire,
        nullChild: nullChild,
        builder: (T value, Widget? child){
          return builder(value);
        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class NullableWire<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const NullableWire({
    required this.wire,
    required this.builder,
    super.key
  });
  // --------------------
  final Wire<T?>? wire;
  final Widget Function(T? value) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (wire == null){
      return builder(null);
    }
    else {
      return ValueListenableBuilder(
          valueListenable: wire!,
          builder: (_, T? value, Widget? child){
            return builder(value);
          }
      );
    }

    // --------------------
  }
// --------------------------------------------------------------------------
}

class MultiWires extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MultiWires({
    required this.wires,
    required this.builder,
    this.child,
    super.key
  });
  // --------------------
  final Iterable<Listenable?> wires;
  final Widget? child;
  final Widget Function(Widget? child) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return AnimatedBuilder(
        animation: Listenable.merge(wires),
        child: child,
        builder: (_, Widget? child) {

          return builder(child);

        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class UnNullify<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UnNullify({
    required this.value,
    required this.builder,
    this.nullChild,
    super.key
  });
  // --------------------
  final T? value;
  final Widget? nullChild;
  final Widget Function(T value) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (value == null){
      return nullChild ?? const SizedBox();
    }
    else {
      return builder(value!);
    }
    // --------------------
  }
// --------------------------------------------------------------------------
}

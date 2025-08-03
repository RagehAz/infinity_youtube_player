part of infinity_youtube_player;
/// => DONE
abstract class Engine {
// --------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
static Future<void> mainIgnition () async {

  // final WidgetsBinding _binding =
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Starter());

}
// --------------------------------------------------------------------------

/// APP STARTER


// --------------------
/// TESTED : WORKS PERFECT
static Future<void> appStartInit() async {

}
// --------------------
/// TESTED : WORKS PERFECT
static void appStartDispose({
  required WidgetsBindingObserver observer,
}){
  WidgetsBinding.instance.removeObserver(observer);
}
// --------------------
/// TESTED : WORKS PERFECT
static void appLifeCycleListener(AppLifecycleState state){

  if (state == AppLifecycleState.resumed) {
    blog('XXX === >>> RESUMED');
  }
  else if (state == AppLifecycleState.inactive) {
    blog('XXX === >>> INACTIVE');
  }
  else if (state == AppLifecycleState.paused) {
    blog('XXX === >>> PAUSED');
  }
  else if (state == AppLifecycleState.detached) {
    blog('XXX === >>> DETACHED');
  }

}
// --------------------------------------------------------------------------
}

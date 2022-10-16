import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_character/number_to_character_method_channel.dart';

void main() {
  MethodChannelNumberToCharacter platform = MethodChannelNumberToCharacter();
  const MethodChannel channel = MethodChannel('number_to_character');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

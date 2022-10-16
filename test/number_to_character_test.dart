import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:number_to_character/number_to_character_platform_interface.dart';
import 'package:number_to_character/number_to_character_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNumberToCharacterPlatform
    with MockPlatformInterfaceMixin
    implements NumberToCharacterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NumberToCharacterPlatform initialPlatform = NumberToCharacterPlatform.instance;

  test('$MethodChannelNumberToCharacter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNumberToCharacter>());
  });

  test('getPlatformVersion', () async {
    NumberToCharacter numberToCharacterPlugin = NumberToCharacter();
    MockNumberToCharacterPlatform fakePlatform = MockNumberToCharacterPlatform();
    NumberToCharacterPlatform.instance = fakePlatform;

    expect(await numberToCharacterPlugin.getPlatformVersion(), '42');
  });
}

#import "NumberToCharacterPlugin.h"
#if __has_include(<number_to_character/number_to_character-Swift.h>)
#import <number_to_character/number_to_character-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "number_to_character-Swift.h"
#endif

@implementation NumberToCharacterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNumberToCharacterPlugin registerWithRegistrar:registrar];
}
@end

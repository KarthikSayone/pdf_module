#import "PdfModulePlugin.h"

#if __has_include(<pdf_module/pdf_module-Swift.h>)
#import <pdf_module/pdf_module-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pdf_module-Swift.h"
#endif

@implementation PdfModulePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPdfModulePlugin registerWithRegistrar:registrar];
}
@end

// GodLogOpenPanelModal.m — ObjC runModalForDirectory:file:types: for God log preselect.
#import <AppKit/AppKit.h>

NSModalResponse DBVRunOpenPanelPreselecting(NSOpenPanel *panel, NSString *directory, NSString *filename) {
    [panel setDirectoryURL:[NSURL fileURLWithPath:directory isDirectory:YES]];
    SEL configure = NSSelectorFromString(@("_configureForFilename:"));
    if ([panel respondsToSelector:configure]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [panel performSelector:configure withObject:filename];
#pragma clang diagnostic pop
    }
    SEL mondo = NSSelectorFromString(@("MondoSetFilenameWithProperSelection:"));
    if ([panel respondsToSelector:mondo]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [panel performSelector:mondo withObject:filename];
#pragma clang diagnostic pop
    }
    return [panel runModalForDirectory:directory file:filename types:@[ @"jsonl" ]];
}

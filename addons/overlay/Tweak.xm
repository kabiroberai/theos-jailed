// http://ryanipete.com/blog/ios/swift/objective-c/uidebugginginformationoverlay/

@interface UIDebuggingInformationOverlay
+ (void)prepareDebuggingOverlay;
+ (id)overlay;
- (void)toggleVisibility;
@end

%hook UIWindow

- (void)layoutSubviews {
	%orig;
	static dispatch_once_t once;
	dispatch_once(&once, ^ {
		[%c(UIDebuggingInformationOverlay) prepareDebuggingOverlay];
		[[%c(UIDebuggingInformationOverlay) overlay] toggleVisibility];
	});
}

%end

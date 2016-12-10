#import <FLEX/FLEX.h>

// @interface UIWindow ()
// - (void)handleTap:(UITapGestureRecognizer*)recognizer;
// @end

%hook UIWindow

- (void)layoutSubviews {
	%orig;
	static dispatch_once_t once;
	dispatch_once(&once, ^ {
		[[FLEXManager sharedManager] showExplorer];
		// UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)];
		// [self addGestureRecognizer: recognizer];
	});
}

// %new
// - (void)handleTap:(UITapGestureRecognizer*)recognizer {
// 	[[FLEXManager sharedManager] showExplorer];
// }

%end

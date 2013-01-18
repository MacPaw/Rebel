//
//  RBLClipView.m
//  Rebel
//
//  Created by Justin Spahr-Summers on 2012-09-14.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "RBLClipView.h"
#import "NSColor+RBLCGColorAdditions.h"

@interface RBLScrollLayer : CAScrollLayer

@end

@implementation RBLScrollLayer

- (id<CAAction>)actionForKey:(NSString *)anEvent
{
	if ([anEvent isEqualToString:@"sublayers"])
	{
		return NULL;
	}
	
	return [super actionForKey:anEvent];
}

@end

@implementation RBLClipView

#pragma mark Properties

@dynamic layer;

- (NSColor *)backgroundColor {
	return [NSColor rbl_colorWithCGColor:self.layer.backgroundColor];
}

- (void)setBackgroundColor:(NSColor *)color {
	self.layer.backgroundColor = color.rbl_CGColor;
}

- (BOOL)isOpaque {
	return self.layer.opaque;
}

- (void)setOpaque:(BOOL)opaque {
	self.layer.opaque = opaque;
}

#pragma mark Lifecycle

- (id)initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	self.layer = [RBLScrollLayer layer];
	self.wantsLayer = YES;

	self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawNever;

	// Matches default NSClipView settings.
	self.backgroundColor = NSColor.clearColor;
	self.opaque = NO;

	return self;
}

- (BOOL)copiesOnScroll
{
	return NO;
}

@end

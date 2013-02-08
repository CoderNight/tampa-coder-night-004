//
//  RBPositionHelper.m
//  RockBottom
//
//

#import "RBPositionHelper.h"

@implementation RBPositionHelper

- (id)initWithSize:(int)size {
    self = [super init];
    if (self) {
        self.size = size;
    }
    return self;
}

- (NSDictionary *)coordsFromIndex:(int)index {
    int _y = (index / [self size]);
    int _x = (index - ([self size] * _y));
    NSNumber *y = [NSNumber numberWithInt:_y];
    NSNumber *x = [NSNumber numberWithInt:_x];
    NSDictionary *coords = @{@"x": x, @"y": y};
    return coords;
}

- (int)indexFromX:(int)x Y:(int)y {
    return [self size] * y + x;
}

- (int)upFromIndex:(int)index {
    NSDictionary *coords = [self coordsFromIndex:index];
    int x = [[coords valueForKey:@"x"] intValue];
    int y = [[coords valueForKey:@"y"] intValue];
    return [self indexFromX:x Y:y - 1];
}
- (int)downFromIndex:(int)index {
    NSDictionary *coords = [self coordsFromIndex:index];
    int x = [[coords valueForKey:@"x"] intValue];
    int y = [[coords valueForKey:@"y"] intValue];
    return [self indexFromX:x Y:y + 1];
}
- (int)leftFromIndex:(int)index {
    NSDictionary *coords = [self coordsFromIndex:index];
    int x = [[coords valueForKey:@"x"] intValue];
    int y = [[coords valueForKey:@"y"] intValue];
    return [self indexFromX:x - 1 Y:y];
}
- (int)rightFromIndex:(int)index {
    NSDictionary *coords = [self coordsFromIndex:index];
    int x = [[coords valueForKey:@"x"] intValue];
    int y = [[coords valueForKey:@"y"] intValue];
    return [self indexFromX:x + 1 Y:y];
}

@end

//
//  RBCave.m
//  RockBottom
//
//

#import "RBCave.h"

NSString *const EMPTY = @" ";
NSString *const WATER = @"~";
NSString *const BARRIER = @"#";

@implementation RBCave

@synthesize opening = _opening;
@synthesize width = _width;
@synthesize height = _height;
@synthesize size = _size;
@synthesize posHelper = _posHelper;
@synthesize positions = _positions;

- (id)initWithCaveRows:(NSArray *)rows {
    self = [super init];
    if (self) {
        self.width = [((NSString*)[rows objectAtIndex:0]) length];
        self.height = [rows count];
        self.size = _width * _height;
        self.positions = [[NSMutableArray alloc] initWithCapacity:_size + 1];
        self.posHelper = [[RBPositionHelper alloc] initWithSize:_width];
        for (int y = 0; y < _height; y++) {
            NSString *row = (NSString *)[rows objectAtIndex:y];
            for (int x = 0; x < [row length]; x++) {
                NSString *chr  = [NSString stringWithFormat:@"%c", [row characterAtIndex:x]];
                int index = [_posHelper indexFromX:x Y:y];
                self.positions[index] = chr;
                if ([chr isEqual:WATER]) {
                    self.opening = index;
                }
            }
        }
    }
    return self;
}

- (NSString *)at:(int)position {
    if ([self inBounds:position]) {
        return [_positions objectAtIndex:position];
    } else {
        return nil;
    }
}

- (void)set:(int)position unit:(NSString *)unit {
    if ([self inBounds:position]) {
        self.positions[position] = unit;
    }
}

- (void)fill:(int)position {
    [self set:position unit:WATER];
}

- (int)up:(int)position {
    return [_posHelper upFromIndex:position];
}

- (int)down:(int)position {
    return [_posHelper downFromIndex:position];
}

- (int)left:(int)position {
    return [_posHelper leftFromIndex:position];
}

- (int)right:(int)position {
    return [_posHelper rightFromIndex:position];
}

- (BOOL)inBounds:(int)position {
    return position >= 0 && position < _size;
}

@end

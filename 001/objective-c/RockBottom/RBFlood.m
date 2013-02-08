//
//  RBFlood.m
//  RockBottom
//
//

#import "RBFlood.h"
#import "RBCave.h"

@implementation RBFlood

@synthesize units = _units;
@synthesize currentPosition = _currentPosition;
@synthesize input = _input;
@synthesize cave = _cave;

- (id)initWithInputPath:(NSString *)fileName {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        
        self.input = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *inputLines = [_input componentsSeparatedByCharactersInSet:
                               
        [NSCharacterSet newlineCharacterSet]];
        self.units = [[inputLines objectAtIndex:0] intValue];

        NSInteger inputSize = [inputLines count];
        NSRange caveRange = {2, inputSize - 3};
        NSArray *caveRows = [inputLines subarrayWithRange:caveRange];

        self.cave = [[RBCave alloc] initWithCaveRows:caveRows];
        self.currentPosition = _cave.opening;
    }
    return self;
}

- (NSString *)waterDepthsReport {
    NSArray *values = [self waterDepths];
    return [values componentsJoinedByString:@" "];
}

- (NSArray *)waterDepths {
    NSMutableDictionary *counts = [NSMutableDictionary dictionary];
    NSString *empty = @" ";
    NSString *water = @"~";
    for (int i = 0; i < _cave.width; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        [counts setValue:@0 forKey:column];
    }

    for (int i = 0; i < [_cave.positions count]; i++) {
        NSDictionary *coords = [_cave.posHelper coordsFromIndex:i];
        int x = [[coords valueForKey:@"x"] intValue];
        NSString *column = [NSString stringWithFormat:@"%d", x];
        NSString *unit = _cave.positions[i];
        int count = [[counts valueForKey:column] intValue];
        if ([unit isEqual:water]) {
            int newCount = count += 1;
            [counts setValue:[NSNumber numberWithInt:newCount]forKey:column];
        } else if ([unit isEqual:empty] && count != 0) {
            [counts setValue:water forKey:column];
        }
    }

    NSMutableArray *values = [NSMutableArray array];
    for (int i = 0; i < _cave.width; i++) {
        NSString *key = [NSString stringWithFormat:@"%d", i];
        [values addObject:[counts objectForKey:key]];
    }
    return values;
}

- (void)floodCave {
    self.units--;
    while (_units > 0) {
        [self flow];
    }
}

- (void)flow {
    int downPosition = [_cave down:_currentPosition];
    int rightPosition = [_cave right:_currentPosition];
    NSString *empty = @" ";

    if ([[_cave at:downPosition] isEqual:empty]) {
        [self flowDown];
    } else if ([[_cave at:rightPosition] isEqual:empty]) {
        [self flowRight];
    } else {
        [self flowUp];
    }

    [self tick];
}


- (void)flowUp {
    NSString *empty = @" ";

    while(![[_cave at:[_cave up:_currentPosition]] isEqual:empty]) {
        self.currentPosition = [_cave up:_currentPosition];
    }
    self.currentPosition = [_cave up:_currentPosition];

    while([[_cave at:[_cave left:_currentPosition]] isEqual:empty]) {
        self.currentPosition = [_cave left:_currentPosition];
    }

    [_cave fill:_currentPosition];
}

- (void)flowDown {
    [self flowIntoPosition:[_cave down:_currentPosition]];
}

- (void)flowRight {
    [self flowIntoPosition:[_cave right:_currentPosition]];
}

- (void)tick {
    if (_units > 0) {
        self.units -= 1;
    }
}

- (void)print {
    NSMutableString *output = [[NSMutableString alloc] init];
    [output appendString:@"\n\n"];
    for (int y = 0; y < _cave.height; y++) {
        int start = _cave.width * y;
        NSRange range = {start, _cave.width};
        NSArray *row = [_cave.positions subarrayWithRange:range];
        NSString *rowString =[row componentsJoinedByString:@""];
        [output appendString:rowString];
        [output appendString:@"\n"];
    }

    [output appendString:[NSString stringWithFormat:@"\ndepths: %@", [self waterDepthsReport]]];

    NSLog(@"out: %@", output);
}

- (void)flowIntoPosition:(int)position {
    self.currentPosition = position;
    [_cave fill:_currentPosition];
}

@end

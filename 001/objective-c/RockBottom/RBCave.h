//
//  RBCave.h
//  RockBottom
//
//

#import <Foundation/Foundation.h>
#import "RBPositionHelper.h"

#define EMPTY_UNIT const NSString *EMPTY;
#define WATER_UNIT const NSString *WATER;
#define BARRIER_UNIT const NSString *BARRIER;

@interface RBCave : NSObject

@property (assign) int opening;
@property (assign) int width;
@property (assign) int height;
@property (assign) int size;
@property (nonatomic, retain) RBPositionHelper *posHelper;
@property (nonatomic, retain) NSMutableArray *positions;

- (id)initWithCaveRows:(NSArray *)rows;
- (NSString *)at:(int)position;
- (void)set:(int)position unit:(NSString *)unit;
- (void)fill:(int)position;
- (int)up:(int)position;
- (int)down:(int)position;
- (int)left:(int)position;
- (int)right:(int)position;

@end

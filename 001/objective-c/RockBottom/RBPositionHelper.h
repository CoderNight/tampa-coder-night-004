//
//  RBPositionHelper.h
//  RockBottom
//
//

#import <Foundation/Foundation.h>

@interface RBPositionHelper : NSObject

@property (assign) int size;

- (id)initWithSize:(int)size;

- (NSDictionary *)coordsFromIndex:(int)index;
- (int)indexFromX:(int)x Y:(int)y;
- (int)upFromIndex:(int)index;
- (int)downFromIndex:(int)index;
- (int)leftFromIndex:(int)index;
- (int)rightFromIndex:(int)index;
@end

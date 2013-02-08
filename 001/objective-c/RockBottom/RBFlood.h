//
//  RBFlood.h
//  RockBottom
//
//

#import <Foundation/Foundation.h>
#import "RBCave.h"

@interface RBFlood : NSObject

@property (assign) int units;
@property (assign) int currentPosition;
@property (nonatomic, retain) NSString *input;
@property (nonatomic, retain) RBCave *cave;

- (id)initWithInputPath:(NSString *)fileName;
- (NSString *)waterDepthsReport;
- (void)floodCave;
- (void)print;

@end

//
//  RBAppDelegate.m
//  RockBottom
//
//

#import "RBAppDelegate.h"
#import "RBFlood.h"
#import "RBPositionHelper.h"

@implementation RBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *inputFileName = @"simple_cave";
    RBFlood *flood = [[RBFlood alloc] initWithInputPath:inputFileName];
    [flood floodCave];
    NSLog(@"Flood with input: %@", inputFileName);
//    NSLog(@"Flood depths: %@", [flood waterDepthsReport]);
    [flood print];

    NSString *complexInputFileName = @"complex_cave";
    RBFlood *complexFlood = [[RBFlood alloc] initWithInputPath:complexInputFileName];
    [complexFlood floodCave];
    NSLog(@"Flood with input: %@", complexInputFileName);
//    NSLog(@"Flood depths: %@", [complexFlood waterDepthsReport]);
    [complexFlood print];

}

@end

#import "BBCSMPUIApplicationBackgroundTaskService.h"
#import "BBCSMPDefines.h"
#import <UIKit/UIApplication.h>

#pragma mark - Background Task

@interface BBCSMPAVUIApplicationBackgroundTask : NSObject <BBCSMPAVBackgroundTask>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithExpirationHandler:(void(^)(id<BBCSMPAVBackgroundTask>))expirationHandler NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskIdentifier;

- (void)backgroundTaskWillExpire;

@end

@implementation BBCSMPAVUIApplicationBackgroundTask {
    void(^_expirationHandler)(id<BBCSMPAVBackgroundTask>);
}

- (instancetype)initWithExpirationHandler:(void(^)(id<BBCSMPAVBackgroundTask>))expirationHandler
{
    self = [super init];
    if (self) {
        _expirationHandler = [expirationHandler copy];
    }
    
    return self;
}

- (void)backgroundTaskWillExpire
{
    _expirationHandler(self);
}

- (void)endBackgroundTask
{
#if !SMP_APPLICATION_EXTENSION
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
#endif
}

@end

#pragma mark - BBCSMPUIApplicationBackgroundTaskService Implementation

@implementation BBCSMPUIApplicationBackgroundTaskService

- (id<BBCSMPAVBackgroundTask>)beginBackgroundTaskWithExpirationHandler:(void (^)(id<BBCSMPAVBackgroundTask>))expirationHandler
                                                                 error:(NSError **)error
{
#if SMP_APPLICATION_EXTENSION
    return 0;
#else
    NSString *taskDescription = NSStringFromClass([self class]);
    UIApplication *application = [UIApplication sharedApplication];
    BBCSMPAVUIApplicationBackgroundTask *backgroundTask = [[BBCSMPAVUIApplicationBackgroundTask alloc] initWithExpirationHandler:expirationHandler];
    UIBackgroundTaskIdentifier backgroundTaskIdentifier = [application beginBackgroundTaskWithName:taskDescription
                                                                                 expirationHandler:^{
        [backgroundTask backgroundTaskWillExpire];
    }];
    
    if (backgroundTaskIdentifier == UIBackgroundTaskInvalid) {
        if (error) {
            *error = [NSError errorWithDomain:BBCSMPAVBackgroundTaskServiceErrorDomain
                                         code:BBCSMPAVBackgroundTaskServiceErrorBackgroundTaskNotPermitted
                                     userInfo:nil];
        }
        
        return nil;
    } else {
        [backgroundTask setBackgroundTaskIdentifier:backgroundTaskIdentifier];
        return backgroundTask;
    }
#endif
}

@end

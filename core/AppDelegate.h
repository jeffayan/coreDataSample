//
//  AppDelegate.h
//  core
//
//  Created by Developer on 12/04/17.
//  Copyright © 2017 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
//-(NSManagedObjectContext *) managedObjectContext;

@end


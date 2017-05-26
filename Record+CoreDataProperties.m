//
//  Record+CoreDataProperties.m
//  core
//
//  Created by Developer on 21/04/17.
//  Copyright © 2017 Developer. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Record+CoreDataProperties.h"

@implementation Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Record"];
}

@dynamic name;
@dynamic address;

@end

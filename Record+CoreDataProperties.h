//
//  Record+CoreDataProperties.h
//  core
//
//  Created by Developer on 21/04/17.
//  Copyright © 2017 Developer. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Record+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *address;

@end

NS_ASSUME_NONNULL_END

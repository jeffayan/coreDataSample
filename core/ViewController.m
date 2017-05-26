//
//  ViewController.m
//  core
//
//  Created by Developer on 12/04/17.
//  Copyright © 2017 Developer. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Record+CoreDataProperties.h"

typedef struct {
  __unsafe_unretained  NSString *name;
  __unsafe_unretained  NSString *addr;
}recordData;

@interface ViewController ()
{
    NSString *entityName;
    NSString *attrName;
    NSString *attrAddress;
    NSArray *tableDataSource;
    NSPredicate *predicate;
    Record *record;
    
}
@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) IBOutlet UITextField *textFieldAddress;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ViewController

NSManagedObjectContext *context;
NSError *error = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    entityName = @"Record";
    attrName =@"name";
    attrAddress = @"address";
    
    context = [self managedObjectContext];
    [self setData];
    [_tableView reloadData];
//    
//    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    
//  //  [fetch setPredicate: [NSPredicate predicateWithFormat: @"%@ = 257",attrName] ];
//    
//    [fetch setReturnsObjectsAsFaults:NO];
//    NSArray *arr = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
//    
//    NSLog(@"%@",arr);
//    
//    if ([[self managedObjectContext] save:&error] == NO) {
//        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
//    }
//    
//    
//    [[self managedObjectContext] deleteObject:arr[1]];
//    
//    if ([[self managedObjectContext] save:&error] == NO) {
//        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
//    }
//    
////    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Car"];
////    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
////    
////    NSError *deleteError = nil;
////    [NSPersistentStoreCoordinator ];
//    
////    NSFetchRequest *fetchreq = [[NSFetchRequest alloc] init];
////    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
////    [fetchreq setEntity:entity];
////    error =  nil;
////    NSArray *arr = [context executeFetchRequest:fetchreq error:&error];
////    NSLog(@"Before : %@",arr);
////    
////   // [[context deletedObjects] allObjects];
////    
////    NSLog(@"%@",[arr objectAtIndex: arr.count-3]);
////    NSArray *arrr = [context executeFetchRequest:fetchreq error:&error];
////    NSLog(@"After : %@",arrr);
////    
////    [context save:&error];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSManagedObjectContext *) managedObjectContext{
    
    id delegate = [[UIApplication sharedApplication] delegate];

    return [[delegate persistentContainer] viewContext];
}


- (IBAction)addDataButton:(id)sender {
    
    record = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [self setValues];
    
   }


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = [[tableDataSource objectAtIndex: indexPath.row] valueForKey:attrName];
    cell.detailTextLabel.text = [[tableDataSource objectAtIndex: indexPath.row] valueForKey:attrAddress];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [tableDataSource count];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject: [tableDataSource objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]){
            NSLog(@"%@",[error localizedDescription]);
        }
        [self setData];
        [_tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    record = [tableDataSource objectAtIndex:indexPath.row];
    
    _textFieldName.text = [record valueForKey:attrName];
    _textFieldAddress.text = [record valueForKey:attrAddress];
}

-(void)setData{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    [fetch setReturnsObjectsAsFaults:NO];
    
    [fetch setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey:attrName ascending:YES]]];
    
    predicate = nil;
    
    if ([[_textFieldName text] length]>0 && [[_textFieldAddress text] length]>0){
        
        predicate = [NSPredicate predicateWithFormat: @"name contains %@ && address contains %@",[_textFieldName text],[_textFieldAddress text]];
        
    } else if ([[_textFieldName text] length]>0){
        
        predicate = [NSPredicate predicateWithFormat: @"name contains %@ ",[_textFieldName text]];
        
    }  else if ([[_textFieldAddress text] length]>0){
        
        predicate = [NSPredicate predicateWithFormat: @"address contains %@ ",[_textFieldAddress text]];
    }
    
    [fetch setPredicate:predicate];
    NSError *error = nil;
    tableDataSource = [context executeFetchRequest:fetch error:&error];
}


- (IBAction)fetchButton:(id)sender {
    
    [self setData];
    
    [_tableView reloadData];
    
    if (tableDataSource.count >0){
        
        NSArray *array = [tableDataSource valueForKey:attrName];
        
        NSLog(@"%@",array);
        
        for (NSDictionary *aa in tableDataSource) {
            
            NSLog(@"%@",[aa valueForKey: attrName]);
            NSLog(@"%@",[aa valueForKey: attrAddress]);
        }
        
    } else {
        NSLog(@"Empty");
    }
    
}

- (IBAction)updateAction:(id)sender {
    [self setValues];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:true];
    return true;
}

-(void) setValues{
    [record setName:[_textFieldName text]];
    [record setAddress:[_textFieldAddress text]];
    
    NSError *error = nil;
    
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }else {
        _textFieldAddress.text = @"";
        _textFieldName.text = @"";
    }
    [_textFieldAddress endEditing:YES];
    [_textFieldName endEditing:YES];
    [self setData];
    [_tableView reloadData];
    record = nil;

}


@end

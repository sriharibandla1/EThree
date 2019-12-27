#import "ForCoreDataMethods.h"
#import "AppDelegate.h"

@implementation ForCoreDataMethods
{
    AppDelegate *appDelegate;
    NSManagedObjectContext*context;
}
static ForCoreDataMethods *_sharedMySingleton = nil;
+(ForCoreDataMethods *)networkManager {
    @synchronized([ForCoreDataMethods class]) {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}
/*{
 “paymentMehthod”:“1",
 “paymentStatus”:“1",
 “product_code”:“1,2,3",
 “product_price”:“100,100,300",
 “qtyList”:“1,1,1",
 “product_weight_id”:“1,3,2"
 }*/
-(void)storeDataInCoreDataproduct_code:(NSString*)product_code product_price:(NSString*)product_price qtyList:(NSString*)qtyList product_weight_id:(NSString*)product_weight_id product_weight:(NSString*)product_weight product_name:(NSString*)product_name
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSManagedObject*object = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:context];
    // [object setValue:food_category_id forKey:@"food_category_id"];
    [object setValue:product_code forKey:@"product_code"];
    [object setValue:product_price forKey:@"product_price"];
    [object setValue:qtyList forKey:@"qtyList"];
    [object setValue:product_weight_id forKey:@"product_weight_id"];
    [object setValue:product_weight forKey:@"product_weight"];
    [object setValue:product_name forKey:@"product_name"];
    [appDelegate saveContext];
    
}
-(NSArray*)getDateFromCoreDate
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    context=appDelegate.persistentContainer.viewContext;
    NSFetchRequest*fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Cart"];
    /*NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", ..., nil]; // These are the keys for the properties of your managed object that you want in the JSON
     NSString *json = [[managedObject dictionaryWithValuesForKeys:keys] JSONRepresentation];*/
    [fetchRequest setReturnsObjectsAsFaults:NO];
    fetchRequest.returnsObjectsAsFaults = NO;
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"branch_id = branch_id"];
    //    [fetchRequest setPredicate: predicate];
    NSArray *itemsdata;//=[[NSArray alloc]init];
    NSMutableArray * returningArray = [[NSMutableArray alloc]init];
    itemsdata = [context executeFetchRequest:fetchRequest error:nil];
    for (int i =0; i < itemsdata.count; i++) {
        NSDictionary*dataDictionary=@{@"product_code":[[itemsdata objectAtIndex:i] valueForKey:@"product_code"],@"product_price":[[itemsdata objectAtIndex:i] valueForKey:@"product_price"],@"qtyList":[[itemsdata objectAtIndex:i] valueForKey:@"qtyList"],@"product_weight_id":[[itemsdata objectAtIndex:i] valueForKey:@"product_weight_id"],@"product_weight":[[itemsdata objectAtIndex:i] valueForKey:@"product_weight"],@"product_name":[[itemsdata objectAtIndex:i] valueForKey:@"product_name"]};
        //,@"weightTypeId":[[itemsdata objectAtIndex:i] valueForKey:@"weightTypeId"]
        
        [returningArray addObject:dataDictionary];
    }
    //NSLog(@"product_id %@",[itemsdata[0] valueForKey:@"product_id"]);
    return returningArray;
    // NSLog(@"%@",[[itemsdata objectAtIndex:1] valueForKey:@"name"]);
}
-(void)upDataInCoreData: (NSUInteger)postion product_code:(NSString*)product_code product_price:(NSString*)product_price qtyList:(NSString*)qtyList product_weight_id:(NSString*)product_weight_id product_weight:(NSString*)product_weight product_name:(NSString*)product_name
{
    NSFetchRequest*fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Cart"];
    NSArray*Array=[context executeFetchRequest:fetchRequest error:nil];
    NSManagedObject* object = [Array objectAtIndex:postion];
    //NSString*pkg = [[Array valueForKey:@"packing_charges"]objectAtIndex:sender.tag];
    //  [object setValue:food_category_id forKey:@"food_category_id"];
    [object setValue:product_code forKey:@"product_code"];
    [object setValue:product_price forKey:@"product_price"];
    [object setValue:qtyList forKey:@"qtyList"];
    [object setValue:product_weight_id forKey:@"product_weight_id"];
    [object setValue:product_weight forKey:@"product_weight"];
    [object setValue:product_name forKey:@"product_name"];
    [appDelegate saveContext];
}
-(void)delectItemFromCoreData:(NSDictionary*)position
{
    NSInteger position1 = 0;
    NSArray*dataInCoreData = [self getDateFromCoreDate];
    for (int i = 0 ; i<dataInCoreData.count; i++) {
        if ([dataInCoreData[i] isEqualToDictionary:position]) {
            position1 = i;
        }
    }
    //    NSFetchRequest*fetchRequest1=[NSFetchRequest fetchRequestWithEntityName:@"Order_List"];
    //    NSArray*Array1=[context executeFetchRequest:fetchRequest1 error:nil];
    //    [context deleteObject:[Array1 objectAtIndex:[position integerValue]]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cart" inManagedObjectContext:context];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID like %@",userID];
    [fetchRequest setEntity:entity];
    // [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    NSManagedObject * managedObject = [items objectAtIndex:position1];
    //     for (NSManagedObject *managedObject in items)
    //     {
    [context deleteObject:managedObject];
    // }
}
-(void)deleteData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cart" inManagedObjectContext:context];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID like %@",userID];
    [fetchRequest setEntity:entity];
    // [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
   // NSManagedObject * managedObject = [items objectAtIndex:position1];
         for (NSManagedObject *managedObject in items)
         {
    [context deleteObject:managedObject];
     }
}
@end

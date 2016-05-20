//
//  UITableViewDateSourceManager.m
//  tableViewReloadData
//
//  Created by caobo56 on 16/4/11.
//  Copyright © 2016年 caobo56. All rights reserved.
//

#import "UITableViewDateSourceManager.h"

@implementation UITableViewDateSourceManager


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSection(tableView,section);
}


-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellForRowAtIndexPath(tableView,indexPath);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.numberOfSectionsInTableView) {
        return self.numberOfSectionsInTableView(tableView);
    }else{
        return 1;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        return self.titleForHeaderInSection(tableView,section);
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
        return self.titleForFooterInSection(tableView,section);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canEditRowAtIndexPath(tableView,indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canMoveRowAtIndexPath(tableView,indexPath);
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    return self.sectionIndexTitlesForTableView(tableView);
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED{
    return self.sectionForSectionIndexTitle(tableView,title,index);
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    self.commitEditingStyle(tableView,editingStyle,indexPath);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    self.moveRowAtIndexPath(tableView,sourceIndexPath,destinationIndexPath);
}


@end

#import <objc/runtime.h>
static const void *myDateSourceManager = &myDateSourceManager;


@implementation UITableView(DateSource1)

@dynamic dateSourceManager;

-(void)setDateSourceManager:(UITableViewDateSourceManager *)dateSourceManager{
    objc_setAssociatedObject(self, myDateSourceManager, dateSourceManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITableViewDateSourceManager *)dateSourceManager{
    if (!objc_getAssociatedObject(self, myDateSourceManager)) {
        self.dateSourceManager = [[UITableViewDateSourceManager alloc]init];
        self.dataSource = self.dateSourceManager;
        [self setBlockDefaultValue];
    }
    return objc_getAssociatedObject(self, myDateSourceManager);
}

-(void)setBlockDefaultValue{
    self.dateSourceManager.titleForHeaderInSection = ^(UITableView * tableView,NSInteger section){
        return @"";
    };
    self.dateSourceManager.titleForFooterInSection = ^(UITableView *tableView,NSInteger section){
        return @"";
    };
    
    self.dateSourceManager.canEditRowAtIndexPath = ^(UITableView *tableView,NSIndexPath *indexPath){
        return NO;
    };
    
    self.dateSourceManager.canMoveRowAtIndexPath = ^(UITableView *tableView,NSIndexPath *indexPath){
        return NO;
    };
    
    self.dateSourceManager.sectionIndexTitlesForTableView = ^(UITableView *tableView){
        NSArray<NSString *> *arr = [[NSArray alloc]init];
        return arr;
    };
}


@end


//
//  UITableViewDataSource.h
//  ReactiveCocoa_DataSource
//
//  Created by caobo56 on 16/4/13.
//  Copyright © 2016年 caobo56. All rights reserved.
//

#ifndef UITableViewDataSource_h
#define UITableViewDataSource_h


typedef NSInteger (^NumberOfRowsInSection)(UITableView *tableView,NSInteger section);

typedef UITableViewCell * (^CellForRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);

typedef NSInteger (^NumberOfSectionsInTableView)(UITableView *tableView);

typedef NSString * (^TitleForHeaderInSection)(UITableView *tableView,NSInteger section);

typedef NSString * (^TitleForFooterInSection)(UITableView *tableView,NSInteger section);

typedef BOOL (^CanEditRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);

typedef BOOL (^CanMoveRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);

typedef NSArray<NSString *> * (^SectionIndexTitlesForTableView)(UITableView *tableView);

typedef NSInteger (^SectionForSectionIndexTitle)(UITableView *tableView,NSString * title,NSInteger index);

typedef void (^CommitEditingStyle)(UITableView *tableView,UITableViewCellEditingStyle editingStyle,NSIndexPath * indexPath);

typedef void (^MoveRowAtIndexPath)(UITableView *tableView,NSIndexPath * sourceIndexPath,NSIndexPath *destinationIndexPath);

#endif /* UITableViewDataSource_h */

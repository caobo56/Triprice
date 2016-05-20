//
//  UITableViewDateSourceManager.h
//  tableViewReloadData
//
//  Created by caobo56 on 16/4/11.
//  Copyright © 2016年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableViewDataSource.h"


@interface UITableViewDateSourceManager : NSObject<UITableViewDataSource>

@property(nonatomic,assign)NumberOfRowsInSection numberOfRowsInSection;

@property(nonatomic,assign)CellForRowAtIndexPath cellForRowAtIndexPath;

@property(nonatomic,assign)NumberOfSectionsInTableView numberOfSectionsInTableView;

@property(nonatomic,assign)TitleForHeaderInSection titleForHeaderInSection;

@property(nonatomic,assign)TitleForFooterInSection titleForFooterInSection;

@property(nonatomic,assign)CanEditRowAtIndexPath canEditRowAtIndexPath;

@property(nonatomic,assign)CanMoveRowAtIndexPath canMoveRowAtIndexPath;

@property(nonatomic,assign)SectionIndexTitlesForTableView sectionIndexTitlesForTableView;

@property(nonatomic,assign)SectionForSectionIndexTitle sectionForSectionIndexTitle;

@property(nonatomic,assign)CommitEditingStyle commitEditingStyle;

@property(nonatomic,assign)MoveRowAtIndexPath moveRowAtIndexPath;

@end


@interface UITableView(DateSource1)

@property(nonatomic,strong)UITableViewDateSourceManager * dateSourceManager;

@end

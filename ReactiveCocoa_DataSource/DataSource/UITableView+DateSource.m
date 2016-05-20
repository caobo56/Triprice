//
//  UITableView+DateSource.m
//  jingduoduoDemo
//
//  Created by caobo56 on 16/4/11.
//  Copyright © 2016年 caobo56. All rights reserved.
//

#import "UITableView+DateSource.h"
#import <objc/runtime.h>
#import "UITableViewDateSourceManager.h"

static const void *myNumberOfRowsInSection = &myNumberOfRowsInSection;
static const void *myCellForRowAtIndexPath = &myCellForRowAtIndexPath;
static const void *myNumberOfSectionsInTableView = &myNumberOfSectionsInTableView;
static const void *myTitleForHeaderInSection = &myTitleForHeaderInSection;
static const void *myTitleForFooterInSection = &myTitleForFooterInSection;
static const void *myCanEditRowAtIndexPath = &myCanEditRowAtIndexPath;
static const void *myCanMoveRowAtIndexPath = &myCanMoveRowAtIndexPath;
static const void *mySectionIndexTitlesForTableView = &mySectionIndexTitlesForTableView;
static const void *mySectionForSectionIndexTitle = &mySectionForSectionIndexTitle;
static const void *myCommitEditingStyle = &myCommitEditingStyle;
static const void *myMoveRowAtIndexPath = &myMoveRowAtIndexPath;

@implementation UITableView(DateSource)

@dynamic numberOfRowsInSection;
@dynamic cellForRowAtIndexPath;
@dynamic numberOfSectionsInTableView;
@dynamic titleForHeaderInSection;
@dynamic titleForFooterInSection;
@dynamic canEditRowAtIndexPath;
@dynamic canMoveRowAtIndexPath;
@dynamic sectionIndexTitlesForTableView;
@dynamic sectionForSectionIndexTitle;
@dynamic commitEditingStyle;
@dynamic moveRowAtIndexPath;

-(void)setNumberOfRowsInSection:(NumberOfRowsInSection)numberOfRowsInSection{
    objc_setAssociatedObject(self, myNumberOfRowsInSection, numberOfRowsInSection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NumberOfRowsInSection)numberOfRowsInSection{
    return objc_getAssociatedObject(self, myNumberOfRowsInSection);
}

-(void)setCellForRowAtIndexPath:(CellForRowAtIndexPath)cellForRowAtIndexPath{
    objc_setAssociatedObject(self, myCellForRowAtIndexPath, cellForRowAtIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CellForRowAtIndexPath)cellForRowAtIndexPath{
    return objc_getAssociatedObject(self, myCellForRowAtIndexPath);
}

-(void)setNumberOfSectionsInTableView:(NumberOfSectionsInTableView)numberOfSectionsInTableView{
    objc_setAssociatedObject(self, myNumberOfSectionsInTableView, numberOfSectionsInTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NumberOfSectionsInTableView)numberOfSectionsInTableView{
    return objc_getAssociatedObject(self, myNumberOfSectionsInTableView);
}


-(void)setTitleForHeaderInSection:(TitleForHeaderInSection)titleForHeaderInSection{
    objc_setAssociatedObject(self, myTitleForHeaderInSection, titleForHeaderInSection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TitleForHeaderInSection)titleForHeaderInSection{
    return objc_getAssociatedObject(self, myTitleForHeaderInSection);
}

-(void)setTitleForFooterInSection:(TitleForFooterInSection)titleForFooterInSection{
    objc_setAssociatedObject(self, myTitleForFooterInSection, titleForFooterInSection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TitleForFooterInSection)titleForFooterInSection{
    return objc_getAssociatedObject(self, myTitleForFooterInSection);
}

-(void)setCanEditRowAtIndexPath:(CanEditRowAtIndexPath)canEditRowAtIndexPath{
    objc_setAssociatedObject(self, myCanEditRowAtIndexPath, canEditRowAtIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CanEditRowAtIndexPath)canEditRowAtIndexPath{
    return objc_getAssociatedObject(self, myCanEditRowAtIndexPath);
}

-(void)setCanMoveRowAtIndexPath:(CanMoveRowAtIndexPath)canMoveRowAtIndexPath{
    objc_setAssociatedObject(self, myCanMoveRowAtIndexPath, canMoveRowAtIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CanMoveRowAtIndexPath)canMoveRowAtIndexPath{
    return objc_getAssociatedObject(self, myCanMoveRowAtIndexPath);
}

-(void)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)sectionIndexTitlesForTableView{
    objc_setAssociatedObject(self, mySectionIndexTitlesForTableView, sectionIndexTitlesForTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(SectionIndexTitlesForTableView)sectionIndexTitlesForTableView{
    return objc_getAssociatedObject(self, mySectionIndexTitlesForTableView);
}


-(void)setSectionForSectionIndexTitle:(SectionForSectionIndexTitle)sectionForSectionIndexTitle{
    objc_setAssociatedObject(self, mySectionForSectionIndexTitle, sectionForSectionIndexTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(SectionForSectionIndexTitle)sectionForSectionIndexTitle{
    return objc_getAssociatedObject(self, mySectionForSectionIndexTitle);
}

-(void)setCommitEditingStyle:(CommitEditingStyle)commitEditingStyle{
    objc_setAssociatedObject(self, myCommitEditingStyle, commitEditingStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CommitEditingStyle)commitEditingStyle{
    return objc_getAssociatedObject(self, myCommitEditingStyle);
}

-(void)setMoveRowAtIndexPath:(MoveRowAtIndexPath)moveRowAtIndexPath{
    
    objc_setAssociatedObject(self, myMoveRowAtIndexPath, moveRowAtIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MoveRowAtIndexPath)moveRowAtIndexPath{
    return objc_getAssociatedObject(self, myMoveRowAtIndexPath);
}


@end

















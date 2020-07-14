//
//  NSCustomComboBoxCell.h
//  Toggl Track on the Mac
//
//  Created by Tanel Lebedev on 13/11/2013.
//  Copyright (c) 2013 TogglTrack developers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSCustomComboBoxCell : NSComboBoxCell
@property (nonatomic, assign) CGFloat cellLength;
- (void)setCalculatedMaxWidth:(double)length;
@end
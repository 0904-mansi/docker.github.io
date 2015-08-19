//
//  managevmpluginPane.h
//  managevmplugin
//
//  Created by Jeffrey Dean Morgan on 8/19/15.
//  Copyright (c) 2015 Docker Inc. All rights reserved.
//

#import <InstallerPlugins/InstallerPlugins.h>

@interface managevmpluginPane : InstallerPane

@property (weak) IBOutlet NSImageView *boot2dockerImage;
@property (weak) IBOutlet NSImageView *toolboxImage;
@property (weak) IBOutlet NSButton *migrateCheckbox;
@property (weak) IBOutlet NSTextField *migrateExtraLabel;
@property (weak) IBOutlet NSProgressIndicator *migrationProgress;
@property (weak) IBOutlet NSImageView *arrowImage;
@property (weak) IBOutlet NSImageView *migrationStatusImage;
@property (weak) IBOutlet NSTextField *migrationStatusLabel;
@property (unsafe_unretained) IBOutlet NSTextView *migrationLogsTextView;
@property (weak) IBOutlet NSScrollView *migrationLogsScrollView;

@end

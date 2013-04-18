//
//  ViewController.h
//  XMLParser
//
//  Created by 廣川政樹 on 2013/04/18.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate> {
  NSString *nowTagStr;
  NSString *txtBuffer;
}

@property (strong, nonatomic) UITextView *textView;

@end

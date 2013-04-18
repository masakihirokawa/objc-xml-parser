//
//  ViewController.m
//  XMLParser
//
//  Created by 廣川政樹 on 2013/04/18.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

UITextView *_textView;

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
  //テキストビューの初期化
  [self initTextView];
  //URLを指定してXMLパーサーを作る
  [self setXMLParser];
}

//テキストビューの初期化
- (void)initTextView
{
	//テキストビューを空欄にする
	_textView.text = @"";
  //編集不可に設定
	_textView.editable = NO;
  //
  [self.view addSubview:_textView];
}

//URLを指定してXMLパーサーを作る
- (void)setXMLParser
{
  //XMLを読み込む
	NSURL *myURL = [NSURL URLWithString:@"sample.xml"];
  //XMLパーサを初期化
	NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:myURL];
  //デリゲート指定
	myParser.delegate = self;
	// 解析を開始する
	[myParser parse];
}

//解析開始時の処理
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	//解析中タグの初期化
	nowTagStr = @"";
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
  //開始タグが"sweets"だったら
  if ([elementName isEqualToString:@"sweets"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
		// テキストビューに、タグ名と、price属性を追加する
		_textView.text = [_textView.text stringByAppendingFormat:
                       @"タグ名=[%@]\n 属性 price=[%@]",
                       elementName, [attributeDict objectForKey:@"price"]];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// 解析中のタグが"sweets"だったら
  if ([nowTagStr isEqualToString:@"sweets"]) {
		// テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	// 終了タグが"sweets"だったら
  if ([elementName isEqualToString:@"sweets"]) {
		// テキストビューにテキストバッファの文字を追加する
		_textView.text = [_textView.text stringByAppendingFormat:
                       @"\n 要素=[%@]\n\n", txtBuffer];
	}
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

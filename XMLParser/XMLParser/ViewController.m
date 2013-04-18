//
//  ViewController.m
//  XMLParser
//
//  Created by 廣川政樹 on 2013/04/18.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

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
  //
  self.textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 30, 260, 508)];
	//テキストビューを空欄にする
	self.textView.text = @"";
  //テキストビューを編集不可に設定
	self.textView.editable = NO;
  //テキストビューを画面に追加
  [self.view addSubview:self.textView];
}

//URLを指定してXMLパーサーを作る
- (void)setXMLParser
{
  //XMLを読み込む
	NSURL *myURL = [NSURL URLWithString:@"http://dolice.net/sample/ios/XMLParser/sample.xml"];
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

//テキストビューに、タグ名と、price属性を追加する
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
  //開始タグが「game」だったら
  if ([elementName isEqualToString:@"game"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
		//テキストビューに、タグ名と、price属性を追加する
		self.textView.text = [self.textView.text stringByAppendingFormat:
                          @"タグ名=[%@]\n 属性 price=[%@]",
                          elementName, [attributeDict objectForKey:@"price"]];
	}
}

//テキストバッファに文字を追加する
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//解析中のタグが「game」だったら
  if ([nowTagStr isEqualToString:@"game"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
}

//テキストビューにテキストバッファの文字を追加する
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	//終了タグが「game」だったら
  if ([elementName isEqualToString:@"game"]) {
		//テキストビューにテキストバッファの文字を追加する
		self.textView.text = [self.textView.text stringByAppendingFormat:
                          @"\n 要素=[%@]\n\n", txtBuffer];
	}
}

@end

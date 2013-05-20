//
//  ViewController.m
//  Grahpics
//
//  Created by 王兴朝 on 13-5-17.
//  Copyright (c) 2013年 bitcar. All rights reserved.
//

#import "ViewController.h"
#import "CanvasView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CanvasView *canvasView = [[CanvasView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [canvasView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:canvasView];
    [canvasView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

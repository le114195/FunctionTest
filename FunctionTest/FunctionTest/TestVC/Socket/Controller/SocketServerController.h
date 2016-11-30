//
//  SocketServerController.h
//  FunctionTest
//
//  Created by 勒俊 on 2016/11/30.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"

@interface SocketServerController : UIViewController <NSNetServiceDelegate, GCDAsyncSocketDelegate>
{
    NSNetService        *netService;
    GCDAsyncSocket      *asyncSocket;
    NSMutableArray      *connectedSockets;
    
}

@end

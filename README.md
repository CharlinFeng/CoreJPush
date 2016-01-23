
<br/>
CoreJPush （持续关注[信息公告牌](https://github.com/CharlinFeng/Show)）
==========
#### CoreJPush,让您五句代码立即搞定JPush，集成到使用只需要3分钟。没错，3分钟！

<br/>
# 一.框架准备
#### 1. 拖拽CoreJPush到您的项目中，并添加以下依赖框架
>.CFNetwork.framework<br/>
>.CoreFoundation.framework<br/>
>.CoreTelephony.framework<br/>
>.SystemConfiguration.framework<br/>
>.Security.framework<br/>
>. libz.tbd <br/>

<br/><br/>
#### 2. 项目配置
>. (1) Search Paths 下的 User Header Search Paths 和 Library Search Paths为`$(PROJECT_DIR)/CoreJPush/CoreJPush/Lib`。<br/>
>. (2) 选中Project-Target-Capabilities-Background Modes,勾选Remote Notifications。<br/>
>. (3) 请修改CoreJPush框架内Common文件夹下PushConfig.plist的Appkey为您的Appkey。<br/>
>. (4) 如果你的工程需要支持小于7.0的iOS系统，请到Build Settings 关闭 bitCode 选项，否则将无法正常编译通过。<br/>
>. (5)允许XCode7支持Http传输方法
        
        如果用的是Xcode7时，需要在App项目的plist手动加入以下key和值以支持http传输:
        
          <key>NSAppTransportSecurity</key> 
              <dict> 
          <key>NSAllowsArbitraryLoads</key> 
                <true/> 
            </dict>



<br/><br/><br/>
# 二.光速集成

#### 1.注册JPush（一句代码）
请删除您的AppDelgate中所有有关推送的方法，因为CoreJPush内部已经封装。

    #import "CoreJPush.h"
    //注册JPush
    [CoreJPush registerJPush:launchOptions];
    
<br/><br/>
#### 2.突破空间限制，在您任意想得到推送数据的地方，三句代码搞定：

      //1.添加一个监听者：此监听者是遵循了CoreJPushProtocol协议
      [CoreJPush addJPushListener:self];
      
      
      //2.你需要在合适的地方（比如dealloc），移除监听者
      [CoreJPush removeJPushListener:self];
      
      
      //3.您已经遵循了CoreJPushProtocol协议，直接在.m文件里面敲did ，Xcode会提示你如下方法：
      -(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
          NSLog(@"ViewController: %@",userInfo);
      }


<br/><br/><br/>
# 三. 定义标签与别名
#### 注：标签与别名为覆盖操作，而非增量操作。传nil为本次设置值忽略，传""为清除操作。
#### 请注意返回block的res值为设置结果，只有res = YES，才表示标签与别名操作成功。

    [CoreJPush setTags:[NSSet setWithArray:@[@"movie"]] alias:@"12343242" resBlock:^(BOOL res, NSSet *tags, NSString *alias) {
        
        if(res){
            NSLog(@"设置成功：%@,%@",@(res),tags,alias);
        }else{
            NSLog(@"设置失败");
        }
    }];


<br/><br/><br/>
# 四. Badge管理
#### 框架内部已经完成封装，你无需管理。


<br/><br/><br/>
# 五. 系统通知栏提示信息管理
#### 框架内部已经完成封装，你无需管理。


<br/><br/><br/>
# 六. Swift支持
#### 支持Swift只需做一件事情，就是在框架的Common文件夹中的AppDelegate+JPush.h中引入YourAppName-Swift.h即可。

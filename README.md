<br/>
CoreJPush （持续关注[信息公告牌](https://github.com/CharlinFeng/Show)）
==========
#### CoreJPush,让您三句代码立即搞定JPush，集成到使用只需要3分钟。没错，3分钟！



<br/><br/><br/>
#### 一.项目配置
<br/><br/>
#### 1. 拖拽CoreJPush到您的项目中，并添加以下依赖框架
>.CFNetwork.framework<br/>
>.CoreFoundation.framework<br/>
>.CoreTelephony.framework<br/>
>.SystemConfiguration.framework<br/>
>.Security.framework<br/>
>.libz.dylib<br/>

<br/><br/>
#### 2. 项目配置
>. (1) Search Paths 下的 User Header Search Paths 和 Library Search Paths为`$(PROJECT_DIR)/CoreJPush/CoreJPush/Lib`。<br/>
>. (2) 选中Project-Target-Capabilities-Background Modes,勾选Remote Notifications。<br/>
>. (3) 请修改CoreJPush框架内Common文件夹下PushConfig.plist的Appkey为您的Appkey。<br/>

<br/><br/><br/>
#### 二.光速集成

#### 1.注册JPush（一句代码）
请删除您的AppDelgate中所有有关推送的方法，因为CoreJPush内部已经封装。

    #import "CoreJPush.h"
    //注册JPush
    [CoreJPush registerJPush:launchOptions];
    
<br/><br/>
#### 2.突破空间限制，在您任意想监听通知的页面，一句代码监听通知：

      //添加一个监听者：此监听者是遵循了CoreJPushProtocol协议
      [CoreJPush addJPushListener:self];
      //当然，你需要在合适的地方（比如dealloc），移除监听者
      [CoreJPush removeJPushListener:self];
      
      //您已经遵循了CoreJPushProtocol协议，直接在.m文件里面敲did，xcode会提示你如下方法：
      -(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
          
          NSLog(@"ViewController: %@",userInfo);
          
      }

### 完

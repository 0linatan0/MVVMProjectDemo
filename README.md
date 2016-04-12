# MVVMProjectDemo
模仿login动画登陆，采用MVVM编写获取书单列表，根据输入的文字进行过滤
##登陆动画
模仿的是 [ios layer animation](http://www.cocoachina.com/ios/20150521/11874.html)中的demo，原文是用swift编写，在自己理解用Objective-c实现，采用了原来文件中的照片素材。主要是利用layer animation进行动画绘制。如下是整个交互过程

![交互录制图](http://7xrh2s.com1.z0.glb.clouddn.com/iosmvvmDemo.gif)

此次项目界面是用了storyboard进行构建，以下简略说明有哪些元素需要动画，具体可以参见代码

1. Login 按钮动画组
2. 四片云朵的图片动画组
3. 点击按钮后：Login按钮下移，气球出现，验证过程的banner出现
4. 失败后，Login按钮还原，banner消失，BookShelf抖动
5. 成功后，进入书单列表页

###新知识点
这次动画实现主要是用了CABasicAnimation，CAAnimationGroup，CAKeyframeAnimation，和UIViewAnimation进行实现，介绍下新接触的一些知识点。

使用spring animation来构建,是一种特殊的曲线,ios本身有很多动画都是使用spring,[参考](http://www.renfei.org/blog/ios-8-spring-animation.html)

~~~
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
     usingSpringWithDamping:(CGFloat)dampingRatio
      initialSpringVelocity:(CGFloat)velocity
                    options:(UIViewAnimationOptions)options
                 animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion
~~~

使用UIActivityIndicatorView实现转菊花，查阅资料上说用这个的很少了，大多都是用第三方库，不过这次尝试了下，觉得还不错

~~~
_loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//UIActivityIndicatorViewStyleWhiteLarge  //大白
//UIActivityIndicatorViewStyleWhite       //小白
//UIActivityIndicatorViewStyleGray        //小灰
[_loading startAnimating];
_loading.frame = CGRectMake(0.0, 6.0, 20.0, 20.0);
_loading.center = CGPointMake(40.0,_loginBtn.frame.size.height/2);
_loading.alpha = 1.0;
[_loginBtn addSubview:_loading];
~~~

因为在动画中，四片小白云在动画结束后，还要继续漂浮，不能使用autoreverses,云朵位置不是同一个，所以要在云朵动画结束的时候，进行修改，需要重写animationDidStop:finished

~~~
//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag)
    {
        NSLog(@"animation did finish");
        NSString *name = [anim valueForKey:@"name"];
        //......
        if ([name isEqualToString:@"cloud"])
        {
            CALayer *layer = [anim valueForKey:@"layer"];
            [anim setValue:nil forKey:@"layer"];
            CGPoint position = layer.position;
            position.x = -layer.bounds.size.width/2;
            layer.position = position;
            [TLAnimationHandler delayWithSeconds:0.5 withCompletion:^{
                [self animateCloudInLayer:layer];
            }];
        }
    }
}
~~~

##利用MVVM实现书单列表页
MVVM最主要的特点是其有viewModel，其处理了原本我们放在viewController中的处理逻辑，在项目中使用了书单列表的例子理解不同。

在查阅MVVM实现时，很多人都说到要用ReactiveCocoa框架,但是使用MVVM不一定需要用ReactiveCocoa，也有一篇博文[用KVO实现MVVM](http://www.jianshu.com/p/dbe1426df69e),其项目代码见[git地址](https://github.com/britzlieg/MVVMDemo/tree/master);只不过ReactiveCocoa为事件定义了一个标准接口，从而可以使用一些基本工具来更容易的连接、过滤和组合。比如原先使用的target-action、delegate、KVO、callback等都有着不同的处理方式。我对ReactiveCocoa进行了下初步了解，在项目中尝试了下

1. 添加ReactiveCocoa框架，一种简单方式先要安装cocoaPods[教程](http://blog.csdn.net/showhilllee/article/details/38398119/)
2. 了解下最基本的使用 [介绍](http://www.infoq.com/cn/articles/reactivecocoa-ios-new-develop-framework) [入门1](http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1) [入门2](http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part2)
3. 借鉴别人用ReactiveCocoa实现MVVM demo，[博文地址](http://www.ios122.com/2015/10/mvvm_2/)

接下来，自己动手来实现，场景是读取书单文件内容，将其展示到tableView中；在文本框中输入字符，tableView中实时显示包含字符的书单列表。项目目录结构

<img src="http://7xrh2s.com1.z0.glb.clouddn.com/iosMVVM%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png" width = "210" height = "350" alt="目录结构" align="center" />

有些文件前缀忘记加上=。=|| 其中Handler中对动画处理的方法；Model中TLUser是用户类，处理登陆名和密码是否正确，这边还未涉及数据库和网络请求；Book是对应每本书信息，书名和出版时间；viewController中ViewController是处理登陆页面逻辑和动画展示，BookListViewController是对应书单列表展示，还有输入框；view暂时没有，使用storyboard构建界面；viewModel中TLLoginViewModel，调用TLUser中方法判断是否可以登陆，考虑如果是查询数据库验证时，可以将这部分逻辑放到TLLoginViewModel；TLBookListViewModel对应tableview中的数据源有TLBookItemViewModel的数组对象，

~~~
@property (nonatomic,strong)NSArray<TLBookItemViewModel *>*bookItemList;
~~~
TLBookItemViewModel则是对应每个cell的viewModel,因为cell可以有点击事件，所以这边是用TLBookItemViewModel，其有一个属性是bookId,对应每本书的bookId,也便于之后请求数据；还有个属性是desc，是用于cell上显示；其是用book初始化，这边用到ReactiveCocoa，将book和TLBookItemViewModel绑定，book数据变化，desc也会变化;但其实我们也可以不这么写，可以就用普通的赋值，这边可以当做感受下RAC的编写方式。

~~~
- (instancetype)initWithBook:(Book *)book
{
    self = [super init];
    if (self)
    {
        RAC(self, desc) = [RACSignal combineLatest:@[RACObserve(book, name), RACObserve(book, publisDate)] reduce:^id(NSString * title, NSString * desc){
            NSString * descInfo = [NSString stringWithFormat: @"书名:%@ 出版日期:%@", book.name , book.publisDate];
            return descInfo;
        }];
        // 设置self.bookId与book.bookId的相互关系.
        [RACObserve(book, bookId) subscribeNext:^(id x) {
            self.bookId = x;
        }];
    }
    return self;
}
~~~

在BookListViewController中需要注意的是，通过订阅输入框rac_textSignal的变化来调用viewModel中过滤书单列表，并重新更新。

~~~
    [_searchText.rac_textSignal
     subscribeNext:^(id x){
        [_bookListViewModel search:x];
        [self updateView];
    }];
~~~

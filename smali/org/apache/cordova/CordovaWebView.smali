.class public Lorg/apache/cordova/CordovaWebView;
.super Landroid/webkit/WebView;
.source "CordovaWebView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/cordova/CordovaWebView$Level16Apis;,
        Lorg/apache/cordova/CordovaWebView$ActivityResult;
    }
.end annotation


# static fields
.field static final COVER_SCREEN_GRAVITY_CENTER:Landroid/widget/FrameLayout$LayoutParams;

.field public static final TAG:Ljava/lang/String; = "CordovaWebView"


# instance fields
.field baseUrl:Ljava/lang/String;

.field private bound:Z

.field private chromeClient:Lorg/apache/cordova/CordovaChromeClient;

.field private cordova:Lorg/apache/cordova/api/CordovaInterface;

.field exposedJsApi:Lorg/apache/cordova/ExposedJsApi;

.field private handleButton:Z

.field jsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

.field private keyDownCodes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private keyUpCodes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private lastMenuEventTime:J

.field loadUrlTimeout:I

.field private mCustomView:Landroid/view/View;

.field private mCustomViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

.field private mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

.field private paused:Z

.field public pluginManager:Lorg/apache/cordova/api/PluginManager;

.field private receiver:Landroid/content/BroadcastReceiver;

.field private url:Ljava/lang/String;

.field private urls:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field useBrowserHistory:Z

.field viewClient:Lorg/apache/cordova/CordovaWebViewClient;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, -0x1

    .line 117
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v1, 0x11

    invoke-direct {v0, v2, v2, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    sput-object v0, Lorg/apache/cordova/CordovaWebView;->COVER_SCREEN_GRAVITY_CENTER:Landroid/widget/FrameLayout$LayoutParams;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .line 129
    invoke-direct {p0, p1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    .line 62
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    .line 80
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    .line 82
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    .line 85
    iput v1, p0, Lorg/apache/cordova/CordovaWebView;->loadUrlTimeout:I

    .line 89
    iput-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->handleButton:Z

    .line 91
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    .line 100
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

    .line 130
    const-class v0, Lorg/apache/cordova/api/CordovaInterface;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 132
    check-cast p1, Lorg/apache/cordova/api/CordovaInterface;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    .line 138
    :goto_0
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->loadConfiguration()V

    .line 139
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->setup()V

    .line 140
    return-void

    .line 136
    .restart local p1    # "context":Landroid/content/Context;
    :cond_0
    const-string v0, "CordovaWebView"

    const-string v1, "Your activity must implement CordovaInterface to work"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    const/4 v1, 0x0

    .line 149
    invoke-direct {p0, p1, p2}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 62
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    .line 80
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    .line 82
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    .line 85
    iput v1, p0, Lorg/apache/cordova/CordovaWebView;->loadUrlTimeout:I

    .line 89
    iput-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->handleButton:Z

    .line 91
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    .line 100
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

    .line 150
    const-class v0, Lorg/apache/cordova/api/CordovaInterface;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 152
    check-cast p1, Lorg/apache/cordova/api/CordovaInterface;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    .line 158
    :goto_0
    new-instance v0, Lorg/apache/cordova/CordovaChromeClient;

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v0, v1, p0}, Lorg/apache/cordova/CordovaChromeClient;-><init>(Lorg/apache/cordova/api/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->setWebChromeClient(Lorg/apache/cordova/CordovaChromeClient;)V

    .line 159
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {p0, v0}, Lorg/apache/cordova/CordovaWebView;->initWebViewClient(Lorg/apache/cordova/api/CordovaInterface;)V

    .line 160
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->loadConfiguration()V

    .line 161
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->setup()V

    .line 162
    return-void

    .line 156
    .restart local p1    # "context":Landroid/content/Context;
    :cond_0
    const-string v0, "CordovaWebView"

    const-string v1, "Your activity must implement CordovaInterface to work"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    const/4 v1, 0x0

    .line 173
    invoke-direct {p0, p1, p2, p3}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 62
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    .line 80
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    .line 82
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    .line 85
    iput v1, p0, Lorg/apache/cordova/CordovaWebView;->loadUrlTimeout:I

    .line 89
    iput-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->handleButton:Z

    .line 91
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    .line 100
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

    .line 174
    const-class v0, Lorg/apache/cordova/api/CordovaInterface;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 176
    check-cast p1, Lorg/apache/cordova/api/CordovaInterface;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    .line 182
    :goto_0
    new-instance v0, Lorg/apache/cordova/CordovaChromeClient;

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v0, v1, p0}, Lorg/apache/cordova/CordovaChromeClient;-><init>(Lorg/apache/cordova/api/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->setWebChromeClient(Lorg/apache/cordova/CordovaChromeClient;)V

    .line 183
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->loadConfiguration()V

    .line 184
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->setup()V

    .line 185
    return-void

    .line 180
    .restart local p1    # "context":Landroid/content/Context;
    :cond_0
    const-string v0, "CordovaWebView"

    const-string v1, "Your activity must implement CordovaInterface to work"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;IZ)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I
    .param p4, "privateBrowsing"    # Z
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 197
    invoke-direct {p0, p1, p2, p3, p4}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;IZ)V

    .line 62
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    .line 80
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    .line 82
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    .line 85
    iput v1, p0, Lorg/apache/cordova/CordovaWebView;->loadUrlTimeout:I

    .line 89
    iput-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->handleButton:Z

    .line 91
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    .line 100
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

    .line 198
    const-class v0, Lorg/apache/cordova/api/CordovaInterface;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 200
    check-cast p1, Lorg/apache/cordova/api/CordovaInterface;

    .end local p1    # "context":Landroid/content/Context;
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    .line 206
    :goto_0
    new-instance v0, Lorg/apache/cordova/CordovaChromeClient;

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v0, v1}, Lorg/apache/cordova/CordovaChromeClient;-><init>(Lorg/apache/cordova/api/CordovaInterface;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->setWebChromeClient(Lorg/apache/cordova/CordovaChromeClient;)V

    .line 207
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {p0, v0}, Lorg/apache/cordova/CordovaWebView;->initWebViewClient(Lorg/apache/cordova/api/CordovaInterface;)V

    .line 208
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->loadConfiguration()V

    .line 209
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->setup()V

    .line 210
    return-void

    .line 204
    .restart local p1    # "context":Landroid/content/Context;
    :cond_0
    const-string v0, "CordovaWebView"

    const-string v1, "Your activity must implement CordovaInterface to work"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static synthetic access$000(Lorg/apache/cordova/CordovaWebView;)V
    .locals 0
    .param p0, "x0"    # Lorg/apache/cordova/CordovaWebView;

    .prologue
    .line 58
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->updateUserAgentString()V

    return-void
.end method

.method static synthetic access$100(Lorg/apache/cordova/CordovaWebView;)Lorg/apache/cordova/api/CordovaInterface;
    .locals 1
    .param p0, "x0"    # Lorg/apache/cordova/CordovaWebView;

    .prologue
    .line 58
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    return-object v0
.end method

.method private exposeJsInterface()V
    .locals 4

    .prologue
    const/16 v3, 0xb

    .line 308
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 309
    .local v0, "SDK_INT":I
    if-lt v0, v3, :cond_1

    const/16 v2, 0xd

    if-gt v0, v2, :cond_1

    const/4 v1, 0x1

    .line 310
    .local v1, "isHoneycomb":Z
    :goto_0
    if-nez v1, :cond_0

    const/16 v2, 0x9

    if-ge v0, v2, :cond_2

    .line 311
    :cond_0
    const-string v2, "CordovaWebView"

    const-string v3, "Disabled addJavascriptInterface() bridge since Android version is old."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    :goto_1
    return-void

    .line 309
    .end local v1    # "isHoneycomb":Z
    :cond_1
    const/4 v1, 0x0

    goto :goto_0

    .line 316
    .restart local v1    # "isHoneycomb":Z
    :cond_2
    if-ge v0, v3, :cond_3

    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v3, "unknown"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 318
    const-string v2, "CordovaWebView"

    const-string v3, "Disabled addJavascriptInterface() bridge callback due to a bug on the 2.3 emulator"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 321
    :cond_3
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->exposedJsApi:Lorg/apache/cordova/ExposedJsApi;

    const-string v3, "_cordovaNative"

    invoke-virtual {p0, v2, v3}, Lorg/apache/cordova/CordovaWebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_1
.end method

.method private initWebViewClient(Lorg/apache/cordova/api/CordovaInterface;)V
    .locals 2
    .param p1, "cordova"    # Lorg/apache/cordova/api/CordovaInterface;

    .prologue
    .line 214
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-ge v0, v1, :cond_0

    .line 216
    new-instance v0, Lorg/apache/cordova/CordovaWebViewClient;

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v0, v1, p0}, Lorg/apache/cordova/CordovaWebViewClient;-><init>(Lorg/apache/cordova/api/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->setWebViewClient(Lorg/apache/cordova/CordovaWebViewClient;)V

    .line 222
    :goto_0
    return-void

    .line 220
    :cond_0
    new-instance v0, Lorg/apache/cordova/IceCreamCordovaWebViewClient;

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v0, v1, p0}, Lorg/apache/cordova/IceCreamCordovaWebViewClient;-><init>(Lorg/apache/cordova/api/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->setWebViewClient(Lorg/apache/cordova/CordovaWebViewClient;)V

    goto :goto_0
.end method

.method private loadConfiguration()V
    .locals 4

    .prologue
    const/16 v3, 0x400

    .line 663
    const-string v0, "false"

    const-string v1, "useBrowserHistory"

    const-string v2, "true"

    invoke-virtual {p0, v1, v2}, Lorg/apache/cordova/CordovaWebView;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 666
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    .line 667
    const-string v0, "CordovaWebView"

    const-string v1, "useBrowserHistory=false is deprecated as of Cordova 2.2.0 and will be removed six months after the 2.2.0 release.  Please use the browser history and use history.back()."

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 670
    :cond_0
    const-string v0, "true"

    const-string v1, "fullscreen"

    const-string v2, "false"

    invoke-virtual {p0, v1, v2}, Lorg/apache/cordova/CordovaWebView;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 671
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x800

    invoke-virtual {v0, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 672
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3, v3}, Landroid/view/Window;->setFlags(II)V

    .line 674
    :cond_1
    return-void
.end method

.method private setup()V
    .locals 13
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .prologue
    const/4 v12, 0x0

    const/4 v11, 0x1

    .line 230
    invoke-virtual {p0, v12}, Lorg/apache/cordova/CordovaWebView;->setInitialScale(I)V

    .line 231
    invoke-virtual {p0, v12}, Lorg/apache/cordova/CordovaWebView;->setVerticalScrollBarEnabled(Z)V

    .line 232
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->requestFocusFromTouch()Z

    .line 235
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    .line 236
    .local v5, "settings":Landroid/webkit/WebSettings;
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 237
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 238
    sget-object v6, Landroid/webkit/WebSettings$LayoutAlgorithm;->NORMAL:Landroid/webkit/WebSettings$LayoutAlgorithm;

    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setLayoutAlgorithm(Landroid/webkit/WebSettings$LayoutAlgorithm;)V

    .line 242
    :try_start_0
    const-class v6, Landroid/webkit/WebSettings;

    const-string v7, "setNavDump"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Class;

    const/4 v9, 0x0

    sget-object v10, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v10, v8, v9

    invoke-virtual {v6, v7, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 243
    .local v2, "gingerbread_getMethod":Ljava/lang/reflect/Method;
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0xb

    if-ge v6, v7, :cond_0

    .line 245
    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-virtual {v2, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_3

    .line 259
    .end local v2    # "gingerbread_getMethod":Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0xf

    if-le v6, v7, :cond_1

    .line 260
    invoke-static {v5}, Lorg/apache/cordova/CordovaWebView$Level16Apis;->enableUniversalAccess(Landroid/webkit/WebSettings;)V

    .line 262
    :cond_1
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 263
    iget-object v6, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v6}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v6

    invoke-virtual {v6}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    const-string v7, "database"

    invoke-virtual {v6, v7, v12}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 264
    .local v0, "databasePath":Ljava/lang/String;
    invoke-virtual {v5, v0}, Landroid/webkit/WebSettings;->setDatabasePath(Ljava/lang/String;)V

    .line 265
    invoke-virtual {v5, v0}, Landroid/webkit/WebSettings;->setGeolocationDatabasePath(Ljava/lang/String;)V

    .line 268
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 271
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setGeolocationEnabled(Z)V

    .line 275
    const-wide/32 v6, 0x500000

    invoke-virtual {v5, v6, v7}, Landroid/webkit/WebSettings;->setAppCacheMaxSize(J)V

    .line 276
    iget-object v6, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v6}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v6

    invoke-virtual {v6}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    const-string v7, "database"

    invoke-virtual {v6, v7, v12}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    .line 277
    .local v4, "pathToCache":Ljava/lang/String;
    invoke-virtual {v5, v4}, Landroid/webkit/WebSettings;->setAppCachePath(Ljava/lang/String;)V

    .line 278
    invoke-virtual {v5, v11}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    .line 282
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->updateUserAgentString()V

    .line 284
    new-instance v3, Landroid/content/IntentFilter;

    invoke-direct {v3}, Landroid/content/IntentFilter;-><init>()V

    .line 285
    .local v3, "intentFilter":Landroid/content/IntentFilter;
    const-string v6, "android.intent.action.CONFIGURATION_CHANGED"

    invoke-virtual {v3, v6}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 286
    iget-object v6, p0, Lorg/apache/cordova/CordovaWebView;->receiver:Landroid/content/BroadcastReceiver;

    if-nez v6, :cond_2

    .line 287
    new-instance v6, Lorg/apache/cordova/CordovaWebView$1;

    invoke-direct {v6, p0}, Lorg/apache/cordova/CordovaWebView$1;-><init>(Lorg/apache/cordova/CordovaWebView;)V

    iput-object v6, p0, Lorg/apache/cordova/CordovaWebView;->receiver:Landroid/content/BroadcastReceiver;

    .line 293
    iget-object v6, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v6}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v6

    iget-object v7, p0, Lorg/apache/cordova/CordovaWebView;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v6, v7, v3}, Landroid/app/Activity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 297
    :cond_2
    new-instance v6, Lorg/apache/cordova/api/PluginManager;

    iget-object v7, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v6, p0, v7}, Lorg/apache/cordova/api/PluginManager;-><init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/api/CordovaInterface;)V

    iput-object v6, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    .line 298
    new-instance v6, Lorg/apache/cordova/NativeToJsMessageQueue;

    iget-object v7, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-direct {v6, p0, v7}, Lorg/apache/cordova/NativeToJsMessageQueue;-><init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/api/CordovaInterface;)V

    iput-object v6, p0, Lorg/apache/cordova/CordovaWebView;->jsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    .line 299
    new-instance v6, Lorg/apache/cordova/ExposedJsApi;

    iget-object v7, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    iget-object v8, p0, Lorg/apache/cordova/CordovaWebView;->jsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-direct {v6, v7, v8}, Lorg/apache/cordova/ExposedJsApi;-><init>(Lorg/apache/cordova/api/PluginManager;Lorg/apache/cordova/NativeToJsMessageQueue;)V

    iput-object v6, p0, Lorg/apache/cordova/CordovaWebView;->exposedJsApi:Lorg/apache/cordova/ExposedJsApi;

    .line 300
    invoke-direct {p0}, Lorg/apache/cordova/CordovaWebView;->exposeJsInterface()V

    .line 301
    return-void

    .line 247
    .end local v0    # "databasePath":Ljava/lang/String;
    .end local v3    # "intentFilter":Landroid/content/IntentFilter;
    .end local v4    # "pathToCache":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 248
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    const-string v6, "CordovaWebView"

    const-string v7, "We are on a modern version of Android, we will deprecate HTC 2.3 devices in 2.8"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 249
    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    :catch_1
    move-exception v1

    .line 250
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    const-string v6, "CordovaWebView"

    const-string v7, "Doing the NavDump failed with bad arguments"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 251
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v1

    .line 252
    .local v1, "e":Ljava/lang/IllegalAccessException;
    const-string v6, "CordovaWebView"

    const-string v7, "This should never happen: IllegalAccessException means this isn\'t Android anymore"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 253
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v1

    .line 254
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    const-string v6, "CordovaWebView"

    const-string v7, "This should never happen: InvocationTargetException means this isn\'t Android anymore."

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method private updateUserAgentString()V
    .locals 1

    .prologue
    .line 304
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebSettings;->getUserAgentString()Ljava/lang/String;

    .line 305
    return-void
.end method


# virtual methods
.method public backHistory()Z
    .locals 3

    .prologue
    const/4 v1, 0x1

    .line 564
    invoke-super {p0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-boolean v2, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    if-eqz v2, :cond_0

    .line 565
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->printBackForwardList()V

    .line 566
    invoke-super {p0}, Landroid/webkit/WebView;->goBack()V

    .line 578
    :goto_0
    return v1

    .line 571
    :cond_0
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->size()I

    move-result v2

    if-le v2, v1, :cond_1

    iget-boolean v2, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    if-nez v2, :cond_1

    .line 572
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    .line 573
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 574
    .local v0, "url":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_0

    .line 578
    .end local v0    # "url":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public bindButton(IZZ)V
    .locals 2
    .param p1, "keyCode"    # I
    .param p2, "keyDown"    # Z
    .param p3, "override"    # Z

    .prologue
    .line 805
    if-eqz p2, :cond_0

    .line 807
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 813
    :goto_0
    return-void

    .line 811
    :cond_0
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public bindButton(Ljava/lang/String;Z)V
    .locals 2
    .param p1, "button"    # Ljava/lang/String;
    .param p2, "override"    # Z

    .prologue
    .line 796
    const-string v0, "volumeup"

    invoke-virtual {p1, v0}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    .line 797
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    const/16 v1, 0x18

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 802
    :cond_0
    :goto_0
    return-void

    .line 799
    :cond_1
    const-string v0, "volumedown"

    invoke-virtual {p1, v0}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 800
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    const/16 v1, 0x19

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public bindButton(Z)V
    .locals 0
    .param p1, "override"    # Z

    .prologue
    .line 791
    iput-boolean p1, p0, Lorg/apache/cordova/CordovaWebView;->bound:Z

    .line 792
    return-void
.end method

.method public canGoBack()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 587
    invoke-super {p0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    if-eqz v1, :cond_1

    .line 593
    :cond_0
    :goto_0
    return v0

    .line 590
    :cond_1
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-gt v1, v0, :cond_0

    .line 593
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;

    .prologue
    .line 684
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v2}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    .line 685
    .local v0, "bundle":Landroid/os/Bundle;
    if-nez v0, :cond_1

    .line 692
    .end local p2    # "defaultValue":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p2

    .line 688
    .restart local p2    # "defaultValue":Ljava/lang/String;
    :cond_1
    invoke-virtual {v0, p1}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 689
    .local v1, "p":Ljava/lang/Object;
    if-eqz v1, :cond_0

    .line 692
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_0
.end method

.method public getWebChromeClient()Lorg/apache/cordova/CordovaChromeClient;
    .locals 1

    .prologue
    .line 345
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->chromeClient:Lorg/apache/cordova/CordovaChromeClient;

    return-object v0
.end method

.method public hadKeyEvent()Z
    .locals 1

    .prologue
    .line 893
    iget-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->handleButton:Z

    return v0
.end method

.method public handleDestroy()V
    .locals 4

    .prologue
    .line 859
    const-string v1, "javascript:try{cordova.require(\'cordova/channel\').onDestroy.fire();}catch(e){console.log(\'exception firing destroy event from native\');};"

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;)V

    .line 862
    const-string v1, "about:blank"

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 865
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    if-eqz v1, :cond_0

    .line 866
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v1}, Lorg/apache/cordova/api/PluginManager;->onDestroy()V

    .line 870
    :cond_0
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->receiver:Landroid/content/BroadcastReceiver;

    if-eqz v1, :cond_1

    .line 872
    :try_start_0
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2}, Landroid/app/Activity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 877
    :cond_1
    :goto_0
    return-void

    .line 873
    :catch_0
    move-exception v0

    .line 874
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "CordovaWebView"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error unregistering configuration receiver: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public handlePause(Z)V
    .locals 2
    .param p1, "keepRunning"    # Z

    .prologue
    .line 822
    const-string v0, "CordovaWebView"

    const-string v1, "Handle the pause"

    invoke-static {v0, v1}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 824
    const-string v0, "javascript:try{cordova.fireDocumentEvent(\'pause\');}catch(e){console.log(\'exception firing pause event from native\');};"

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 827
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    if-eqz v0, :cond_0

    .line 828
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/api/PluginManager;->onPause(Z)V

    .line 832
    :cond_0
    if-nez p1, :cond_1

    .line 834
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->pauseTimers()V

    .line 836
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->paused:Z

    .line 838
    return-void
.end method

.method public handleResume(ZZ)V
    .locals 1
    .param p1, "keepRunning"    # Z
    .param p2, "activityResultKeepRunning"    # Z

    .prologue
    .line 843
    const-string v0, "javascript:try{cordova.fireDocumentEvent(\'resume\');}catch(e){console.log(\'exception firing resume event from native\');};"

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 846
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    if-eqz v0, :cond_0

    .line 847
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/api/PluginManager;->onResume(Z)V

    .line 851
    :cond_0
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->resumeTimers()V

    .line 852
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->paused:Z

    .line 853
    return-void
.end method

.method public hideCustomView()V
    .locals 3

    .prologue
    .line 959
    const-string v1, "CordovaWebView"

    const-string v2, "Hidding Custom View"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 960
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    if-nez v1, :cond_0

    .line 973
    :goto_0
    return-void

    .line 963
    :cond_0
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 966
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 967
    .local v0, "parent":Landroid/view/ViewGroup;
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 968
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    .line 969
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    invoke-interface {v1}, Landroid/webkit/WebChromeClient$CustomViewCallback;->onCustomViewHidden()V

    .line 972
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->setVisibility(I)V

    goto :goto_0
.end method

.method public isBackButtonBound()Z
    .locals 1

    .prologue
    .line 817
    iget-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->bound:Z

    return v0
.end method

.method public isCustomViewShowing()Z
    .locals 1

    .prologue
    .line 982
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isPaused()Z
    .locals 1

    .prologue
    .line 889
    iget-boolean v0, p0, Lorg/apache/cordova/CordovaWebView;->paused:Z

    return v0
.end method

.method public loadUrl(Ljava/lang/String;)V
    .locals 3
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 355
    const-string v1, "about:blank"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "javascript:"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 356
    :cond_0
    invoke-virtual {p0, p1}, Lorg/apache/cordova/CordovaWebView;->loadUrlNow(Ljava/lang/String;)V

    .line 371
    :goto_0
    return-void

    .line 360
    :cond_1
    const-string v1, "url"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lorg/apache/cordova/CordovaWebView;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 363
    .local v0, "initUrl":Ljava/lang/String;
    if-eqz v0, :cond_2

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-lez v1, :cond_3

    .line 364
    :cond_2
    invoke-virtual {p0, p1}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;)V

    goto :goto_0

    .line 368
    :cond_3
    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public loadUrl(Ljava/lang/String;I)V
    .locals 3
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "time"    # I

    .prologue
    .line 381
    const-string v1, "url"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lorg/apache/cordova/CordovaWebView;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 384
    .local v0, "initUrl":Ljava/lang/String;
    if-eqz v0, :cond_0

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 385
    :cond_0
    invoke-virtual {p0, p1, p2}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;I)V

    .line 391
    :goto_0
    return-void

    .line 389
    :cond_1
    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public loadUrlIntoView(Ljava/lang/String;)V
    .locals 9
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 399
    const-string v1, "CordovaWebView"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, ">>> loadUrl("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ")"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v1, v7}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 401
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->url:Ljava/lang/String;

    .line 402
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->baseUrl:Ljava/lang/String;

    if-nez v1, :cond_0

    .line 403
    const/16 v1, 0x2f

    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v6

    .line 404
    .local v6, "i":I
    if-lez v6, :cond_1

    .line 405
    const/4 v1, 0x0

    add-int/lit8 v7, v6, 0x1

    invoke-virtual {p1, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/cordova/CordovaWebView;->baseUrl:Ljava/lang/String;

    .line 411
    :goto_0
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v1}, Lorg/apache/cordova/api/PluginManager;->init()V

    .line 413
    iget-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    if-nez v1, :cond_0

    .line 414
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v1, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 419
    .end local v6    # "i":I
    :cond_0
    move-object v3, p0

    .line 420
    .local v3, "me":Lorg/apache/cordova/CordovaWebView;
    iget v4, v3, Lorg/apache/cordova/CordovaWebView;->loadUrlTimeout:I

    .line 421
    .local v4, "currentLoadUrlTimeout":I
    const-string v1, "loadUrlTimeoutValue"

    const-string v7, "20000"

    invoke-virtual {p0, v1, v7}, Lorg/apache/cordova/CordovaWebView;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    .line 424
    .local v2, "loadUrlTimeoutValue":I
    new-instance v5, Lorg/apache/cordova/CordovaWebView$2;

    invoke-direct {v5, p0, v3, p1}, Lorg/apache/cordova/CordovaWebView$2;-><init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaWebView;Ljava/lang/String;)V

    .line 435
    .local v5, "loadError":Ljava/lang/Runnable;
    new-instance v0, Lorg/apache/cordova/CordovaWebView$3;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lorg/apache/cordova/CordovaWebView$3;-><init>(Lorg/apache/cordova/CordovaWebView;ILorg/apache/cordova/CordovaWebView;ILjava/lang/Runnable;)V

    .line 453
    .local v0, "timeoutCheck":Ljava/lang/Runnable;
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v1

    new-instance v7, Lorg/apache/cordova/CordovaWebView$4;

    invoke-direct {v7, p0, v0, v3, p1}, Lorg/apache/cordova/CordovaWebView$4;-><init>(Lorg/apache/cordova/CordovaWebView;Ljava/lang/Runnable;Lorg/apache/cordova/CordovaWebView;Ljava/lang/String;)V

    invoke-virtual {v1, v7}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 460
    return-void

    .line 408
    .end local v0    # "timeoutCheck":Ljava/lang/Runnable;
    .end local v2    # "loadUrlTimeoutValue":I
    .end local v3    # "me":Lorg/apache/cordova/CordovaWebView;
    .end local v4    # "currentLoadUrlTimeout":I
    .end local v5    # "loadError":Ljava/lang/Runnable;
    .restart local v6    # "i":I
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p0, Lorg/apache/cordova/CordovaWebView;->url:Ljava/lang/String;

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v7, "/"

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/cordova/CordovaWebView;->baseUrl:Ljava/lang/String;

    goto :goto_0
.end method

.method public loadUrlIntoView(Ljava/lang/String;I)V
    .locals 5
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "time"    # I

    .prologue
    .line 487
    const-string v0, "javascript:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v0

    if-gtz v0, :cond_0

    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->canGoBack()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 500
    :cond_0
    :goto_0
    invoke-virtual {p0, p1}, Lorg/apache/cordova/CordovaWebView;->loadUrlIntoView(Ljava/lang/String;)V

    .line 501
    return-void

    .line 493
    :cond_1
    const-string v0, "CordovaWebView"

    const-string v1, "DroidGap.loadUrl(%s, %d)"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 v3, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 496
    const-string v0, "splashscreen"

    const-string v1, "show"

    invoke-virtual {p0, v0, v1}, Lorg/apache/cordova/CordovaWebView;->postMessage(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0
.end method

.method loadUrlNow(Ljava/lang/String;)V
    .locals 2
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 468
    const/4 v0, 0x3

    invoke-static {v0}, Lorg/apache/cordova/api/LOG;->isLoggable(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "javascript:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 469
    const-string v0, "CordovaWebView"

    const-string v1, ">>> loadUrlNow()"

    invoke-static {v0, v1}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 471
    :cond_0
    const-string v0, "file://"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->baseUrl:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "javascript:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lorg/apache/cordova/Config;->isUrlWhiteListed(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 472
    :cond_1
    invoke-super {p0, p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 474
    :cond_2
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 4
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 701
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->keyDownCodes:Ljava/util/ArrayList;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 703
    const/16 v0, 0x19

    if-ne p1, v0, :cond_0

    .line 705
    const-string v0, "CordovaWebView"

    const-string v2, "Down Key Hit"

    invoke-static {v0, v2}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 706
    const-string v0, "javascript:cordova.fireDocumentEvent(\'volumedownbutton\');"

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 731
    :goto_0
    return v1

    .line 710
    :cond_0
    const/16 v0, 0x18

    if-ne p1, v0, :cond_1

    .line 711
    const-string v0, "CordovaWebView"

    const-string v2, "Up Key Hit"

    invoke-static {v0, v2}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 712
    const-string v0, "javascript:cordova.fireDocumentEvent(\'volumeupbutton\');"

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_0

    .line 717
    :cond_1
    invoke-super {p0, p1, p2}, Landroid/webkit/WebView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v1

    goto :goto_0

    .line 720
    :cond_2
    const/4 v2, 0x4

    if-ne p1, v2, :cond_8

    .line 725
    iget-boolean v2, p0, Lorg/apache/cordova/CordovaWebView;->useBrowserHistory:Z

    if-eqz v2, :cond_5

    .line 726
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->startOfHistory()Z

    move-result v2

    if-eqz v2, :cond_3

    iget-boolean v2, p0, Lorg/apache/cordova/CordovaWebView;->bound:Z

    if-eqz v2, :cond_4

    :cond_3
    move v0, v1

    :cond_4
    move v1, v0

    goto :goto_0

    .line 728
    :cond_5
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->size()I

    move-result v2

    if-gt v2, v1, :cond_6

    iget-boolean v2, p0, Lorg/apache/cordova/CordovaWebView;->bound:Z

    if-eqz v2, :cond_7

    :cond_6
    move v0, v1

    :cond_7
    move v1, v0

    goto :goto_0

    .line 731
    :cond_8
    invoke-super {p0, p1, p2}, Landroid/webkit/WebView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v1

    goto :goto_0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 4
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v0, 0x1

    .line 739
    const/4 v1, 0x4

    if-ne p1, v1, :cond_4

    .line 741
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    if-eqz v1, :cond_2

    .line 742
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->hideCustomView()V

    .line 785
    :cond_0
    :goto_0
    invoke-super {p0, p1, p2}, Landroid/webkit/WebView;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    :cond_1
    :goto_1
    return v0

    .line 746
    :cond_2
    iget-boolean v1, p0, Lorg/apache/cordova/CordovaWebView;->bound:Z

    if-eqz v1, :cond_3

    .line 747
    const-string v1, "javascript:cordova.fireDocumentEvent(\'backbutton\');"

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_1

    .line 752
    :cond_3
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->backHistory()Z

    move-result v1

    if-nez v1, :cond_1

    .line 760
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    goto :goto_0

    .line 766
    :cond_4
    const/16 v1, 0x52

    if-ne p1, v1, :cond_6

    .line 767
    iget-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getEventTime()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-gez v0, :cond_5

    .line 768
    const-string v0, "javascript:cordova.fireDocumentEvent(\'menubutton\');"

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 770
    :cond_5
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getEventTime()J

    move-result-wide v0

    iput-wide v0, p0, Lorg/apache/cordova/CordovaWebView;->lastMenuEventTime:J

    .line 771
    invoke-super {p0, p1, p2}, Landroid/webkit/WebView;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_1

    .line 774
    :cond_6
    const/16 v1, 0x54

    if-ne p1, v1, :cond_7

    .line 775
    const-string v1, "javascript:cordova.fireDocumentEvent(\'searchbutton\');"

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_1

    .line 778
    :cond_7
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->keyUpCodes:Ljava/util/ArrayList;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 781
    invoke-super {p0, p1, p2}, Landroid/webkit/WebView;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_1
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 882
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    if-eqz v0, :cond_0

    .line 883
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/api/PluginManager;->onNewIntent(Landroid/content/Intent;)V

    .line 885
    :cond_0
    return-void
.end method

.method public peekAtUrlStack()Ljava/lang/String;
    .locals 1

    .prologue
    .line 540
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 541
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 543
    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public postMessage(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/Object;

    .prologue
    .line 530
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    if-eqz v0, :cond_0

    .line 531
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v0, p1, p2}, Lorg/apache/cordova/api/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 533
    :cond_0
    return-void
.end method

.method public printBackForwardList()V
    .locals 8

    .prologue
    .line 906
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->copyBackForwardList()Landroid/webkit/WebBackForwardList;

    move-result-object v0

    .line 907
    .local v0, "currentList":Landroid/webkit/WebBackForwardList;
    invoke-virtual {v0}, Landroid/webkit/WebBackForwardList;->getSize()I

    move-result v1

    .line 908
    .local v1, "currentSize":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_0

    .line 910
    invoke-virtual {v0, v2}, Landroid/webkit/WebBackForwardList;->getItemAtIndex(I)Landroid/webkit/WebHistoryItem;

    move-result-object v3

    .line 911
    .local v3, "item":Landroid/webkit/WebHistoryItem;
    invoke-virtual {v3}, Landroid/webkit/WebHistoryItem;->getUrl()Ljava/lang/String;

    move-result-object v4

    .line 912
    .local v4, "url":Ljava/lang/String;
    const-string v5, "CordovaWebView"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "The URL at index: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 908
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 914
    .end local v3    # "item":Landroid/webkit/WebHistoryItem;
    .end local v4    # "url":Ljava/lang/String;
    :cond_0
    return-void
.end method

.method public pushUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    .line 552
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 553
    return-void
.end method

.method public restoreState(Landroid/os/Bundle;)Landroid/webkit/WebBackForwardList;
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 987
    invoke-super {p0, p1}, Landroid/webkit/WebView;->restoreState(Landroid/os/Bundle;)Landroid/webkit/WebBackForwardList;

    move-result-object v0

    .line 988
    .local v0, "myList":Landroid/webkit/WebBackForwardList;
    const-string v1, "CordovaWebView"

    const-string v2, "WebView restoration crew now restoring!"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 990
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->pluginManager:Lorg/apache/cordova/api/PluginManager;

    invoke-virtual {v1}, Lorg/apache/cordova/api/PluginManager;->init()V

    .line 991
    return-object v0
.end method

.method public sendJavascript(Ljava/lang/String;)V
    .locals 1
    .param p1, "statement"    # Ljava/lang/String;

    .prologue
    .line 510
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->jsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/NativeToJsMessageQueue;->addJavaScript(Ljava/lang/String;)V

    .line 511
    return-void
.end method

.method public sendPluginResult(Lorg/apache/cordova/api/PluginResult;Ljava/lang/String;)V
    .locals 1
    .param p1, "result"    # Lorg/apache/cordova/api/PluginResult;
    .param p2, "callbackId"    # Ljava/lang/String;

    .prologue
    .line 520
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebView;->jsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-virtual {v0, p1, p2}, Lorg/apache/cordova/NativeToJsMessageQueue;->addPluginResult(Lorg/apache/cordova/api/PluginResult;Ljava/lang/String;)V

    .line 521
    return-void
.end method

.method public setWebChromeClient(Lorg/apache/cordova/CordovaChromeClient;)V
    .locals 0
    .param p1, "client"    # Lorg/apache/cordova/CordovaChromeClient;

    .prologue
    .line 340
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->chromeClient:Lorg/apache/cordova/CordovaChromeClient;

    .line 341
    invoke-super {p0, p1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 342
    return-void
.end method

.method public setWebViewClient(Lorg/apache/cordova/CordovaWebViewClient;)V
    .locals 0
    .param p1, "client"    # Lorg/apache/cordova/CordovaWebViewClient;

    .prologue
    .line 330
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->viewClient:Lorg/apache/cordova/CordovaWebViewClient;

    .line 331
    invoke-super {p0, p1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 332
    return-void
.end method

.method public showCustomView(Landroid/view/View;Landroid/webkit/WebChromeClient$CustomViewCallback;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/webkit/WebChromeClient$CustomViewCallback;

    .prologue
    .line 934
    const-string v1, "CordovaWebView"

    const-string v2, "showing Custom View"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 936
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    if-eqz v1, :cond_0

    .line 937
    invoke-interface {p2}, Landroid/webkit/WebChromeClient$CustomViewCallback;->onCustomViewHidden()V

    .line 955
    :goto_0
    return-void

    .line 942
    :cond_0
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebView;->mCustomView:Landroid/view/View;

    .line 943
    iput-object p2, p0, Lorg/apache/cordova/CordovaWebView;->mCustomViewCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    .line 946
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 947
    .local v0, "parent":Landroid/view/ViewGroup;
    sget-object v1, Lorg/apache/cordova/CordovaWebView;->COVER_SCREEN_GRAVITY_CENTER:Landroid/widget/FrameLayout$LayoutParams;

    invoke-virtual {v0, p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 950
    const/16 v1, 0x8

    invoke-virtual {p0, v1}, Lorg/apache/cordova/CordovaWebView;->setVisibility(I)V

    .line 953
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    .line 954
    invoke-virtual {v0}, Landroid/view/ViewGroup;->bringToFront()V

    goto :goto_0
.end method

.method public showWebPage(Ljava/lang/String;ZZLjava/util/HashMap;)V
    .locals 7
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "openExternal"    # Z
    .param p3, "clearHistory"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "ZZ",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 607
    .local p4, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    const-string v2, "CordovaWebView"

    const-string v3, "showWebPage(%s, %b, %b, HashMap"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object p1, v4, v5

    const/4 v5, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x2

    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-static {v2, v3, v4}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 610
    if-eqz p3, :cond_0

    .line 611
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->clearHistory()V

    .line 615
    :cond_0
    if-nez p2, :cond_4

    .line 618
    const-string v2, "file://"

    invoke-virtual {p1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->baseUrl:Ljava/lang/String;

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {p1}, Lorg/apache/cordova/Config;->isUrlWhiteListed(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 622
    :cond_1
    if-eqz p3, :cond_2

    .line 623
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->urls:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->clear()V

    .line 627
    :cond_2
    invoke-virtual {p0, p1}, Lorg/apache/cordova/CordovaWebView;->loadUrl(Ljava/lang/String;)V

    .line 652
    :goto_0
    return-void

    .line 631
    :cond_3
    const-string v2, "CordovaWebView"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "showWebPage: Cannot load URL into webview since it is not in white list.  Loading into browser instead. (URL="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lorg/apache/cordova/api/LOG;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 633
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 634
    .local v1, "intent":Landroid/content/Intent;
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 635
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v2}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 636
    .end local v1    # "intent":Landroid/content/Intent;
    :catch_0
    move-exception v0

    .line 637
    .local v0, "e":Landroid/content/ActivityNotFoundException;
    const-string v2, "CordovaWebView"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error loading url "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v0}, Lorg/apache/cordova/api/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 645
    .end local v0    # "e":Landroid/content/ActivityNotFoundException;
    :cond_4
    :try_start_1
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 646
    .restart local v1    # "intent":Landroid/content/Intent;
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 647
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebView;->cordova:Lorg/apache/cordova/api/CordovaInterface;

    invoke-interface {v2}, Lorg/apache/cordova/api/CordovaInterface;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catch Landroid/content/ActivityNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 648
    .end local v1    # "intent":Landroid/content/Intent;
    :catch_1
    move-exception v0

    .line 649
    .restart local v0    # "e":Landroid/content/ActivityNotFoundException;
    const-string v2, "CordovaWebView"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error loading url "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v0}, Lorg/apache/cordova/api/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_0
.end method

.method public startOfHistory()Z
    .locals 7

    .prologue
    const/4 v4, 0x0

    .line 920
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->copyBackForwardList()Landroid/webkit/WebBackForwardList;

    move-result-object v0

    .line 921
    .local v0, "currentList":Landroid/webkit/WebBackForwardList;
    invoke-virtual {v0, v4}, Landroid/webkit/WebBackForwardList;->getItemAtIndex(I)Landroid/webkit/WebHistoryItem;

    move-result-object v2

    .line 922
    .local v2, "item":Landroid/webkit/WebHistoryItem;
    if-eqz v2, :cond_0

    .line 923
    invoke-virtual {v2}, Landroid/webkit/WebHistoryItem;->getUrl()Ljava/lang/String;

    move-result-object v3

    .line 924
    .local v3, "url":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebView;->getUrl()Ljava/lang/String;

    move-result-object v1

    .line 925
    .local v1, "currentUrl":Ljava/lang/String;
    const-string v4, "CordovaWebView"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "The current URL is: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 926
    const-string v4, "CordovaWebView"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "The URL at item 0 is:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lorg/apache/cordova/api/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 927
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 929
    .end local v1    # "currentUrl":Ljava/lang/String;
    .end local v3    # "url":Ljava/lang/String;
    :cond_0
    return v4
.end method

.method public storeResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "intent"    # Landroid/content/Intent;

    .prologue
    .line 995
    new-instance v0, Lorg/apache/cordova/CordovaWebView$ActivityResult;

    invoke-direct {v0, p0, p1, p2, p3}, Lorg/apache/cordova/CordovaWebView$ActivityResult;-><init>(Lorg/apache/cordova/CordovaWebView;IILandroid/content/Intent;)V

    iput-object v0, p0, Lorg/apache/cordova/CordovaWebView;->mResult:Lorg/apache/cordova/CordovaWebView$ActivityResult;

    .line 996
    return-void
.end method

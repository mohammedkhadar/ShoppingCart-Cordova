.class Lorg/apache/cordova/FileTransfer$4;
.super Ljava/lang/Object;
.source "FileTransfer.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/FileTransfer;->download(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/api/CallbackContext;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/FileTransfer;

.field final synthetic val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

.field final synthetic val$objectId:Ljava/lang/String;

.field final synthetic val$source:Ljava/lang/String;

.field final synthetic val$target:Ljava/lang/String;

.field final synthetic val$trustEveryone:Z

.field final synthetic val$url:Ljava/net/URL;

.field final synthetic val$useHttps:Z


# direct methods
.method constructor <init>(Lorg/apache/cordova/FileTransfer;Lorg/apache/cordova/FileTransfer$RequestContext;Ljava/lang/String;ZZLjava/net/URL;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 622
    iput-object p1, p0, Lorg/apache/cordova/FileTransfer$4;->this$0:Lorg/apache/cordova/FileTransfer;

    iput-object p2, p0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    iput-object p3, p0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    iput-boolean p4, p0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    iput-boolean p5, p0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    iput-object p6, p0, Lorg/apache/cordova/FileTransfer$4;->val$url:Ljava/net/URL;

    iput-object p7, p0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    iput-object p8, p0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 29

    .prologue
    .line 624
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->aborted:Z

    move/from16 v24, v0

    if-eqz v24, :cond_0

    .line 763
    :goto_0
    return-void

    .line 627
    :cond_0
    const/4 v5, 0x0

    .line 628
    .local v5, "connection":Ljava/net/URLConnection;
    const/4 v14, 0x0

    .line 629
    .local v14, "oldHostnameVerifier":Ljavax/net/ssl/HostnameVerifier;
    const/4 v15, 0x0

    .line 630
    .local v15, "oldSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    const/4 v9, 0x0

    .line 631
    .local v9, "file":Ljava/io/File;
    const/16 v20, 0x0

    .line 634
    .local v20, "result":Lorg/apache/cordova/api/PluginResult;
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->this$0:Lorg/apache/cordova/FileTransfer;

    move-object/from16 v24, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v25, v0

    # invokes: Lorg/apache/cordova/FileTransfer;->getFileFromPath(Ljava/lang/String;)Ljava/io/File;
    invoke-static/range {v24 .. v25}, Lorg/apache/cordova/FileTransfer;->access$700(Lorg/apache/cordova/FileTransfer;Ljava/lang/String;)Ljava/io/File;

    move-result-object v9

    .line 635
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    iput-object v9, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->targetFile:Ljava/io/File;

    .line 637
    invoke-virtual {v9}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Ljava/io/File;->mkdirs()Z

    .line 641
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_8

    .line 643
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-nez v24, :cond_7

    .line 644
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$url:Ljava/net/URL;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v24

    move-object/from16 v0, v24

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;

    move-object v5, v0

    .line 664
    :goto_1
    instance-of v0, v5, Ljava/net/HttpURLConnection;

    move/from16 v24, v0

    if-eqz v24, :cond_1

    .line 665
    move-object v0, v5

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object/from16 v24, v0

    const-string v25, "GET"

    invoke-virtual/range {v24 .. v25}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 669
    :cond_1
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v25, v0

    invoke-virtual/range {v24 .. v25}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 670
    .local v6, "cookie":Ljava/lang/String;
    if-eqz v6, :cond_2

    .line 672
    const-string v24, "cookie"

    move-object/from16 v0, v24

    invoke-virtual {v5, v0, v6}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 675
    :cond_2
    invoke-virtual {v5}, Ljava/net/URLConnection;->connect()V

    .line 677
    const-string v24, "FileTransfer"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "Download file:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$url:Ljava/net/URL;

    move-object/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 679
    new-instance v18, Lorg/apache/cordova/FileProgressResult;

    invoke-direct/range {v18 .. v18}, Lorg/apache/cordova/FileProgressResult;-><init>()V

    .line 680
    .local v18, "progress":Lorg/apache/cordova/FileProgressResult;
    invoke-virtual {v5}, Ljava/net/URLConnection;->getContentEncoding()Ljava/lang/String;

    move-result-object v24

    if-nez v24, :cond_3

    .line 682
    const/16 v24, 0x1

    move-object/from16 v0, v18

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileProgressResult;->setLengthComputable(Z)V

    .line 683
    invoke-virtual {v5}, Ljava/net/URLConnection;->getContentLength()I

    move-result v24

    move/from16 v0, v24

    int-to-long v0, v0

    move-wide/from16 v24, v0

    move-object/from16 v0, v18

    move-wide/from16 v1, v24

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/FileProgressResult;->setTotal(J)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 686
    :cond_3
    const/16 v16, 0x0

    .line 687
    .local v16, "outputStream":Ljava/io/FileOutputStream;
    const/4 v13, 0x0

    .line 690
    .local v13, "inputStream":Ljava/io/InputStream;
    :try_start_1
    # invokes: Lorg/apache/cordova/FileTransfer;->getInputStream(Ljava/net/URLConnection;)Ljava/io/InputStream;
    invoke-static {v5}, Lorg/apache/cordova/FileTransfer;->access$400(Ljava/net/URLConnection;)Ljava/io/InputStream;

    move-result-object v13

    .line 691
    new-instance v17, Ljava/io/FileOutputStream;

    move-object/from16 v0, v17

    invoke-direct {v0, v9}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_a

    .line 692
    .end local v16    # "outputStream":Ljava/io/FileOutputStream;
    .local v17, "outputStream":Ljava/io/FileOutputStream;
    :try_start_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v25, v0

    monitor-enter v25
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 693
    :try_start_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->aborted:Z

    move/from16 v24, v0

    if-eqz v24, :cond_9

    .line 694
    monitor-exit v25
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 713
    :try_start_4
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    const/16 v25, 0x0

    move-object/from16 v0, v25

    move-object/from16 v1, v24

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 714
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static {v13}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 715
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v17 .. v17}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 741
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_5
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_8

    .line 745
    if-eqz v5, :cond_4

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_4

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_4

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .local v12, "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_4
    if-nez v20, :cond_5

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_5
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_6

    if-eqz v9, :cond_6

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    .end local v6    # "cookie":Ljava/lang/String;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    .end local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    :goto_2
    move-object/from16 v0, v24

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V

    goto/16 :goto_0

    .line 650
    :cond_7
    :try_start_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$url:Ljava/net/URL;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v12

    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 651
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    # invokes: Lorg/apache/cordova/FileTransfer;->trustAllHosts(Ljavax/net/ssl/HttpsURLConnection;)Ljavax/net/ssl/SSLSocketFactory;
    invoke-static {v12}, Lorg/apache/cordova/FileTransfer;->access$000(Ljavax/net/ssl/HttpsURLConnection;)Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v15

    .line 653
    invoke-virtual {v12}, Ljavax/net/ssl/HttpsURLConnection;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v14

    .line 655
    # getter for: Lorg/apache/cordova/FileTransfer;->DO_NOT_VERIFY:Ljavax/net/ssl/HostnameVerifier;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$100()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v24

    move-object/from16 v0, v24

    invoke-virtual {v12, v0}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 656
    move-object v5, v12

    .line 657
    goto/16 :goto_1

    .line 661
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_8
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$url:Ljava/net/URL;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    :try_end_6
    .catch Ljava/io/FileNotFoundException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Lorg/json/JSONException; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    move-result-object v5

    goto/16 :goto_1

    .line 696
    .restart local v6    # "cookie":Ljava/lang/String;
    .restart local v13    # "inputStream":Ljava/io/InputStream;
    .restart local v17    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    :cond_9
    :try_start_7
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    iput-object v13, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 697
    monitor-exit v25
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 700
    const/16 v24, 0x4000

    :try_start_8
    move/from16 v0, v24

    new-array v3, v0, [B

    .line 701
    .local v3, "buffer":[B
    const/4 v4, 0x0

    .line 702
    .local v4, "bytesRead":I
    const-wide/16 v22, 0x0

    .line 703
    .local v22, "totalBytes":J
    :goto_3
    invoke-virtual {v13, v3}, Ljava/io/InputStream;->read([B)I

    move-result v4

    if-lez v4, :cond_c

    .line 704
    const/16 v24, 0x0

    move-object/from16 v0, v17

    move/from16 v1, v24

    invoke-virtual {v0, v3, v1, v4}, Ljava/io/FileOutputStream;->write([BII)V

    .line 705
    int-to-long v0, v4

    move-wide/from16 v24, v0

    add-long v22, v22, v24

    .line 707
    move-object/from16 v0, v18

    move-wide/from16 v1, v22

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/FileProgressResult;->setLoaded(J)V

    .line 708
    new-instance v19, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v18 .. v18}, Lorg/apache/cordova/FileProgressResult;->toJSONObject()Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v19

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 709
    .local v19, "progressResult":Lorg/apache/cordova/api/PluginResult;
    const/16 v24, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Lorg/apache/cordova/api/PluginResult;->setKeepCallback(Z)V

    .line 710
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto :goto_3

    .line 713
    .end local v3    # "buffer":[B
    .end local v4    # "bytesRead":I
    .end local v19    # "progressResult":Lorg/apache/cordova/api/PluginResult;
    .end local v22    # "totalBytes":J
    :catchall_0
    move-exception v24

    move-object/from16 v16, v17

    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v16    # "outputStream":Ljava/io/FileOutputStream;
    :goto_4
    :try_start_9
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v25, v0

    const/16 v26, 0x0

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 714
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static {v13}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 715
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v16 .. v16}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 713
    throw v24
    :try_end_9
    .catch Ljava/io/FileNotFoundException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_1
    .catch Lorg/json/JSONException; {:try_start_9 .. :try_end_9} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 725
    .end local v6    # "cookie":Ljava/lang/String;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v16    # "outputStream":Ljava/io/FileOutputStream;
    .end local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    :catch_0
    move-exception v7

    .line 726
    .local v7, "e":Ljava/io/FileNotFoundException;
    :try_start_a
    sget v24, Lorg/apache/cordova/FileTransfer;->FILE_NOT_FOUND_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v26, v0

    move/from16 v0, v24

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v8

    .line 727
    .local v8, "error":Lorg/json/JSONObject;
    const-string v24, "FileTransfer"

    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    invoke-static {v0, v1, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 728
    new-instance v21, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-direct {v0, v1, v8}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 741
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .local v21, "result":Lorg/apache/cordova/api/PluginResult;
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_b
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    .line 745
    if-eqz v5, :cond_a

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_a

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_a

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_a
    if-nez v21, :cond_1c

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :goto_5
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_b

    if-eqz v9, :cond_b

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_b
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    goto/16 :goto_2

    .line 697
    .end local v7    # "e":Ljava/io/FileNotFoundException;
    .end local v8    # "error":Lorg/json/JSONObject;
    .restart local v6    # "cookie":Ljava/lang/String;
    .restart local v13    # "inputStream":Ljava/io/InputStream;
    .restart local v17    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    :catchall_1
    move-exception v24

    :try_start_c
    monitor-exit v25
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    :try_start_d
    throw v24
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    .line 713
    .restart local v3    # "buffer":[B
    .restart local v4    # "bytesRead":I
    .restart local v22    # "totalBytes":J
    :cond_c
    :try_start_e
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    const/16 v25, 0x0

    move-object/from16 v0, v25

    move-object/from16 v1, v24

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 714
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static {v13}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 715
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v17 .. v17}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 718
    const-string v24, "FileTransfer"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "Saved file: "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 721
    new-instance v11, Lorg/apache/cordova/FileUtils;

    invoke-direct {v11}, Lorg/apache/cordova/FileUtils;-><init>()V

    .line 722
    .local v11, "fileUtil":Lorg/apache/cordova/FileUtils;
    invoke-virtual {v11, v9}, Lorg/apache/cordova/FileUtils;->getEntry(Ljava/io/File;)Lorg/json/JSONObject;

    move-result-object v10

    .line 724
    .local v10, "fileEntry":Lorg/json/JSONObject;
    new-instance v21, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-direct {v0, v1, v10}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V
    :try_end_e
    .catch Ljava/io/FileNotFoundException; {:try_start_e .. :try_end_e} :catch_0
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_1
    .catch Lorg/json/JSONException; {:try_start_e .. :try_end_e} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_3
    .catchall {:try_start_e .. :try_end_e} :catchall_2

    .line 741
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_f
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_9

    .line 745
    if-eqz v5, :cond_d

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_d

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_d

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_d
    if-nez v21, :cond_18

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :goto_6
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_e

    if-eqz v9, :cond_e

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_e
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    goto/16 :goto_2

    .line 729
    .end local v3    # "buffer":[B
    .end local v4    # "bytesRead":I
    .end local v6    # "cookie":Ljava/lang/String;
    .end local v10    # "fileEntry":Lorg/json/JSONObject;
    .end local v11    # "fileUtil":Lorg/apache/cordova/FileUtils;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    .end local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v22    # "totalBytes":J
    :catch_1
    move-exception v7

    .line 730
    .local v7, "e":Ljava/io/IOException;
    :try_start_10
    sget v24, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v26, v0

    move/from16 v0, v24

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v8

    .line 731
    .restart local v8    # "error":Lorg/json/JSONObject;
    const-string v24, "FileTransfer"

    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    invoke-static {v0, v1, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 732
    new-instance v21, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-direct {v0, v1, v8}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_2

    .line 741
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_11
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_5

    .line 745
    if-eqz v5, :cond_f

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_f

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_f

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_f
    if-nez v21, :cond_1b

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :goto_7
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_10

    if-eqz v9, :cond_10

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_10
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    goto/16 :goto_2

    .line 733
    .end local v7    # "e":Ljava/io/IOException;
    .end local v8    # "error":Lorg/json/JSONObject;
    :catch_2
    move-exception v7

    .line 734
    .local v7, "e":Lorg/json/JSONException;
    :try_start_12
    const-string v24, "FileTransfer"

    invoke-virtual {v7}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    invoke-static {v0, v1, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 735
    new-instance v21, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->JSON_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-direct {v0, v1}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;)V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_2

    .line 741
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_13
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_6

    .line 745
    if-eqz v5, :cond_11

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_11

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_11

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_11
    if-nez v21, :cond_1a

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :goto_8
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_12

    if-eqz v9, :cond_12

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_12
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    goto/16 :goto_2

    .line 736
    .end local v7    # "e":Lorg/json/JSONException;
    :catch_3
    move-exception v7

    .line 737
    .local v7, "e":Ljava/lang/Throwable;
    :try_start_14
    sget v24, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v26, v0

    move/from16 v0, v24

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v8

    .line 738
    .restart local v8    # "error":Lorg/json/JSONObject;
    const-string v24, "FileTransfer"

    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    invoke-static {v0, v1, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 739
    new-instance v21, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-direct {v0, v1, v8}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_2

    .line 741
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_15
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v24

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_7

    .line 745
    if-eqz v5, :cond_13

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v24, v0

    if-eqz v24, :cond_13

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v24, v0

    if-eqz v24, :cond_13

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_13
    if-nez v21, :cond_19

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    sget-object v24, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v25, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v27, v0

    move/from16 v0, v25

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v25

    move-object/from16 v0, v20

    move-object/from16 v1, v24

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :goto_9
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v24

    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_14

    if-eqz v9, :cond_14

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_14
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v24, v0

    goto/16 :goto_2

    .line 741
    .end local v7    # "e":Ljava/lang/Throwable;
    .end local v8    # "error":Lorg/json/JSONObject;
    :catchall_2
    move-exception v24

    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v25

    monitor-enter v25

    .line 742
    :try_start_16
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$objectId:Ljava/lang/String;

    move-object/from16 v27, v0

    invoke-virtual/range {v26 .. v27}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 743
    monitor-exit v25
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_3

    .line 745
    if-eqz v5, :cond_15

    .line 747
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$trustEveryone:Z

    move/from16 v25, v0

    if-eqz v25, :cond_15

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$useHttps:Z

    move/from16 v25, v0

    if-eqz v25, :cond_15

    move-object v12, v5

    .line 748
    check-cast v12, Ljavax/net/ssl/HttpsURLConnection;

    .line 749
    .restart local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    invoke-virtual {v12, v14}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 750
    invoke-virtual {v12, v15}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 754
    .end local v12    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_15
    if-nez v20, :cond_16

    .line 755
    new-instance v20, Lorg/apache/cordova/api/PluginResult;

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    sget-object v25, Lorg/apache/cordova/api/PluginResult$Status;->ERROR:Lorg/apache/cordova/api/PluginResult$Status;

    sget v26, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$source:Ljava/lang/String;

    move-object/from16 v27, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$target:Ljava/lang/String;

    move-object/from16 v28, v0

    move/from16 v0, v26

    move-object/from16 v1, v27

    move-object/from16 v2, v28

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v5}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v26

    move-object/from16 v0, v20

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 758
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_16
    invoke-virtual/range {v20 .. v20}, Lorg/apache/cordova/api/PluginResult;->getStatus()I

    move-result v25

    sget-object v26, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v26 .. v26}, Lorg/apache/cordova/api/PluginResult$Status;->ordinal()I

    move-result v26

    move/from16 v0, v25

    move/from16 v1, v26

    if-eq v0, v1, :cond_17

    if-eqz v9, :cond_17

    .line 759
    invoke-virtual {v9}, Ljava/io/File;->delete()Z

    .line 761
    :cond_17
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$4;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v25, v0

    move-object/from16 v0, v25

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V

    .line 741
    throw v24

    .line 743
    :catchall_3
    move-exception v24

    :try_start_17
    monitor-exit v25
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_3

    throw v24

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .local v7, "e":Ljava/io/FileNotFoundException;
    .restart local v8    # "error":Lorg/json/JSONObject;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    :catchall_4
    move-exception v24

    :try_start_18
    monitor-exit v25
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_4

    throw v24

    .local v7, "e":Ljava/io/IOException;
    :catchall_5
    move-exception v24

    :try_start_19
    monitor-exit v25
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_5

    throw v24

    .end local v8    # "error":Lorg/json/JSONObject;
    .local v7, "e":Lorg/json/JSONException;
    :catchall_6
    move-exception v24

    :try_start_1a
    monitor-exit v25
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_6

    throw v24

    .local v7, "e":Ljava/lang/Throwable;
    .restart local v8    # "error":Lorg/json/JSONObject;
    :catchall_7
    move-exception v24

    :try_start_1b
    monitor-exit v25
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_7

    throw v24

    .end local v7    # "e":Ljava/lang/Throwable;
    .end local v8    # "error":Lorg/json/JSONObject;
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v6    # "cookie":Ljava/lang/String;
    .restart local v13    # "inputStream":Ljava/io/InputStream;
    .restart local v17    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :catchall_8
    move-exception v24

    :try_start_1c
    monitor-exit v25
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_8

    throw v24

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v3    # "buffer":[B
    .restart local v4    # "bytesRead":I
    .restart local v10    # "fileEntry":Lorg/json/JSONObject;
    .restart local v11    # "fileUtil":Lorg/apache/cordova/FileUtils;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v22    # "totalBytes":J
    :catchall_9
    move-exception v24

    :try_start_1d
    monitor-exit v25
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_9

    throw v24

    .line 713
    .end local v3    # "buffer":[B
    .end local v4    # "bytesRead":I
    .end local v10    # "fileEntry":Lorg/json/JSONObject;
    .end local v11    # "fileUtil":Lorg/apache/cordova/FileUtils;
    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .end local v22    # "totalBytes":J
    .restart local v16    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    :catchall_a
    move-exception v24

    goto/16 :goto_4

    .end local v16    # "outputStream":Ljava/io/FileOutputStream;
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v3    # "buffer":[B
    .restart local v4    # "bytesRead":I
    .restart local v10    # "fileEntry":Lorg/json/JSONObject;
    .restart local v11    # "fileUtil":Lorg/apache/cordova/FileUtils;
    .restart local v17    # "outputStream":Ljava/io/FileOutputStream;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v22    # "totalBytes":J
    :cond_18
    move-object/from16 v20, v21

    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    goto/16 :goto_6

    .end local v3    # "buffer":[B
    .end local v4    # "bytesRead":I
    .end local v6    # "cookie":Ljava/lang/String;
    .end local v10    # "fileEntry":Lorg/json/JSONObject;
    .end local v11    # "fileUtil":Lorg/apache/cordova/FileUtils;
    .end local v13    # "inputStream":Ljava/io/InputStream;
    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    .end local v18    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .end local v22    # "totalBytes":J
    .restart local v7    # "e":Ljava/lang/Throwable;
    .restart local v8    # "error":Lorg/json/JSONObject;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_19
    move-object/from16 v20, v21

    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    goto/16 :goto_9

    .end local v8    # "error":Lorg/json/JSONObject;
    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .local v7, "e":Lorg/json/JSONException;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_1a
    move-object/from16 v20, v21

    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    goto/16 :goto_8

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .local v7, "e":Ljava/io/IOException;
    .restart local v8    # "error":Lorg/json/JSONObject;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_1b
    move-object/from16 v20, v21

    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    goto/16 :goto_7

    .end local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    .local v7, "e":Ljava/io/FileNotFoundException;
    .restart local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    :cond_1c
    move-object/from16 v20, v21

    .end local v21    # "result":Lorg/apache/cordova/api/PluginResult;
    .restart local v20    # "result":Lorg/apache/cordova/api/PluginResult;
    goto/16 :goto_5
.end method

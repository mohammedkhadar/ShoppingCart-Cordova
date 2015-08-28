.class Lorg/apache/cordova/FileTransfer$1;
.super Ljava/lang/Object;
.source "FileTransfer.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/FileTransfer;->upload(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/api/CallbackContext;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/FileTransfer;

.field final synthetic val$chunkedMode:Z

.field final synthetic val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

.field final synthetic val$fileKey:Ljava/lang/String;

.field final synthetic val$fileName:Ljava/lang/String;

.field final synthetic val$headers:Lorg/json/JSONObject;

.field final synthetic val$mimeType:Ljava/lang/String;

.field final synthetic val$objectId:Ljava/lang/String;

.field final synthetic val$params:Lorg/json/JSONObject;

.field final synthetic val$source:Ljava/lang/String;

.field final synthetic val$target:Ljava/lang/String;

.field final synthetic val$trustEveryone:Z

.field final synthetic val$url:Ljava/net/URL;

.field final synthetic val$useHttps:Z


# direct methods
.method constructor <init>(Lorg/apache/cordova/FileTransfer;Lorg/apache/cordova/FileTransfer$RequestContext;ZZLjava/net/URL;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 211
    iput-object p1, p0, Lorg/apache/cordova/FileTransfer$1;->this$0:Lorg/apache/cordova/FileTransfer;

    iput-object p2, p0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    iput-boolean p3, p0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    iput-boolean p4, p0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    iput-object p5, p0, Lorg/apache/cordova/FileTransfer$1;->val$url:Ljava/net/URL;

    iput-object p6, p0, Lorg/apache/cordova/FileTransfer$1;->val$target:Ljava/lang/String;

    iput-object p7, p0, Lorg/apache/cordova/FileTransfer$1;->val$headers:Lorg/json/JSONObject;

    iput-object p8, p0, Lorg/apache/cordova/FileTransfer$1;->val$params:Lorg/json/JSONObject;

    iput-object p9, p0, Lorg/apache/cordova/FileTransfer$1;->val$fileKey:Ljava/lang/String;

    iput-object p10, p0, Lorg/apache/cordova/FileTransfer$1;->val$fileName:Ljava/lang/String;

    iput-object p11, p0, Lorg/apache/cordova/FileTransfer$1;->val$mimeType:Ljava/lang/String;

    iput-object p12, p0, Lorg/apache/cordova/FileTransfer$1;->val$source:Ljava/lang/String;

    iput-boolean p13, p0, Lorg/apache/cordova/FileTransfer$1;->val$chunkedMode:Z

    iput-object p14, p0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 42

    .prologue
    .line 213
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->aborted:Z

    move/from16 v38, v0

    if-eqz v38, :cond_1

    .line 466
    :cond_0
    :goto_0
    return-void

    .line 216
    :cond_1
    const/4 v9, 0x0

    .line 217
    .local v9, "conn":Ljava/net/HttpURLConnection;
    const/16 v21, 0x0

    .line 218
    .local v21, "oldHostnameVerifier":Ljavax/net/ssl/HostnameVerifier;
    const/16 v22, 0x0

    .line 219
    .local v22, "oldSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    const/16 v36, 0x0

    .line 220
    .local v36, "totalBytes":I
    const/4 v13, -0x1

    .line 223
    .local v13, "fixedLength":I
    :try_start_0
    new-instance v30, Lorg/apache/cordova/FileUploadResult;

    invoke-direct/range {v30 .. v30}, Lorg/apache/cordova/FileUploadResult;-><init>()V

    .line 224
    .local v30, "result":Lorg/apache/cordova/FileUploadResult;
    new-instance v26, Lorg/apache/cordova/FileProgressResult;

    invoke-direct/range {v26 .. v26}, Lorg/apache/cordova/FileProgressResult;-><init>()V

    .line 228
    .local v26, "progress":Lorg/apache/cordova/FileProgressResult;
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_6

    .line 230
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-nez v38, :cond_5

    .line 231
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$url:Ljava/net/URL;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v38

    move-object/from16 v0, v38

    check-cast v0, Ljavax/net/ssl/HttpsURLConnection;

    move-object v9, v0

    .line 252
    :goto_1
    const/16 v38, 0x1

    move/from16 v0, v38

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 255
    const/16 v38, 0x1

    move/from16 v0, v38

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 258
    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setUseCaches(Z)V

    .line 261
    const-string v38, "POST"

    move-object/from16 v0, v38

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 262
    const-string v38, "Content-Type"

    const-string v39, "multipart/form-data;boundary=+++++"

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-virtual {v9, v0, v1}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 265
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$target:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 266
    .local v10, "cookie":Ljava/lang/String;
    if-eqz v10, :cond_2

    .line 267
    const-string v38, "Cookie"

    move-object/from16 v0, v38

    invoke-virtual {v9, v0, v10}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 271
    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$headers:Lorg/json/JSONObject;

    move-object/from16 v38, v0
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_b

    if-eqz v38, :cond_7

    .line 273
    :try_start_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$headers:Lorg/json/JSONObject;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v19

    .local v19, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_3
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v38

    if-eqz v38, :cond_7

    .line 274
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v14

    .line 275
    .local v14, "headerKey":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$headers:Lorg/json/JSONObject;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    invoke-virtual {v0, v14}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v15

    .line 276
    .local v15, "headerValues":Lorg/json/JSONArray;
    if-nez v15, :cond_4

    .line 277
    new-instance v15, Lorg/json/JSONArray;

    .end local v15    # "headerValues":Lorg/json/JSONArray;
    invoke-direct {v15}, Lorg/json/JSONArray;-><init>()V

    .line 278
    .restart local v15    # "headerValues":Lorg/json/JSONArray;
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$headers:Lorg/json/JSONObject;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    invoke-virtual {v0, v14}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v38

    invoke-virtual {v15, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 280
    :cond_4
    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v15, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v38

    invoke-virtual {v9, v14, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 281
    const/16 v17, 0x1

    .local v17, "i":I
    :goto_2
    invoke-virtual {v15}, Lorg/json/JSONArray;->length()I

    move-result v38

    move/from16 v0, v17

    move/from16 v1, v38

    if-ge v0, v1, :cond_3

    .line 282
    move/from16 v0, v17

    invoke-virtual {v15, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v38

    invoke-virtual {v9, v14, v0}, Ljava/net/HttpURLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_5
    .catchall {:try_start_1 .. :try_end_1} :catchall_b

    .line 281
    add-int/lit8 v17, v17, 0x1

    goto :goto_2

    .line 237
    .end local v10    # "cookie":Ljava/lang/String;
    .end local v14    # "headerKey":Ljava/lang/String;
    .end local v15    # "headerValues":Lorg/json/JSONArray;
    .end local v17    # "i":I
    .end local v19    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_5
    :try_start_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$url:Ljava/net/URL;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v16

    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 238
    .local v16, "https":Ljavax/net/ssl/HttpsURLConnection;
    # invokes: Lorg/apache/cordova/FileTransfer;->trustAllHosts(Ljavax/net/ssl/HttpsURLConnection;)Ljavax/net/ssl/SSLSocketFactory;
    invoke-static/range {v16 .. v16}, Lorg/apache/cordova/FileTransfer;->access$000(Ljavax/net/ssl/HttpsURLConnection;)Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v22

    .line 240
    invoke-virtual/range {v16 .. v16}, Ljavax/net/ssl/HttpsURLConnection;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v21

    .line 242
    # getter for: Lorg/apache/cordova/FileTransfer;->DO_NOT_VERIFY:Ljavax/net/ssl/HostnameVerifier;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$100()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v38

    move-object/from16 v0, v16

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 243
    move-object/from16 v9, v16

    .line 244
    goto/16 :goto_1

    .line 248
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$url:Ljava/net/URL;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v38

    move-object/from16 v0, v38

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v9, v0

    goto/16 :goto_1

    .line 285
    .restart local v10    # "cookie":Ljava/lang/String;
    :catch_0
    move-exception v38

    .line 294
    :cond_7
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_5
    .catchall {:try_start_2 .. :try_end_2} :catchall_b

    .line 296
    .local v3, "beforeData":Ljava/lang/StringBuilder;
    :try_start_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$params:Lorg/json/JSONObject;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v19

    .restart local v19    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_8
    :goto_3
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v38

    if-eqz v38, :cond_9

    .line 297
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v20

    .line 298
    .local v20, "key":Ljava/lang/Object;
    invoke-static/range {v20 .. v20}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v38

    const-string v39, "headers"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_8

    .line 300
    const-string v38, "--"

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "+++++"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 301
    const-string v38, "Content-Disposition: form-data; name=\""

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const/16 v39, 0x22

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 302
    const-string v38, "\r\n"

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 303
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$params:Lorg/json/JSONObject;

    move-object/from16 v38, v0

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 304
    const-string v38, "\r\n"

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5
    .catchall {:try_start_3 .. :try_end_3} :catchall_b

    goto :goto_3

    .line 307
    .end local v19    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v20    # "key":Ljava/lang/Object;
    :catch_1
    move-exception v11

    .line 308
    .local v11, "e":Lorg/json/JSONException;
    :try_start_4
    const-string v38, "FileTransfer"

    invoke-virtual {v11}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-static {v0, v1, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 311
    .end local v11    # "e":Lorg/json/JSONException;
    :cond_9
    const-string v38, "--"

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "+++++"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 312
    const-string v38, "Content-Disposition: form-data; name=\""

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$fileKey:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\";"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 313
    const-string v38, " filename=\""

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$fileName:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const/16 v39, 0x22

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 314
    const-string v38, "Content-Type: "

    move-object/from16 v0, v38

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$mimeType:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, "\r\n"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 315
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const-string v39, "UTF-8"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v4

    .line 316
    .local v4, "beforeDataBytes":[B
    const-string v38, "\r\n--+++++--\r\n"

    const-string v39, "UTF-8"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v35

    .line 320
    .local v35, "tailParamsBytes":[B
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->this$0:Lorg/apache/cordova/FileTransfer;

    move-object/from16 v38, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$source:Ljava/lang/String;

    move-object/from16 v39, v0

    # invokes: Lorg/apache/cordova/FileTransfer;->getPathFromUri(Ljava/lang/String;)Ljava/io/InputStream;
    invoke-static/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer;->access$200(Lorg/apache/cordova/FileTransfer;Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v32

    .line 322
    .local v32, "sourceInputStream":Ljava/io/InputStream;
    array-length v0, v4

    move/from16 v38, v0

    move-object/from16 v0, v35

    array-length v0, v0

    move/from16 v39, v0

    add-int v33, v38, v39

    .line 323
    .local v33, "stringLength":I
    move-object/from16 v0, v32

    instance-of v0, v0, Ljava/io/FileInputStream;

    move/from16 v38, v0

    if-eqz v38, :cond_a

    .line 324
    move-object/from16 v0, v32

    check-cast v0, Ljava/io/FileInputStream;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v38

    move-wide/from16 v0, v38

    long-to-int v0, v0

    move/from16 v38, v0

    add-int v13, v38, v33

    .line 325
    const/16 v38, 0x1

    move-object/from16 v0, v26

    move/from16 v1, v38

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileProgressResult;->setLengthComputable(Z)V

    .line 326
    int-to-long v0, v13

    move-wide/from16 v38, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v38

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/FileProgressResult;->setTotal(J)V

    .line 328
    :cond_a
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "Content Length: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 332
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$chunkedMode:Z

    move/from16 v38, v0

    if-eqz v38, :cond_d

    sget v38, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v39, 0x8

    move/from16 v0, v38

    move/from16 v1, v39

    if-lt v0, v1, :cond_b

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_d

    :cond_b
    const/16 v37, 0x1

    .line 333
    .local v37, "useChunkedMode":Z
    :goto_4
    if-nez v37, :cond_c

    const/16 v38, -0x1

    move/from16 v0, v38

    if-ne v13, v0, :cond_e

    :cond_c
    const/16 v37, 0x1

    .line 335
    :goto_5
    if-eqz v37, :cond_f

    .line 336
    const/16 v38, 0x4000

    move/from16 v0, v38

    invoke-virtual {v9, v0}, Ljava/net/HttpURLConnection;->setChunkedStreamingMode(I)V

    .line 339
    const-string v38, "Transfer-Encoding"

    const-string v39, "chunked"

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-virtual {v9, v0, v1}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 344
    :goto_6
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->connect()V
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_5
    .catchall {:try_start_4 .. :try_end_4} :catchall_b

    .line 346
    const/16 v31, 0x0

    .line 348
    .local v31, "sendStream":Ljava/io/OutputStream;
    :try_start_5
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v31

    .line 349
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v39, v0

    monitor-enter v39
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 350
    :try_start_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->aborted:Z

    move/from16 v38, v0

    if-eqz v38, :cond_10

    .line 351
    monitor-exit v39
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 392
    :try_start_7
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v32 .. v32}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 393
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v31 .. v31}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V
    :try_end_7
    .catch Ljava/io/FileNotFoundException; {:try_start_7 .. :try_end_7} :catch_2
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3
    .catch Lorg/json/JSONException; {:try_start_7 .. :try_end_7} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5
    .catchall {:try_start_7 .. :try_end_7} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_8
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 332
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    .end local v31    # "sendStream":Ljava/io/OutputStream;
    .end local v37    # "useChunkedMode":Z
    :cond_d
    const/16 v37, 0x0

    goto/16 :goto_4

    .line 333
    .restart local v37    # "useChunkedMode":Z
    :cond_e
    const/16 v37, 0x0

    goto :goto_5

    .line 341
    :cond_f
    :try_start_9
    invoke-virtual {v9, v13}, Ljava/net/HttpURLConnection;->setFixedLengthStreamingMode(I)V
    :try_end_9
    .catch Ljava/io/FileNotFoundException; {:try_start_9 .. :try_end_9} :catch_2
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_3
    .catch Lorg/json/JSONException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5
    .catchall {:try_start_9 .. :try_end_9} :catchall_b

    goto :goto_6

    .line 434
    .end local v3    # "beforeData":Ljava/lang/StringBuilder;
    .end local v4    # "beforeDataBytes":[B
    .end local v10    # "cookie":Ljava/lang/String;
    .end local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .end local v32    # "sourceInputStream":Ljava/io/InputStream;
    .end local v33    # "stringLength":I
    .end local v35    # "tailParamsBytes":[B
    .end local v37    # "useChunkedMode":Z
    :catch_2
    move-exception v11

    .line 435
    .local v11, "e":Ljava/io/FileNotFoundException;
    :try_start_a
    sget v38, Lorg/apache/cordova/FileTransfer;->FILE_NOT_FOUND_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$source:Ljava/lang/String;

    move-object/from16 v39, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$target:Ljava/lang/String;

    move-object/from16 v40, v0

    move/from16 v0, v38

    move-object/from16 v1, v39

    move-object/from16 v2, v40

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v9}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v12

    .line 436
    .local v12, "error":Lorg/json/JSONObject;
    const-string v38, "FileTransfer"

    invoke-virtual {v12}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-static {v0, v1, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 437
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    new-instance v39, Lorg/apache/cordova/api/PluginResult;

    sget-object v40, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v39

    move-object/from16 v1, v40

    invoke-direct {v0, v1, v12}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_b
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_7

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 454
    .end local v11    # "e":Ljava/io/FileNotFoundException;
    .end local v12    # "error":Lorg/json/JSONObject;
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    .restart local v3    # "beforeData":Ljava/lang/StringBuilder;
    .restart local v4    # "beforeDataBytes":[B
    .restart local v10    # "cookie":Ljava/lang/String;
    .restart local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .restart local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .restart local v31    # "sendStream":Ljava/io/OutputStream;
    .restart local v32    # "sourceInputStream":Ljava/io/InputStream;
    .restart local v33    # "stringLength":I
    .restart local v35    # "tailParamsBytes":[B
    .restart local v37    # "useChunkedMode":Z
    :catchall_0
    move-exception v38

    :try_start_c
    monitor-exit v39
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    throw v38

    .line 353
    :cond_10
    :try_start_d
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v31

    move-object/from16 v1, v38

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentOutputStream:Ljava/io/OutputStream;

    .line 354
    monitor-exit v39
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_2

    .line 356
    :try_start_e
    move-object/from16 v0, v31

    invoke-virtual {v0, v4}, Ljava/io/OutputStream;->write([B)V

    .line 357
    array-length v0, v4

    move/from16 v38, v0

    add-int v36, v36, v38

    .line 360
    invoke-virtual/range {v32 .. v32}, Ljava/io/InputStream;->available()I

    move-result v7

    .line 361
    .local v7, "bytesAvailable":I
    const/16 v38, 0x4000

    move/from16 v0, v38

    invoke-static {v7, v0}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 362
    .local v6, "bufferSize":I
    new-array v5, v6, [B

    .line 365
    .local v5, "buffer":[B
    const/16 v38, 0x0

    move-object/from16 v0, v32

    move/from16 v1, v38

    invoke-virtual {v0, v5, v1, v6}, Ljava/io/InputStream;->read([BII)I

    move-result v8

    .line 367
    .local v8, "bytesRead":I
    const-wide/16 v24, 0x0

    .line 368
    .local v24, "prevBytesRead":J
    :goto_7
    if-lez v8, :cond_12

    .line 369
    move/from16 v0, v36

    int-to-long v0, v0

    move-wide/from16 v38, v0

    move-object/from16 v0, v30

    move-wide/from16 v1, v38

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/FileUploadResult;->setBytesSent(J)V

    .line 370
    const/16 v38, 0x0

    move-object/from16 v0, v31

    move/from16 v1, v38

    invoke-virtual {v0, v5, v1, v8}, Ljava/io/OutputStream;->write([BII)V

    .line 371
    add-int v36, v36, v8

    .line 372
    move/from16 v0, v36

    int-to-long v0, v0

    move-wide/from16 v38, v0

    const-wide/32 v40, 0x19000

    add-long v40, v40, v24

    cmp-long v38, v38, v40

    if-lez v38, :cond_11

    .line 373
    move/from16 v0, v36

    int-to-long v0, v0

    move-wide/from16 v24, v0

    .line 374
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "Uploaded "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v36

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    const-string v40, " of "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    const-string v40, " bytes"

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 376
    :cond_11
    invoke-virtual/range {v32 .. v32}, Ljava/io/InputStream;->available()I

    move-result v7

    .line 377
    const/16 v38, 0x4000

    move/from16 v0, v38

    invoke-static {v7, v0}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 378
    const/16 v38, 0x0

    move-object/from16 v0, v32

    move/from16 v1, v38

    invoke-virtual {v0, v5, v1, v6}, Ljava/io/InputStream;->read([BII)I

    move-result v8

    .line 381
    move/from16 v0, v36

    int-to-long v0, v0

    move-wide/from16 v38, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v38

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/FileProgressResult;->setLoaded(J)V

    .line 382
    new-instance v27, Lorg/apache/cordova/api/PluginResult;

    sget-object v38, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v26 .. v26}, Lorg/apache/cordova/FileProgressResult;->toJSONObject()Lorg/json/JSONObject;

    move-result-object v39

    move-object/from16 v0, v27

    move-object/from16 v1, v38

    move-object/from16 v2, v39

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 383
    .local v27, "progressResult":Lorg/apache/cordova/api/PluginResult;
    const/16 v38, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v38

    invoke-virtual {v0, v1}, Lorg/apache/cordova/api/PluginResult;->setKeepCallback(Z)V

    .line 384
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_1

    goto/16 :goto_7

    .line 392
    .end local v5    # "buffer":[B
    .end local v6    # "bufferSize":I
    .end local v7    # "bytesAvailable":I
    .end local v8    # "bytesRead":I
    .end local v24    # "prevBytesRead":J
    .end local v27    # "progressResult":Lorg/apache/cordova/api/PluginResult;
    :catchall_1
    move-exception v38

    :try_start_f
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v32 .. v32}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 393
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v31 .. v31}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    throw v38
    :try_end_f
    .catch Ljava/io/FileNotFoundException; {:try_start_f .. :try_end_f} :catch_2
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_3
    .catch Lorg/json/JSONException; {:try_start_f .. :try_end_f} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_5
    .catchall {:try_start_f .. :try_end_f} :catchall_b

    .line 438
    .end local v3    # "beforeData":Ljava/lang/StringBuilder;
    .end local v4    # "beforeDataBytes":[B
    .end local v10    # "cookie":Ljava/lang/String;
    .end local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .end local v31    # "sendStream":Ljava/io/OutputStream;
    .end local v32    # "sourceInputStream":Ljava/io/InputStream;
    .end local v33    # "stringLength":I
    .end local v35    # "tailParamsBytes":[B
    .end local v37    # "useChunkedMode":Z
    :catch_3
    move-exception v11

    .line 439
    .local v11, "e":Ljava/io/IOException;
    :try_start_10
    sget v38, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$source:Ljava/lang/String;

    move-object/from16 v39, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$target:Ljava/lang/String;

    move-object/from16 v40, v0

    move/from16 v0, v38

    move-object/from16 v1, v39

    move-object/from16 v2, v40

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v9}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v12

    .line 440
    .restart local v12    # "error":Lorg/json/JSONObject;
    const-string v38, "FileTransfer"

    invoke-virtual {v12}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-static {v0, v1, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 441
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "Failed after uploading "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v36

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    const-string v40, " of "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    const-string v40, " bytes."

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 442
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    new-instance v39, Lorg/apache/cordova/api/PluginResult;

    sget-object v40, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v39

    move-object/from16 v1, v40

    invoke-direct {v0, v1, v12}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_11
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_8

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 354
    .end local v11    # "e":Ljava/io/IOException;
    .end local v12    # "error":Lorg/json/JSONObject;
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    .restart local v3    # "beforeData":Ljava/lang/StringBuilder;
    .restart local v4    # "beforeDataBytes":[B
    .restart local v10    # "cookie":Ljava/lang/String;
    .restart local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .restart local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .restart local v31    # "sendStream":Ljava/io/OutputStream;
    .restart local v32    # "sourceInputStream":Ljava/io/InputStream;
    .restart local v33    # "stringLength":I
    .restart local v35    # "tailParamsBytes":[B
    .restart local v37    # "useChunkedMode":Z
    :catchall_2
    move-exception v38

    :try_start_12
    monitor-exit v39
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_2

    :try_start_13
    throw v38

    .line 388
    .restart local v5    # "buffer":[B
    .restart local v6    # "bufferSize":I
    .restart local v7    # "bytesAvailable":I
    .restart local v8    # "bytesRead":I
    .restart local v24    # "prevBytesRead":J
    :cond_12
    move-object/from16 v0, v31

    move-object/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/io/OutputStream;->write([B)V

    .line 389
    move-object/from16 v0, v35

    array-length v0, v0

    move/from16 v38, v0

    add-int v36, v36, v38

    .line 390
    invoke-virtual/range {v31 .. v31}, Ljava/io/OutputStream;->flush()V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_1

    .line 392
    :try_start_14
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v32 .. v32}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 393
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v31 .. v31}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 395
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    move-object/from16 v0, v39

    move-object/from16 v1, v38

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentOutputStream:Ljava/io/OutputStream;

    .line 396
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "Sent "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v36

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    const-string v40, " of "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 400
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v28

    .line 401
    .local v28, "responseCode":I
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "response code: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 402
    const-string v38, "FileTransfer"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "response headers: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v40

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_14
    .catch Ljava/io/FileNotFoundException; {:try_start_14 .. :try_end_14} :catch_2
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_14} :catch_3
    .catch Lorg/json/JSONException; {:try_start_14 .. :try_end_14} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_5
    .catchall {:try_start_14 .. :try_end_14} :catchall_b

    .line 403
    const/16 v18, 0x0

    .line 405
    .local v18, "inStream":Ljava/io/InputStream;
    :try_start_15
    # invokes: Lorg/apache/cordova/FileTransfer;->getInputStream(Ljava/net/URLConnection;)Ljava/io/InputStream;
    invoke-static {v9}, Lorg/apache/cordova/FileTransfer;->access$400(Ljava/net/URLConnection;)Ljava/io/InputStream;

    move-result-object v18

    .line 406
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v39, v0

    monitor-enter v39
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_4

    .line 407
    :try_start_16
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$RequestContext;->aborted:Z

    move/from16 v38, v0

    if-eqz v38, :cond_13

    .line 408
    monitor-exit v39
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_5

    .line 422
    :try_start_17
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    move-object/from16 v0, v39

    move-object/from16 v1, v38

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 423
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v18 .. v18}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V
    :try_end_17
    .catch Ljava/io/FileNotFoundException; {:try_start_17 .. :try_end_17} :catch_2
    .catch Ljava/io/IOException; {:try_start_17 .. :try_end_17} :catch_3
    .catch Lorg/json/JSONException; {:try_start_17 .. :try_end_17} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_5
    .catchall {:try_start_17 .. :try_end_17} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_18
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_3

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 454
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :catchall_3
    move-exception v38

    :try_start_19
    monitor-exit v39
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_3

    throw v38

    .line 410
    :cond_13
    :try_start_1a
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    move-object/from16 v0, v18

    move-object/from16 v1, v38

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 411
    monitor-exit v39
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_5

    .line 413
    :try_start_1b
    new-instance v23, Ljava/io/ByteArrayOutputStream;

    const/16 v38, 0x400

    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v39

    invoke-static/range {v38 .. v39}, Ljava/lang/Math;->max(II)I

    move-result v38

    move-object/from16 v0, v23

    move/from16 v1, v38

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 414
    .local v23, "out":Ljava/io/ByteArrayOutputStream;
    const/16 v38, 0x400

    move/from16 v0, v38

    new-array v5, v0, [B

    .line 415
    const/4 v8, 0x0

    .line 417
    :goto_8
    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Ljava/io/InputStream;->read([B)I

    move-result v8

    if-lez v8, :cond_14

    .line 418
    const/16 v38, 0x0

    move-object/from16 v0, v23

    move/from16 v1, v38

    invoke-virtual {v0, v5, v1, v8}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_4

    goto :goto_8

    .line 422
    .end local v23    # "out":Ljava/io/ByteArrayOutputStream;
    :catchall_4
    move-exception v38

    :try_start_1c
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v39, v0

    const/16 v40, 0x0

    move-object/from16 v0, v40

    move-object/from16 v1, v39

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 423
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v18 .. v18}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    throw v38
    :try_end_1c
    .catch Ljava/io/FileNotFoundException; {:try_start_1c .. :try_end_1c} :catch_2
    .catch Ljava/io/IOException; {:try_start_1c .. :try_end_1c} :catch_3
    .catch Lorg/json/JSONException; {:try_start_1c .. :try_end_1c} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_5
    .catchall {:try_start_1c .. :try_end_1c} :catchall_b

    .line 443
    .end local v3    # "beforeData":Ljava/lang/StringBuilder;
    .end local v4    # "beforeDataBytes":[B
    .end local v5    # "buffer":[B
    .end local v6    # "bufferSize":I
    .end local v7    # "bytesAvailable":I
    .end local v8    # "bytesRead":I
    .end local v10    # "cookie":Ljava/lang/String;
    .end local v18    # "inStream":Ljava/io/InputStream;
    .end local v24    # "prevBytesRead":J
    .end local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v28    # "responseCode":I
    .end local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .end local v31    # "sendStream":Ljava/io/OutputStream;
    .end local v32    # "sourceInputStream":Ljava/io/InputStream;
    .end local v33    # "stringLength":I
    .end local v35    # "tailParamsBytes":[B
    .end local v37    # "useChunkedMode":Z
    :catch_4
    move-exception v11

    .line 444
    .local v11, "e":Lorg/json/JSONException;
    :try_start_1d
    const-string v38, "FileTransfer"

    invoke-virtual {v11}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-static {v0, v1, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 445
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    new-instance v39, Lorg/apache/cordova/api/PluginResult;

    sget-object v40, Lorg/apache/cordova/api/PluginResult$Status;->JSON_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-direct/range {v39 .. v40}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;)V

    invoke-virtual/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_1e
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_9

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 411
    .end local v11    # "e":Lorg/json/JSONException;
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    .restart local v3    # "beforeData":Ljava/lang/StringBuilder;
    .restart local v4    # "beforeDataBytes":[B
    .restart local v5    # "buffer":[B
    .restart local v6    # "bufferSize":I
    .restart local v7    # "bytesAvailable":I
    .restart local v8    # "bytesRead":I
    .restart local v10    # "cookie":Ljava/lang/String;
    .restart local v18    # "inStream":Ljava/io/InputStream;
    .restart local v24    # "prevBytesRead":J
    .restart local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .restart local v28    # "responseCode":I
    .restart local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .restart local v31    # "sendStream":Ljava/io/OutputStream;
    .restart local v32    # "sourceInputStream":Ljava/io/InputStream;
    .restart local v33    # "stringLength":I
    .restart local v35    # "tailParamsBytes":[B
    .restart local v37    # "useChunkedMode":Z
    :catchall_5
    move-exception v38

    :try_start_1f
    monitor-exit v39
    :try_end_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_5

    :try_start_20
    throw v38

    .line 420
    .restart local v23    # "out":Ljava/io/ByteArrayOutputStream;
    :cond_14
    const-string v38, "UTF-8"

    move-object/from16 v0, v23

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_20
    .catchall {:try_start_20 .. :try_end_20} :catchall_4

    move-result-object v29

    .line 422
    .local v29, "responseString":Ljava/lang/String;
    :try_start_21
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    move-object/from16 v0, v39

    move-object/from16 v1, v38

    iput-object v0, v1, Lorg/apache/cordova/FileTransfer$RequestContext;->currentInputStream:Ljava/io/InputStream;

    .line 423
    # invokes: Lorg/apache/cordova/FileTransfer;->safeClose(Ljava/io/Closeable;)V
    invoke-static/range {v18 .. v18}, Lorg/apache/cordova/FileTransfer;->access$300(Ljava/io/Closeable;)V

    .line 426
    const-string v38, "FileTransfer"

    const-string v39, "got response from server"

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 427
    const-string v38, "FileTransfer"

    const/16 v39, 0x0

    const/16 v40, 0x100

    invoke-virtual/range {v29 .. v29}, Ljava/lang/String;->length()I

    move-result v41

    invoke-static/range {v40 .. v41}, Ljava/lang/Math;->min(II)I

    move-result v40

    move-object/from16 v0, v29

    move/from16 v1, v39

    move/from16 v2, v40

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 430
    move-object/from16 v0, v30

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileUploadResult;->setResponseCode(I)V

    .line 431
    move-object/from16 v0, v30

    move-object/from16 v1, v29

    invoke-virtual {v0, v1}, Lorg/apache/cordova/FileUploadResult;->setResponse(Ljava/lang/String;)V

    .line 433
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    new-instance v39, Lorg/apache/cordova/api/PluginResult;

    sget-object v40, Lorg/apache/cordova/api/PluginResult$Status;->OK:Lorg/apache/cordova/api/PluginResult$Status;

    invoke-virtual/range {v30 .. v30}, Lorg/apache/cordova/FileUploadResult;->toJSONObject()Lorg/json/JSONObject;

    move-result-object v41

    invoke-direct/range {v39 .. v41}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_21
    .catch Ljava/io/FileNotFoundException; {:try_start_21 .. :try_end_21} :catch_2
    .catch Ljava/io/IOException; {:try_start_21 .. :try_end_21} :catch_3
    .catch Lorg/json/JSONException; {:try_start_21 .. :try_end_21} :catch_4
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_5
    .catchall {:try_start_21 .. :try_end_21} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_22
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_6

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 454
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :catchall_6
    move-exception v38

    :try_start_23
    monitor-exit v39
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_6

    throw v38

    .end local v3    # "beforeData":Ljava/lang/StringBuilder;
    .end local v4    # "beforeDataBytes":[B
    .end local v5    # "buffer":[B
    .end local v6    # "bufferSize":I
    .end local v7    # "bytesAvailable":I
    .end local v8    # "bytesRead":I
    .end local v10    # "cookie":Ljava/lang/String;
    .end local v18    # "inStream":Ljava/io/InputStream;
    .end local v23    # "out":Ljava/io/ByteArrayOutputStream;
    .end local v24    # "prevBytesRead":J
    .end local v26    # "progress":Lorg/apache/cordova/FileProgressResult;
    .end local v28    # "responseCode":I
    .end local v29    # "responseString":Ljava/lang/String;
    .end local v30    # "result":Lorg/apache/cordova/FileUploadResult;
    .end local v31    # "sendStream":Ljava/io/OutputStream;
    .end local v32    # "sourceInputStream":Ljava/io/InputStream;
    .end local v33    # "stringLength":I
    .end local v35    # "tailParamsBytes":[B
    .end local v37    # "useChunkedMode":Z
    .local v11, "e":Ljava/io/FileNotFoundException;
    .restart local v12    # "error":Lorg/json/JSONObject;
    :catchall_7
    move-exception v38

    :try_start_24
    monitor-exit v39
    :try_end_24
    .catchall {:try_start_24 .. :try_end_24} :catchall_7

    throw v38

    .local v11, "e":Ljava/io/IOException;
    :catchall_8
    move-exception v38

    :try_start_25
    monitor-exit v39
    :try_end_25
    .catchall {:try_start_25 .. :try_end_25} :catchall_8

    throw v38

    .end local v12    # "error":Lorg/json/JSONObject;
    .local v11, "e":Lorg/json/JSONException;
    :catchall_9
    move-exception v38

    :try_start_26
    monitor-exit v39
    :try_end_26
    .catchall {:try_start_26 .. :try_end_26} :catchall_9

    throw v38

    .line 446
    .end local v11    # "e":Lorg/json/JSONException;
    :catch_5
    move-exception v34

    .line 448
    .local v34, "t":Ljava/lang/Throwable;
    :try_start_27
    sget v38, Lorg/apache/cordova/FileTransfer;->CONNECTION_ERR:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$source:Ljava/lang/String;

    move-object/from16 v39, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$target:Ljava/lang/String;

    move-object/from16 v40, v0

    move/from16 v0, v38

    move-object/from16 v1, v39

    move-object/from16 v2, v40

    # invokes: Lorg/apache/cordova/FileTransfer;->createFileTransferError(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;
    invoke-static {v0, v1, v2, v9}, Lorg/apache/cordova/FileTransfer;->access$500(ILjava/lang/String;Ljava/lang/String;Ljava/net/URLConnection;)Lorg/json/JSONObject;

    move-result-object v12

    .line 449
    .restart local v12    # "error":Lorg/json/JSONObject;
    const-string v38, "FileTransfer"

    invoke-virtual {v12}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    move-object/from16 v2, v34

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 450
    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$context:Lorg/apache/cordova/FileTransfer$RequestContext;

    move-object/from16 v38, v0

    new-instance v39, Lorg/apache/cordova/api/PluginResult;

    sget-object v40, Lorg/apache/cordova/api/PluginResult$Status;->IO_EXCEPTION:Lorg/apache/cordova/api/PluginResult$Status;

    move-object/from16 v0, v39

    move-object/from16 v1, v40

    invoke-direct {v0, v1, v12}, Lorg/apache/cordova/api/PluginResult;-><init>(Lorg/apache/cordova/api/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual/range {v38 .. v39}, Lorg/apache/cordova/FileTransfer$RequestContext;->sendPluginResult(Lorg/apache/cordova/api/PluginResult;)V
    :try_end_27
    .catchall {:try_start_27 .. :try_end_27} :catchall_b

    .line 452
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_28
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v40, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_28
    .catchall {:try_start_28 .. :try_end_28} :catchall_a

    .line 456
    if-eqz v9, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v38, v0

    if-eqz v38, :cond_0

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto/16 :goto_0

    .line 454
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :catchall_a
    move-exception v38

    :try_start_29
    monitor-exit v39
    :try_end_29
    .catchall {:try_start_29 .. :try_end_29} :catchall_a

    throw v38

    .line 452
    .end local v12    # "error":Lorg/json/JSONObject;
    .end local v34    # "t":Ljava/lang/Throwable;
    :catchall_b
    move-exception v38

    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v39

    monitor-enter v39

    .line 453
    :try_start_2a
    # getter for: Lorg/apache/cordova/FileTransfer;->activeRequests:Ljava/util/HashMap;
    invoke-static {}, Lorg/apache/cordova/FileTransfer;->access$600()Ljava/util/HashMap;

    move-result-object v40

    move-object/from16 v0, p0

    iget-object v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$objectId:Ljava/lang/String;

    move-object/from16 v41, v0

    invoke-virtual/range {v40 .. v41}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 454
    monitor-exit v39
    :try_end_2a
    .catchall {:try_start_2a .. :try_end_2a} :catchall_c

    .line 456
    if-eqz v9, :cond_15

    .line 459
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$trustEveryone:Z

    move/from16 v39, v0

    if-eqz v39, :cond_15

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/apache/cordova/FileTransfer$1;->val$useHttps:Z

    move/from16 v39, v0

    if-eqz v39, :cond_15

    move-object/from16 v16, v9

    .line 460
    check-cast v16, Ljavax/net/ssl/HttpsURLConnection;

    .line 461
    .restart local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    move-object/from16 v0, v16

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 462
    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 463
    .end local v16    # "https":Ljavax/net/ssl/HttpsURLConnection;
    :cond_15
    throw v38

    .line 454
    :catchall_c
    move-exception v38

    :try_start_2b
    monitor-exit v39
    :try_end_2b
    .catchall {:try_start_2b .. :try_end_2b} :catchall_c

    throw v38
.end method

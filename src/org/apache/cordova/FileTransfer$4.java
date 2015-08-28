// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.util.Log;
import android.webkit.CookieManager;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import javax.net.ssl.HttpsURLConnection;
import org.apache.cordova.api.PluginResult;
import org.json.JSONException;
import org.json.JSONObject;

// Referenced classes of package org.apache.cordova:
//            FileTransfer, FileProgressResult, FileUtils

class val.objectId
    implements Runnable
{

    final FileTransfer this$0;
    final questContext val$context;
    final String val$objectId;
    final String val$source;
    final String val$target;
    final boolean val$trustEveryone;
    final URL val$url;
    final boolean val$useHttps;

    public void run()
    {
        Object obj2;
        Object obj3;
        javax.net.ssl.SSLSocketFactory sslsocketfactory;
        Object obj4;
        File file;
        Object obj5;
        javax.net.ssl.SSLSocketFactory sslsocketfactory1;
        Object obj6;
        javax.net.ssl.SSLSocketFactory sslsocketfactory2;
        Object obj7;
        javax.net.ssl.SSLSocketFactory sslsocketfactory3;
        Object obj8;
        javax.net.ssl.SSLSocketFactory sslsocketfactory4;
        File file2;
        File file3;
        Object obj9;
        Object obj10;
        File file4;
        File file5;
        Object obj11;
        Object obj12;
        Object obj13;
        Object obj14;
        Object obj15;
        Object obj16;
        FileProgressResult fileprogressresult;
        Object obj17;
        Object obj18;
        Object obj19;
        Object obj20;
        Object obj21;
        Object obj22;
        Object obj23;
        Object obj24;
        Object obj25;
        Object obj26;
        Object obj27;
        if (val$context.aborted)
        {
            return;
        }
        obj13 = null;
        obj15 = null;
        fileprogressresult = null;
        obj17 = null;
        obj = null;
        obj18 = null;
        obj19 = null;
        obj20 = null;
        obj21 = null;
        obj22 = null;
        obj3 = null;
        obj23 = null;
        obj24 = null;
        obj25 = null;
        obj26 = null;
        obj27 = null;
        sslsocketfactory = null;
        file3 = null;
        file4 = null;
        file5 = null;
        file = null;
        file2 = null;
        obj16 = null;
        obj14 = null;
        obj9 = obj;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        obj1 = obj22;
        obj2 = obj27;
        File file1 = FileTransfer.access$700(FileTransfer.this, val$target);
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        val$context.targetFile = file1;
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        file1.getParentFile().mkdirs();
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        if (!val$useHttps) goto _L2; else goto _L1
_L1:
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        if (val$trustEveryone) goto _L4; else goto _L3
_L3:
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        obj = (HttpsURLConnection)val$url.openConnection();
_L7:
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        if (!(obj instanceof HttpURLConnection))
        {
            break MISSING_BLOCK_LABEL_742;
        }
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        ((HttpURLConnection)obj).setRequestMethod("GET");
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        obj13 = CookieManager.getInstance().getCookie(val$source);
        if (obj13 == null)
        {
            break MISSING_BLOCK_LABEL_913;
        }
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        ((URLConnection) (obj)).setRequestProperty("cookie", ((String) (obj13)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        ((URLConnection) (obj)).connect();
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        Log.d("FileTransfer", (new StringBuilder()).append("Download file:").append(val$url).toString());
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        fileprogressresult = new FileProgressResult();
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        if (((URLConnection) (obj)).getContentEncoding() != null)
        {
            break MISSING_BLOCK_LABEL_1415;
        }
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        fileprogressresult.setLengthComputable(true);
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        fileprogressresult.setTotal(((URLConnection) (obj)).getContentLength());
        obj2 = null;
        obj1 = null;
        obj13 = FileTransfer.access$400(((URLConnection) (obj)));
        obj1 = obj13;
        obj15 = new FileOutputStream(file1);
        obj1 = val$context;
        obj1;
        JVM INSTR monitorenter ;
        if (!val$context.aborted) goto _L6; else goto _L5
_L5:
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        val$context.currentInputStream = null;
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj13)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj15)));
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj3)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory);
        }
        obj2 = obj14;
        if (true)
        {
            obj2 = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj))));
        }
        if (((PluginResult) (obj2)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file1 != null)
        {
            file1.delete();
        }
        obj1 = val$context;
        obj = obj2;
_L11:
        ((questContext) (obj1)).sendPluginResult(((PluginResult) (obj)));
        return;
_L4:
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        HttpsURLConnection httpsurlconnection = (HttpsURLConnection)val$url.openConnection();
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        sslsocketfactory = FileTransfer.access$000(httpsurlconnection);
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = sslsocketfactory;
        obj3 = httpsurlconnection.getHostnameVerifier();
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj17;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        httpsurlconnection.setHostnameVerifier(FileTransfer.access$100());
        obj = httpsurlconnection;
          goto _L7
_L2:
        obj9 = obj;
        file2 = file1;
        obj5 = obj18;
        sslsocketfactory1 = obj23;
        obj10 = obj13;
        file3 = file1;
        obj6 = obj19;
        sslsocketfactory2 = obj24;
        obj11 = obj15;
        file4 = file1;
        obj7 = obj20;
        sslsocketfactory3 = obj25;
        obj12 = fileprogressresult;
        file5 = file1;
        obj8 = obj21;
        sslsocketfactory4 = obj26;
        obj4 = obj17;
        file = file1;
        obj1 = obj22;
        obj2 = obj27;
        obj = val$url.openConnection();
          goto _L7
_L6:
        val$context.currentInputStream = ((InputStream) (obj13));
        obj1;
        JVM INSTR monitorexit ;
        obj1 = new byte[16384];
        long l = 0L;
_L10:
        int i = ((InputStream) (obj13)).read(((byte []) (obj1)));
        if (i <= 0) goto _L9; else goto _L8
_L8:
        ((FileOutputStream) (obj15)).write(((byte []) (obj1)), 0, i);
        l += i;
        fileprogressresult.setLoaded(l);
        obj2 = new PluginResult(org.apache.cordova.api.atus.OK, fileprogressresult.toJSONObject());
        ((PluginResult) (obj2)).setKeepCallback(true);
        val$context.sendPluginResult(((PluginResult) (obj2)));
          goto _L10
        obj1;
        obj14 = obj15;
        obj15 = obj1;
_L12:
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        val$context.currentInputStream = null;
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj13)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj14)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        throw obj15;
        obj;
        obj4 = obj9;
        file = file2;
        obj1 = obj5;
        obj2 = sslsocketfactory1;
        obj3 = FileTransfer.access$500(FileTransfer.FILE_NOT_FOUND_ERR, val$source, val$target, ((URLConnection) (obj9)));
        obj4 = obj9;
        file = file2;
        obj1 = obj5;
        obj2 = sslsocketfactory1;
        Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
        obj4 = obj9;
        file = file2;
        obj1 = obj5;
        obj2 = sslsocketfactory1;
        obj = new PluginResult(org.apache.cordova.api.atus.IO_EXCEPTION, ((JSONObject) (obj3)));
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj9 != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj9;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj5)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory1);
        }
        if (obj == null)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj9))));
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file2 != null)
        {
            file2.delete();
        }
        obj1 = val$context;
          goto _L11
        obj2;
        obj1;
        JVM INSTR monitorexit ;
        throw obj2;
_L9:
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        val$context.currentInputStream = null;
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj13)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        FileTransfer.access$300(((java.io.Closeable) (obj15)));
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        Log.d("FileTransfer", (new StringBuilder()).append("Saved file: ").append(val$target).toString());
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        obj13 = (new FileUtils()).getEntry(file1);
        obj9 = obj;
        file2 = file1;
        obj5 = obj3;
        sslsocketfactory1 = sslsocketfactory;
        obj10 = obj;
        file3 = file1;
        obj6 = obj3;
        sslsocketfactory2 = sslsocketfactory;
        obj11 = obj;
        file4 = file1;
        obj7 = obj3;
        sslsocketfactory3 = sslsocketfactory;
        obj12 = obj;
        file5 = file1;
        obj8 = obj3;
        sslsocketfactory4 = sslsocketfactory;
        obj4 = obj;
        file = file1;
        obj1 = obj3;
        obj2 = sslsocketfactory;
        obj13 = new PluginResult(org.apache.cordova.api.atus.OK, ((JSONObject) (obj13)));
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj3)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory);
        }
        Exception exception;
        if (obj13 == null)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj))));
        } else
        {
            obj = obj13;
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file1 != null)
        {
            file1.delete();
        }
        obj1 = val$context;
          goto _L11
        obj;
        obj4 = obj10;
        file = file3;
        obj1 = obj6;
        obj2 = sslsocketfactory2;
        obj3 = FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj10)));
        obj4 = obj10;
        file = file3;
        obj1 = obj6;
        obj2 = sslsocketfactory2;
        Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
        obj4 = obj10;
        file = file3;
        obj1 = obj6;
        obj2 = sslsocketfactory2;
        obj = new PluginResult(org.apache.cordova.api.atus.IO_EXCEPTION, ((JSONObject) (obj3)));
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj10 != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj10;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj6)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory2);
        }
        if (obj == null)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj10))));
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file3 != null)
        {
            file3.delete();
        }
        obj1 = val$context;
          goto _L11
        obj;
        obj4 = obj11;
        file = file4;
        obj1 = obj7;
        obj2 = sslsocketfactory3;
        Log.e("FileTransfer", ((JSONException) (obj)).getMessage(), ((Throwable) (obj)));
        obj4 = obj11;
        file = file4;
        obj1 = obj7;
        obj2 = sslsocketfactory3;
        obj = new PluginResult(org.apache.cordova.api.atus.JSON_EXCEPTION);
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj11 != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj11;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj7)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory3);
        }
        if (obj == null)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj11))));
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file4 != null)
        {
            file4.delete();
        }
        obj1 = val$context;
          goto _L11
        obj;
        obj4 = obj12;
        file = file5;
        obj1 = obj8;
        obj2 = sslsocketfactory4;
        obj3 = FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj12)));
        obj4 = obj12;
        file = file5;
        obj1 = obj8;
        obj2 = sslsocketfactory4;
        Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
        obj4 = obj12;
        file = file5;
        obj1 = obj8;
        obj2 = sslsocketfactory4;
        obj = new PluginResult(org.apache.cordova.api.atus.IO_EXCEPTION, ((JSONObject) (obj3)));
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj12 != null && val$trustEveryone && val$useHttps)
        {
            obj1 = (HttpsURLConnection)obj12;
            ((HttpsURLConnection) (obj1)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj8)));
            ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory4);
        }
        if (obj == null)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj12))));
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file5 != null)
        {
            file5.delete();
        }
        obj1 = val$context;
          goto _L11
        exception;
        synchronized (FileTransfer.access$600())
        {
            FileTransfer.access$600().remove(val$objectId);
        }
        if (obj4 != null && val$trustEveryone && val$useHttps)
        {
            obj = (HttpsURLConnection)obj4;
            ((HttpsURLConnection) (obj)).setHostnameVerifier(((javax.net.ssl.HostnameVerifier) (obj1)));
            ((HttpsURLConnection) (obj)).setSSLSocketFactory(((javax.net.ssl.SSLSocketFactory) (obj2)));
        }
        obj = obj16;
        if (true)
        {
            obj = new PluginResult(org.apache.cordova.api.atus.ERROR, FileTransfer.access$500(FileTransfer.CONNECTION_ERR, val$source, val$target, ((URLConnection) (obj4))));
        }
        if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.atus.OK.ordinal() && file != null)
        {
            file.delete();
        }
        val$context.sendPluginResult(((PluginResult) (obj)));
        throw exception;
        obj1;
        obj;
        JVM INSTR monitorexit ;
        throw obj1;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj;
        obj1;
        JVM INSTR monitorexit ;
        throw obj;
        obj15;
        obj13 = obj1;
        obj14 = obj2;
          goto _L12
    }

    questContext()
    {
        this$0 = final_filetransfer;
        val$context = questcontext;
        val$target = s;
        val$useHttps = flag;
        val$trustEveryone = flag1;
        val$url = url1;
        val$source = s1;
        val$objectId = String.this;
        super();
    }
}

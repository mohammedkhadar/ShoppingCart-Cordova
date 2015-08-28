// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.app.Activity;
import android.content.ContentResolver;
import android.net.Uri;
import android.util.Log;
import android.webkit.CookieManager;
import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.nio.channels.FileChannel;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.ExecutorService;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaInterface;
import org.apache.cordova.api.CordovaPlugin;
import org.apache.cordova.api.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

// Referenced classes of package org.apache.cordova:
//            Config, FileUploadResult, FileProgressResult, FileUtils

public class FileTransfer extends CordovaPlugin
{
    private static final class DoneHandlerInputStream extends FilterInputStream
    {

        private boolean done;

        public int read()
            throws IOException
        {
            int i;
            boolean flag;
            if (done)
            {
                i = -1;
            } else
            {
                i = super.read();
            }
            if (i == -1)
            {
                flag = true;
            } else
            {
                flag = false;
            }
            done = flag;
            return i;
        }

        public int read(byte abyte0[])
            throws IOException
        {
            int i;
            boolean flag;
            if (done)
            {
                i = -1;
            } else
            {
                i = super.read(abyte0);
            }
            if (i == -1)
            {
                flag = true;
            } else
            {
                flag = false;
            }
            done = flag;
            return i;
        }

        public int read(byte abyte0[], int i, int j)
            throws IOException
        {
            boolean flag;
            if (done)
            {
                i = -1;
            } else
            {
                i = super.read(abyte0, i, j);
            }
            if (i == -1)
            {
                flag = true;
            } else
            {
                flag = false;
            }
            done = flag;
            return i;
        }

        public DoneHandlerInputStream(InputStream inputstream)
        {
            super(inputstream);
        }
    }

    private static final class RequestContext
    {

        boolean aborted;
        CallbackContext callbackContext;
        InputStream currentInputStream;
        OutputStream currentOutputStream;
        String source;
        String target;
        File targetFile;

        void sendPluginResult(PluginResult pluginresult)
        {
            this;
            JVM INSTR monitorenter ;
            if (!aborted)
            {
                callbackContext.sendPluginResult(pluginresult);
            }
            this;
            JVM INSTR monitorexit ;
            return;
            pluginresult;
            this;
            JVM INSTR monitorexit ;
            throw pluginresult;
        }

        RequestContext(String s, String s1, CallbackContext callbackcontext)
        {
            source = s;
            target = s1;
            callbackContext = callbackcontext;
        }
    }


    public static int ABORTED_ERR = 0;
    private static final String BOUNDARY = "+++++";
    public static int CONNECTION_ERR = 0;
    private static final HostnameVerifier DO_NOT_VERIFY = new HostnameVerifier() {

        public boolean verify(String s, SSLSession sslsession)
        {
            return true;
        }

    };
    public static int FILE_NOT_FOUND_ERR = 0;
    public static int INVALID_URL_ERR = 0;
    private static final String LINE_END = "\r\n";
    private static final String LINE_START = "--";
    private static final String LOG_TAG = "FileTransfer";
    private static final int MAX_BUFFER_SIZE = 16384;
    private static HashMap activeRequests = new HashMap();
    private static final TrustManager trustAllCerts[] = {
        new X509TrustManager() {

            public void checkClientTrusted(X509Certificate ax509certificate[], String s)
                throws CertificateException
            {
            }

            public void checkServerTrusted(X509Certificate ax509certificate[], String s)
                throws CertificateException
            {
            }

            public X509Certificate[] getAcceptedIssuers()
            {
                return new X509Certificate[0];
            }

        }
    };

    public FileTransfer()
    {
    }

    private void abort(final String context)
    {
        synchronized (activeRequests)
        {
            context = (RequestContext)activeRequests.remove(context);
        }
        if (context == null)
        {
            break MISSING_BLOCK_LABEL_103;
        }
        obj = ((RequestContext) (context)).targetFile;
        if (obj != null)
        {
            ((File) (obj)).delete();
        }
        obj = createFileTransferError(ABORTED_ERR, ((RequestContext) (context)).source, ((RequestContext) (context)).target, Integer.valueOf(-1));
        context;
        JVM INSTR monitorenter ;
        context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, ((JSONObject) (obj))));
        context.aborted = true;
        context;
        JVM INSTR monitorexit ;
        cordova.getThreadPool().execute(new Runnable() {

            final FileTransfer this$0;
            final RequestContext val$context;

            public void run()
            {
                synchronized (context)
                {
                    FileTransfer.safeClose(context.currentInputStream);
                    FileTransfer.safeClose(context.currentOutputStream);
                }
                return;
                exception1;
                requestcontext;
                JVM INSTR monitorexit ;
                throw exception1;
            }

            
            {
                this$0 = FileTransfer.this;
                context = requestcontext;
                super();
            }
        });
        return;
        context;
        obj;
        JVM INSTR monitorexit ;
        throw context;
        Exception exception;
        exception;
        context;
        JVM INSTR monitorexit ;
        throw exception;
    }

    private static JSONObject createFileTransferError(int i, String s, String s1, Integer integer)
    {
        Object obj = null;
        JSONObject jsonobject = new JSONObject();
        jsonobject.put("code", i);
        jsonobject.put("source", s);
        jsonobject.put("target", s1);
        if (integer == null)
        {
            break MISSING_BLOCK_LABEL_52;
        }
        jsonobject.put("http_status", integer);
        return jsonobject;
        s;
        s1 = obj;
_L2:
        Log.e("FileTransfer", s.getMessage(), s);
        return s1;
        s;
        s1 = jsonobject;
        if (true) goto _L2; else goto _L1
_L1:
    }

    private static JSONObject createFileTransferError(int i, String s, String s1, URLConnection urlconnection)
    {
        boolean flag = false;
        int j = ((flag) ? 1 : 0);
        if (urlconnection != null)
        {
            j = ((flag) ? 1 : 0);
            try
            {
                if (urlconnection instanceof HttpURLConnection)
                {
                    j = ((HttpURLConnection)urlconnection).getResponseCode();
                }
            }
            // Misplaced declaration of an exception variable
            catch (URLConnection urlconnection)
            {
                Log.w("FileTransfer", "Error getting HTTP status code from connection.", urlconnection);
                j = ((flag) ? 1 : 0);
            }
        }
        return createFileTransferError(i, s, s1, Integer.valueOf(j));
    }

    private void download(final String source, final String target, final JSONArray objectId, CallbackContext callbackcontext)
        throws JSONException
    {
        Log.d("FileTransfer", (new StringBuilder()).append("download ").append(source).append(" to ").append(target).toString());
        final boolean trustEveryone = objectId.optBoolean(2);
        objectId = objectId.getString(3);
        final URL url;
        final boolean useHttps;
        try
        {
            url = new URL(source);
        }
        // Misplaced declaration of an exception variable
        catch (final JSONArray objectId)
        {
            source = createFileTransferError(INVALID_URL_ERR, source, target, Integer.valueOf(0));
            Log.e("FileTransfer", source.toString(), objectId);
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, source));
            return;
        }
        useHttps = url.getProtocol().equals("https");
        if (!Config.isUrlWhiteListed(source))
        {
            Log.w("FileTransfer", (new StringBuilder()).append("Source URL is not in white list: '").append(source).append("'").toString());
            source = createFileTransferError(CONNECTION_ERR, source, target, Integer.valueOf(401));
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, source));
            return;
        }
        final RequestContext context = new RequestContext(source, target, callbackcontext);
        synchronized (activeRequests)
        {
            activeRequests.put(objectId, context);
        }
        cordova.getThreadPool().execute(new Runnable() {

            final FileTransfer this$0;
            final RequestContext val$context;
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
                SSLSocketFactory sslsocketfactory;
                Object obj4;
                File file;
                Object obj5;
                SSLSocketFactory sslsocketfactory1;
                Object obj6;
                SSLSocketFactory sslsocketfactory2;
                Object obj7;
                SSLSocketFactory sslsocketfactory3;
                Object obj8;
                SSLSocketFactory sslsocketfactory4;
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
                if (context.aborted)
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
                File file1 = getFileFromPath(target);
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
                context.targetFile = file1;
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
                if (!useHttps) goto _L2; else goto _L1
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
                if (trustEveryone) goto _L4; else goto _L3
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
                obj = (HttpsURLConnection)url.openConnection();
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
                obj13 = CookieManager.getInstance().getCookie(source);
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
                Log.d("FileTransfer", (new StringBuilder()).append("Download file:").append(url).toString());
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
                obj13 = FileTransfer.getInputStream(((URLConnection) (obj)));
                obj1 = obj13;
                obj15 = new FileOutputStream(file1);
                obj1 = context;
                obj1;
                JVM INSTR monitorenter ;
                if (!context.aborted) goto _L6; else goto _L5
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
                context.currentInputStream = null;
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
                FileTransfer.safeClose(((Closeable) (obj13)));
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
                FileTransfer.safeClose(((Closeable) (obj15)));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj3)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory);
                }
                obj2 = obj14;
                if (true)
                {
                    obj2 = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj))));
                }
                if (((PluginResult) (obj2)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file1 != null)
                {
                    file1.delete();
                }
                obj1 = context;
                obj = obj2;
_L11:
                ((RequestContext) (obj1)).sendPluginResult(((PluginResult) (obj)));
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
                HttpsURLConnection httpsurlconnection = (HttpsURLConnection)url.openConnection();
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
                sslsocketfactory = FileTransfer.trustAllHosts(httpsurlconnection);
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
                httpsurlconnection.setHostnameVerifier(FileTransfer.DO_NOT_VERIFY);
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
                obj = url.openConnection();
                  goto _L7
_L6:
                context.currentInputStream = ((InputStream) (obj13));
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
                obj2 = new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, fileprogressresult.toJSONObject());
                ((PluginResult) (obj2)).setKeepCallback(true);
                context.sendPluginResult(((PluginResult) (obj2)));
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
                context.currentInputStream = null;
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
                FileTransfer.safeClose(((Closeable) (obj13)));
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
                FileTransfer.safeClose(((Closeable) (obj14)));
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
                obj3 = FileTransfer.createFileTransferError(FileTransfer.FILE_NOT_FOUND_ERR, source, target, ((URLConnection) (obj9)));
                obj4 = obj9;
                file = file2;
                obj1 = obj5;
                obj2 = sslsocketfactory1;
                Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
                obj4 = obj9;
                file = file2;
                obj1 = obj5;
                obj2 = sslsocketfactory1;
                obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj3)));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj9 != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj9;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj5)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory1);
                }
                if (obj == null)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj9))));
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file2 != null)
                {
                    file2.delete();
                }
                obj1 = context;
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
                context.currentInputStream = null;
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
                FileTransfer.safeClose(((Closeable) (obj13)));
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
                FileTransfer.safeClose(((Closeable) (obj15)));
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
                Log.d("FileTransfer", (new StringBuilder()).append("Saved file: ").append(target).toString());
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
                obj13 = new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, ((JSONObject) (obj13)));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj3)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory);
                }
                Exception exception;
                if (obj13 == null)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj))));
                } else
                {
                    obj = obj13;
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file1 != null)
                {
                    file1.delete();
                }
                obj1 = context;
                  goto _L11
                obj;
                obj4 = obj10;
                file = file3;
                obj1 = obj6;
                obj2 = sslsocketfactory2;
                obj3 = FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj10)));
                obj4 = obj10;
                file = file3;
                obj1 = obj6;
                obj2 = sslsocketfactory2;
                Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
                obj4 = obj10;
                file = file3;
                obj1 = obj6;
                obj2 = sslsocketfactory2;
                obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj3)));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj10 != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj10;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj6)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory2);
                }
                if (obj == null)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj10))));
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file3 != null)
                {
                    file3.delete();
                }
                obj1 = context;
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
                obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.JSON_EXCEPTION);
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj11 != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj11;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj7)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory3);
                }
                if (obj == null)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj11))));
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file4 != null)
                {
                    file4.delete();
                }
                obj1 = context;
                  goto _L11
                obj;
                obj4 = obj12;
                file = file5;
                obj1 = obj8;
                obj2 = sslsocketfactory4;
                obj3 = FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj12)));
                obj4 = obj12;
                file = file5;
                obj1 = obj8;
                obj2 = sslsocketfactory4;
                Log.e("FileTransfer", ((JSONObject) (obj3)).toString(), ((Throwable) (obj)));
                obj4 = obj12;
                file = file5;
                obj1 = obj8;
                obj2 = sslsocketfactory4;
                obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj3)));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj12 != null && trustEveryone && useHttps)
                {
                    obj1 = (HttpsURLConnection)obj12;
                    ((HttpsURLConnection) (obj1)).setHostnameVerifier(((HostnameVerifier) (obj8)));
                    ((HttpsURLConnection) (obj1)).setSSLSocketFactory(sslsocketfactory4);
                }
                if (obj == null)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj12))));
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file5 != null)
                {
                    file5.delete();
                }
                obj1 = context;
                  goto _L11
                exception;
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj4 != null && trustEveryone && useHttps)
                {
                    obj = (HttpsURLConnection)obj4;
                    ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj1)));
                    ((HttpsURLConnection) (obj)).setSSLSocketFactory(((SSLSocketFactory) (obj2)));
                }
                obj = obj16;
                if (true)
                {
                    obj = new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj4))));
                }
                if (((PluginResult) (obj)).getStatus() != org.apache.cordova.api.PluginResult.Status.OK.ordinal() && file != null)
                {
                    file.delete();
                }
                context.sendPluginResult(((PluginResult) (obj)));
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

            
            {
                this$0 = FileTransfer.this;
                context = requestcontext;
                target = s;
                useHttps = flag;
                trustEveryone = flag1;
                url = url1;
                source = s1;
                objectId = s2;
                super();
            }
        });
        return;
        source;
        callbackcontext;
        JVM INSTR monitorexit ;
        throw source;
    }

    private static String getArgument(JSONArray jsonarray, int i, String s)
    {
        Object obj;
label0:
        {
            obj = s;
            if (jsonarray.length() < i)
            {
                break label0;
            }
            jsonarray = jsonarray.optString(i);
            if (jsonarray != null)
            {
                obj = jsonarray;
                if (!"null".equals(jsonarray))
                {
                    break label0;
                }
            }
            obj = s;
        }
        return ((String) (obj));
    }

    private File getFileFromPath(String s)
        throws FileNotFoundException
    {
        if (s.startsWith("file://"))
        {
            s = new File(s.substring("file://".length()));
        } else
        {
            s = new File(s);
        }
        if (s.getParent() == null)
        {
            throw new FileNotFoundException();
        } else
        {
            return s;
        }
    }

    private static InputStream getInputStream(URLConnection urlconnection)
        throws IOException
    {
        if (android.os.Build.VERSION.SDK_INT < 11)
        {
            return new DoneHandlerInputStream(urlconnection.getInputStream());
        } else
        {
            return urlconnection.getInputStream();
        }
    }

    private InputStream getPathFromUri(String s)
        throws FileNotFoundException
    {
        if (s.startsWith("content:"))
        {
            s = Uri.parse(s);
            return cordova.getActivity().getContentResolver().openInputStream(s);
        }
        if (s.startsWith("file://"))
        {
            int i = s.indexOf("?");
            if (i == -1)
            {
                return new FileInputStream(s.substring(7));
            } else
            {
                return new FileInputStream(s.substring(7, i));
            }
        } else
        {
            return new FileInputStream(s);
        }
    }

    private static void safeClose(Closeable closeable)
    {
        if (closeable == null)
        {
            break MISSING_BLOCK_LABEL_10;
        }
        closeable.close();
        return;
        closeable;
    }

    private static SSLSocketFactory trustAllHosts(HttpsURLConnection httpsurlconnection)
    {
        SSLSocketFactory sslsocketfactory = httpsurlconnection.getSSLSocketFactory();
        try
        {
            SSLContext sslcontext = SSLContext.getInstance("TLS");
            sslcontext.init(null, trustAllCerts, new SecureRandom());
            httpsurlconnection.setSSLSocketFactory(sslcontext.getSocketFactory());
        }
        // Misplaced declaration of an exception variable
        catch (HttpsURLConnection httpsurlconnection)
        {
            Log.e("FileTransfer", httpsurlconnection.getMessage(), httpsurlconnection);
            return sslsocketfactory;
        }
        return sslsocketfactory;
    }

    private void upload(final String source, final String target, final JSONArray objectId, CallbackContext callbackcontext)
        throws JSONException
    {
        Log.d("FileTransfer", (new StringBuilder()).append("upload ").append(source).append(" to ").append(target).toString());
        final String fileKey = getArgument(objectId, 2, "file");
        final String fileName = getArgument(objectId, 3, "image.jpg");
        final String mimeType = getArgument(objectId, 4, "image/jpeg");
        final JSONObject params;
        final JSONObject headers;
        final URL url;
        final RequestContext context;
        final boolean chunkedMode;
        final boolean trustEveryone;
        final boolean useHttps;
        if (objectId.optJSONObject(5) == null)
        {
            params = new JSONObject();
        } else
        {
            params = objectId.optJSONObject(5);
        }
        trustEveryone = objectId.optBoolean(6);
        if (objectId.optBoolean(7) || objectId.isNull(7))
        {
            chunkedMode = true;
        } else
        {
            chunkedMode = false;
        }
        if (objectId.optJSONObject(8) == null)
        {
            headers = params.optJSONObject("headers");
        } else
        {
            headers = objectId.optJSONObject(8);
        }
        objectId = objectId.getString(9);
        Log.d("FileTransfer", (new StringBuilder()).append("fileKey: ").append(fileKey).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("fileName: ").append(fileName).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("mimeType: ").append(mimeType).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("params: ").append(params).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("trustEveryone: ").append(trustEveryone).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("chunkedMode: ").append(chunkedMode).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("headers: ").append(headers).toString());
        Log.d("FileTransfer", (new StringBuilder()).append("objectId: ").append(objectId).toString());
        try
        {
            url = new URL(target);
        }
        // Misplaced declaration of an exception variable
        catch (final JSONArray objectId)
        {
            source = createFileTransferError(INVALID_URL_ERR, source, target, Integer.valueOf(0));
            Log.e("FileTransfer", source.toString(), objectId);
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, source));
            return;
        }
        useHttps = url.getProtocol().equals("https");
        context = new RequestContext(source, target, callbackcontext);
        synchronized (activeRequests)
        {
            activeRequests.put(objectId, context);
        }
        cordova.getThreadPool().execute(new Runnable() {

            final FileTransfer this$0;
            final boolean val$chunkedMode;
            final RequestContext val$context;
            final String val$fileKey;
            final String val$fileName;
            final JSONObject val$headers;
            final String val$mimeType;
            final String val$objectId;
            final JSONObject val$params;
            final String val$source;
            final String val$target;
            final boolean val$trustEveryone;
            final URL val$url;
            final boolean val$useHttps;

            public void run()
            {
                if (!context.aborted) goto _L2; else goto _L1
_L1:
                return;
_L2:
                Object obj4;
                Object obj5;
                SSLSocketFactory sslsocketfactory;
                Object obj7;
                Object obj8;
                SSLSocketFactory sslsocketfactory1;
                Object obj9;
                SSLSocketFactory sslsocketfactory2;
                Object obj10;
                SSLSocketFactory sslsocketfactory3;
                Object obj11;
                Object obj12;
                Object obj13;
                Object obj14;
                Object obj15;
                Object obj16;
                Object obj17;
                Object obj18;
                Object obj19;
                byte abyte0[];
                byte abyte1[];
                Object obj20;
                Object obj21;
                Object obj22;
                Object obj23;
                Object obj24;
                Object obj25;
                Object obj26;
                Object obj27;
                Object obj28;
                int i;
                int k;
                int l;
                int i1;
                boolean flag;
                obj17 = null;
                obj18 = null;
                obj19 = null;
                abyte0 = null;
                obj = null;
                abyte1 = null;
                obj20 = null;
                obj21 = null;
                obj22 = null;
                obj23 = null;
                obj5 = null;
                obj24 = null;
                obj25 = null;
                obj26 = null;
                obj27 = null;
                obj28 = null;
                sslsocketfactory = null;
                flag = false;
                i1 = 0;
                i = -1;
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                FileUploadResult fileuploadresult = new FileUploadResult();
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                FileProgressResult fileprogressresult = new FileProgressResult();
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                if (!useHttps) goto _L4; else goto _L3
_L3:
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                if (trustEveryone) goto _L6; else goto _L5
_L5:
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                obj = (HttpsURLConnection)url.openConnection();
_L11:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setDoInput(true);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setDoOutput(true);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setUseCaches(false);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setRequestMethod("POST");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setRequestProperty("Content-Type", "multipart/form-data;boundary=+++++");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj17 = CookieManager.getInstance().getCookie(target);
                if (obj17 == null)
                {
                    break MISSING_BLOCK_LABEL_919;
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setRequestProperty("Cookie", ((String) (obj17)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj17 = headers;
                if (obj17 == null)
                {
                    break; /* Loop/switch isn't completed */
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj16 = headers.keys();
_L8:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (!((Iterator) (obj16)).hasNext())
                {
                    break; /* Loop/switch isn't completed */
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj17 = ((Iterator) (obj16)).next().toString();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj12 = headers.optJSONArray(((String) (obj17)));
                obj11 = obj12;
                if (obj12 != null)
                {
                    break MISSING_BLOCK_LABEL_1366;
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj11 = new JSONArray();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((JSONArray) (obj11)).put(headers.getString(((String) (obj17))));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setRequestProperty(((String) (obj17)), ((JSONArray) (obj11)).getString(0));
                int j = 1;
_L9:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (j >= ((JSONArray) (obj11)).length()) goto _L8; else goto _L7
_L7:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).addRequestProperty(((String) (obj17)), ((JSONArray) (obj11)).getString(j));
                j++;
                  goto _L9
_L6:
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                HttpsURLConnection httpsurlconnection = (HttpsURLConnection)url.openConnection();
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                sslsocketfactory = FileTransfer.trustAllHosts(httpsurlconnection);
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = sslsocketfactory;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = sslsocketfactory;
                obj5 = httpsurlconnection.getHostnameVerifier();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj17;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj19;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = abyte0;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                httpsurlconnection.setHostnameVerifier(FileTransfer.DO_NOT_VERIFY);
                obj = httpsurlconnection;
                continue; /* Loop/switch isn't completed */
_L4:
                obj13 = obj;
                obj8 = abyte1;
                sslsocketfactory1 = obj24;
                obj14 = obj17;
                k = i;
                obj9 = obj20;
                sslsocketfactory2 = obj25;
                l = ((flag) ? 1 : 0);
                obj16 = obj18;
                obj11 = obj21;
                obj12 = obj26;
                obj15 = obj19;
                obj10 = obj22;
                sslsocketfactory3 = obj27;
                obj7 = abyte0;
                obj3 = obj23;
                obj4 = obj28;
                obj = (HttpURLConnection)url.openConnection();
                if (true) goto _L11; else goto _L10
_L10:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj17 = new StringBuilder();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj11 = params.keys();
_L13:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (!((Iterator) (obj11)).hasNext())
                {
                    break MISSING_BLOCK_LABEL_2660;
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj12 = ((Iterator) (obj11)).next();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (String.valueOf(obj12).equals("headers")) goto _L13; else goto _L12
_L12:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("--").append("+++++").append("\r\n");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("Content-Disposition: form-data; name=\"").append(obj12.toString()).append('"');
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("\r\n").append("\r\n");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append(params.getString(obj12.toString()));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("\r\n");
                  goto _L13
                JSONException jsonexception1;
                jsonexception1;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.e("FileTransfer", jsonexception1.getMessage(), jsonexception1);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("--").append("+++++").append("\r\n");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("Content-Disposition: form-data; name=\"").append(fileKey).append("\";");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append(" filename=\"").append(fileName).append('"').append("\r\n");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((StringBuilder) (obj17)).append("Content-Type: ").append(mimeType).append("\r\n").append("\r\n");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                abyte1 = ((StringBuilder) (obj17)).toString().getBytes("UTF-8");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                abyte0 = "\r\n--+++++--\r\n".getBytes("UTF-8");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                obj19 = getPathFromUri(source);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                int j1 = abyte1.length;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                int k1 = abyte0.length;
                j = i;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (!(obj19 instanceof FileInputStream))
                {
                    break MISSING_BLOCK_LABEL_3631;
                }
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = i;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                j = (int)((FileInputStream)obj19).getChannel().size() + (j1 + k1);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                fileprogressresult.setLengthComputable(true);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                fileprogressresult.setTotal(j);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", (new StringBuilder()).append("Content Length: ").append(j).toString());
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (!chunkedMode) goto _L15; else goto _L14
_L14:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (android.os.Build.VERSION.SDK_INT < 8) goto _L17; else goto _L16
_L16:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                if (!useHttps) goto _L15; else goto _L17
_L23:
                if (i == 0) goto _L19; else goto _L18
_L18:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setChunkedStreamingMode(16384);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setRequestProperty("Transfer-Encoding", "chunked");
_L24:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).connect();
                obj17 = null;
                i = i1;
                jsonexception1 = ((HttpURLConnection) (obj)).getOutputStream();
                obj17 = jsonexception1;
                i = i1;
                obj3 = context;
                obj17 = jsonexception1;
                i = i1;
                obj3;
                JVM INSTR monitorenter ;
                if (!context.aborted) goto _L21; else goto _L20
_L20:
                obj3;
                JVM INSTR monitorexit ;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(((Closeable) (obj19)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(jsonexception1);
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj != null && trustEveryone && useHttps)
                {
                    obj = (HttpsURLConnection)obj;
                    ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj5)));
                    ((HttpsURLConnection) (obj)).setSSLSocketFactory(sslsocketfactory);
                    return;
                }
                  goto _L1
_L15:
                i = 0;
                  goto _L22
_L36:
                i = 0;
                  goto _L23
_L19:
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = ((flag) ? 1 : 0);
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                ((HttpURLConnection) (obj)).setFixedLengthStreamingMode(j);
                  goto _L24
                obj;
                obj7 = obj13;
                obj3 = obj8;
                obj4 = sslsocketfactory1;
                obj5 = FileTransfer.createFileTransferError(FileTransfer.FILE_NOT_FOUND_ERR, source, target, ((URLConnection) (obj13)));
                obj7 = obj13;
                obj3 = obj8;
                obj4 = sslsocketfactory1;
                Log.e("FileTransfer", ((JSONObject) (obj5)).toString(), ((Throwable) (obj)));
                obj7 = obj13;
                obj3 = obj8;
                obj4 = sslsocketfactory1;
                context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj5))));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj13 == null || !trustEveryone || !useHttps) goto _L1; else goto _L25
_L25:
                obj = (HttpsURLConnection)obj13;
                ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj8)));
                ((HttpsURLConnection) (obj)).setSSLSocketFactory(sslsocketfactory1);
                return;
                obj;
                obj3;
                JVM INSTR monitorexit ;
                throw obj;
_L21:
                context.currentOutputStream = jsonexception1;
                obj3;
                JVM INSTR monitorexit ;
                obj17 = jsonexception1;
                i = i1;
                jsonexception1.write(abyte1);
                obj17 = jsonexception1;
                i = i1;
                k = 0 + abyte1.length;
                obj17 = jsonexception1;
                i = k;
                l = Math.min(((InputStream) (obj19)).available(), 16384);
                obj17 = jsonexception1;
                i = k;
                obj3 = new byte[l];
                obj17 = jsonexception1;
                i = k;
                l = ((InputStream) (obj19)).read(((byte []) (obj3)), 0, l);
                long l1 = 0L;
_L27:
                if (l <= 0)
                {
                    break; /* Loop/switch isn't completed */
                }
                obj17 = jsonexception1;
                i = k;
                fileuploadresult.setBytesSent(k);
                obj17 = jsonexception1;
                i = k;
                jsonexception1.write(((byte []) (obj3)), 0, l);
                long l2;
                k += l;
                l2 = l1;
                if ((long)k <= 0x19000L + l1)
                {
                    break MISSING_BLOCK_LABEL_4811;
                }
                l2 = k;
                obj17 = jsonexception1;
                i = k;
                Log.d("FileTransfer", (new StringBuilder()).append("Uploaded ").append(k).append(" of ").append(j).append(" bytes").toString());
                obj17 = jsonexception1;
                i = k;
                l = ((InputStream) (obj19)).read(((byte []) (obj3)), 0, Math.min(((InputStream) (obj19)).available(), 16384));
                obj17 = jsonexception1;
                i = k;
                fileprogressresult.setLoaded(k);
                obj17 = jsonexception1;
                i = k;
                obj4 = new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, fileprogressresult.toJSONObject());
                obj17 = jsonexception1;
                i = k;
                ((PluginResult) (obj4)).setKeepCallback(true);
                obj17 = jsonexception1;
                i = k;
                context.sendPluginResult(((PluginResult) (obj4)));
                l1 = l2;
                if (true) goto _L27; else goto _L26
                jsonexception1;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(((Closeable) (obj19)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(((Closeable) (obj17)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                throw jsonexception1;
                obj;
                obj7 = obj14;
                obj3 = obj9;
                obj4 = sslsocketfactory2;
                obj5 = FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj14)));
                obj7 = obj14;
                obj3 = obj9;
                obj4 = sslsocketfactory2;
                Log.e("FileTransfer", ((JSONObject) (obj5)).toString(), ((Throwable) (obj)));
                obj7 = obj14;
                obj3 = obj9;
                obj4 = sslsocketfactory2;
                Log.e("FileTransfer", (new StringBuilder()).append("Failed after uploading ").append(l).append(" of ").append(k).append(" bytes.").toString());
                obj7 = obj14;
                obj3 = obj9;
                obj4 = sslsocketfactory2;
                context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj5))));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj14 == null || !trustEveryone || !useHttps) goto _L1; else goto _L28
_L28:
                obj = (HttpsURLConnection)obj14;
                ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj9)));
                ((HttpsURLConnection) (obj)).setSSLSocketFactory(sslsocketfactory2);
                return;
                obj4;
                obj3;
                JVM INSTR monitorexit ;
                obj17 = jsonexception1;
                i = i1;
                throw obj4;
_L26:
                obj17 = jsonexception1;
                i = k;
                jsonexception1.write(abyte0);
                obj17 = jsonexception1;
                i = k;
                i1 = k + abyte0.length;
                obj17 = jsonexception1;
                i = i1;
                jsonexception1.flush();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(((Closeable) (obj19)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(jsonexception1);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                context.currentOutputStream = null;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", (new StringBuilder()).append("Sent ").append(i1).append(" of ").append(j).toString());
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                i = ((HttpURLConnection) (obj)).getResponseCode();
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", (new StringBuilder()).append("response code: ").append(i).toString());
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", (new StringBuilder()).append("response headers: ").append(((HttpURLConnection) (obj)).getHeaderFields()).toString());
                obj17 = null;
                jsonexception1 = FileTransfer.getInputStream(((URLConnection) (obj)));
                obj17 = jsonexception1;
                obj3 = context;
                obj17 = jsonexception1;
                obj3;
                JVM INSTR monitorenter ;
                if (!context.aborted)
                {
                    break MISSING_BLOCK_LABEL_6137;
                }
                obj3;
                JVM INSTR monitorexit ;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                context.currentInputStream = null;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(jsonexception1);
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj == null || !trustEveryone || !useHttps) goto _L1; else goto _L29
_L29:
                obj = (HttpsURLConnection)obj;
                ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj5)));
                ((HttpsURLConnection) (obj)).setSSLSocketFactory(sslsocketfactory);
                return;
                obj;
                obj3;
                JVM INSTR monitorexit ;
                throw obj;
                context.currentInputStream = jsonexception1;
                obj3;
                JVM INSTR monitorexit ;
                obj17 = jsonexception1;
                obj3 = new ByteArrayOutputStream(Math.max(1024, ((HttpURLConnection) (obj)).getContentLength()));
                obj17 = jsonexception1;
                obj4 = new byte[1024];
_L31:
                obj17 = jsonexception1;
                k = jsonexception1.read(((byte []) (obj4)));
                if (k <= 0)
                {
                    break; /* Loop/switch isn't completed */
                }
                obj17 = jsonexception1;
                ((ByteArrayOutputStream) (obj3)).write(((byte []) (obj4)), 0, k);
                if (true) goto _L31; else goto _L30
                jsonexception1;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                context.currentInputStream = null;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(((Closeable) (obj17)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                throw jsonexception1;
                obj;
                obj7 = obj16;
                obj3 = obj11;
                obj4 = obj12;
                Log.e("FileTransfer", ((JSONException) (obj)).getMessage(), ((Throwable) (obj)));
                obj7 = obj16;
                obj3 = obj11;
                obj4 = obj12;
                context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.JSON_EXCEPTION));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj16 == null || !trustEveryone || !useHttps) goto _L1; else goto _L32
_L32:
                obj = (HttpsURLConnection)obj16;
                ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj11)));
                ((HttpsURLConnection) (obj)).setSSLSocketFactory(((SSLSocketFactory) (obj12)));
                return;
                obj4;
                obj3;
                JVM INSTR monitorexit ;
                obj17 = jsonexception1;
                throw obj4;
_L30:
                obj17 = jsonexception1;
                obj19 = ((ByteArrayOutputStream) (obj3)).toString("UTF-8");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                context.currentInputStream = null;
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                FileTransfer.safeClose(jsonexception1);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", "got response from server");
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                Log.d("FileTransfer", ((String) (obj19)).substring(0, Math.min(256, ((String) (obj19)).length())));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                fileuploadresult.setResponseCode(i);
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                fileuploadresult.setResponse(((String) (obj19)));
                obj13 = obj;
                obj8 = obj5;
                sslsocketfactory1 = sslsocketfactory;
                obj14 = obj;
                k = j;
                obj9 = obj5;
                sslsocketfactory2 = sslsocketfactory;
                l = i1;
                obj16 = obj;
                obj11 = obj5;
                obj12 = sslsocketfactory;
                obj15 = obj;
                obj10 = obj5;
                sslsocketfactory3 = sslsocketfactory;
                obj7 = obj;
                obj3 = obj5;
                obj4 = sslsocketfactory;
                context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, fileuploadresult.toJSONObject()));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj == null || !trustEveryone || !useHttps) goto _L1; else goto _L33
_L33:
                obj = (HttpsURLConnection)obj;
                ((HttpsURLConnection) (obj)).setHostnameVerifier(((HostnameVerifier) (obj5)));
                ((HttpsURLConnection) (obj)).setSSLSocketFactory(sslsocketfactory);
                return;
                obj;
                obj3;
                JVM INSTR monitorexit ;
                throw obj;
                obj3;
                obj;
                JVM INSTR monitorexit ;
                throw obj3;
                obj3;
                obj;
                JVM INSTR monitorexit ;
                throw obj3;
                obj3;
                obj;
                JVM INSTR monitorexit ;
                throw obj3;
                Object obj1;
                obj1;
                obj7 = obj15;
                obj3 = obj10;
                obj4 = sslsocketfactory3;
                obj5 = FileTransfer.createFileTransferError(FileTransfer.CONNECTION_ERR, source, target, ((URLConnection) (obj15)));
                obj7 = obj15;
                obj3 = obj10;
                obj4 = sslsocketfactory3;
                Log.e("FileTransfer", ((JSONObject) (obj5)).toString(), ((Throwable) (obj1)));
                obj7 = obj15;
                obj3 = obj10;
                obj4 = sslsocketfactory3;
                context.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.IO_EXCEPTION, ((JSONObject) (obj5))));
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj15 == null || !trustEveryone || !useHttps) goto _L1; else goto _L34
_L34:
                obj2 = (HttpsURLConnection)obj15;
                ((HttpsURLConnection) (obj2)).setHostnameVerifier(((HostnameVerifier) (obj10)));
                ((HttpsURLConnection) (obj2)).setSSLSocketFactory(sslsocketfactory3);
                return;
                obj3;
                obj2;
                JVM INSTR monitorexit ;
                throw obj3;
                obj2;
                synchronized (FileTransfer.activeRequests)
                {
                    FileTransfer.activeRequests.remove(objectId);
                }
                if (obj7 != null && trustEveryone && useHttps)
                {
                    obj6 = (HttpsURLConnection)obj7;
                    ((HttpsURLConnection) (obj6)).setHostnameVerifier(((HostnameVerifier) (obj3)));
                    ((HttpsURLConnection) (obj6)).setSSLSocketFactory(((SSLSocketFactory) (obj4)));
                }
                throw obj2;
                exception;
                obj6;
                JVM INSTR monitorexit ;
                throw exception;
                JSONException jsonexception;
                jsonexception;
                  goto _L10
_L17:
                i = 1;
_L22:
                if (i == 0 && j != -1) goto _L36; else goto _L35
_L35:
                i = 1;
                  goto _L23
            }

            
            {
                this$0 = FileTransfer.this;
                context = requestcontext;
                useHttps = flag;
                trustEveryone = flag1;
                url = url1;
                target = s;
                headers = jsonobject;
                params = jsonobject1;
                fileKey = s1;
                fileName = s2;
                mimeType = s3;
                source = s4;
                chunkedMode = flag2;
                objectId = s5;
                super();
            }
        });
        return;
        source;
        callbackcontext;
        JVM INSTR monitorexit ;
        throw source;
    }

    public boolean execute(String s, JSONArray jsonarray, CallbackContext callbackcontext)
        throws JSONException
    {
        if (s.equals("upload") || s.equals("download"))
        {
            String s1 = jsonarray.getString(0);
            String s2 = jsonarray.getString(1);
            if (s.equals("upload"))
            {
                try
                {
                    upload(URLDecoder.decode(s1, "UTF-8"), s2, jsonarray, callbackcontext);
                }
                // Misplaced declaration of an exception variable
                catch (String s)
                {
                    callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.MALFORMED_URL_EXCEPTION, "UTF-8 error."));
                    return true;
                }
                return true;
            } else
            {
                download(s1, s2, jsonarray, callbackcontext);
                return true;
            }
        }
        if (s.equals("abort"))
        {
            abort(jsonarray.getString(0));
            callbackcontext.success();
            return true;
        } else
        {
            return false;
        }
    }

    static 
    {
        FILE_NOT_FOUND_ERR = 1;
        INVALID_URL_ERR = 2;
        CONNECTION_ERR = 3;
        ABORTED_ERR = 4;
    }








}

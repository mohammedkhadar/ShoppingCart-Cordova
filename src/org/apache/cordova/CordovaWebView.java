// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.webkit.WebBackForwardList;
import android.webkit.WebHistoryItem;
import android.webkit.WebSettings;
import android.webkit.WebView;
import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;
import org.apache.cordova.api.CordovaInterface;
import org.apache.cordova.api.LOG;
import org.apache.cordova.api.PluginManager;
import org.apache.cordova.api.PluginResult;

// Referenced classes of package org.apache.cordova:
//            CordovaChromeClient, CordovaWebViewClient, IceCreamCordovaWebViewClient, NativeToJsMessageQueue, 
//            ExposedJsApi, Config

public class CordovaWebView extends WebView
{
    class ActivityResult
    {

        Intent incoming;
        int request;
        int result;
        final CordovaWebView this$0;

        public ActivityResult(int i, int j, Intent intent)
        {
            this$0 = CordovaWebView.this;
            super();
            request = i;
            result = j;
            incoming = intent;
        }
    }

    private static class Level16Apis
    {

        static void enableUniversalAccess(WebSettings websettings)
        {
            websettings.setAllowUniversalAccessFromFileURLs(true);
        }

        private Level16Apis()
        {
        }
    }


    static final android.widget.FrameLayout.LayoutParams COVER_SCREEN_GRAVITY_CENTER = new android.widget.FrameLayout.LayoutParams(-1, -1, 17);
    public static final String TAG = "CordovaWebView";
    String baseUrl;
    private boolean bound;
    private CordovaChromeClient chromeClient;
    private CordovaInterface cordova;
    ExposedJsApi exposedJsApi;
    private boolean handleButton;
    NativeToJsMessageQueue jsMessageQueue;
    private ArrayList keyDownCodes;
    private ArrayList keyUpCodes;
    private long lastMenuEventTime;
    int loadUrlTimeout;
    private View mCustomView;
    private android.webkit.WebChromeClient.CustomViewCallback mCustomViewCallback;
    private ActivityResult mResult;
    private boolean paused;
    public PluginManager pluginManager;
    private BroadcastReceiver receiver;
    private String url;
    private Stack urls;
    boolean useBrowserHistory;
    CordovaWebViewClient viewClient;

    public CordovaWebView(Context context)
    {
        super(context);
        keyDownCodes = new ArrayList();
        keyUpCodes = new ArrayList();
        urls = new Stack();
        useBrowserHistory = true;
        loadUrlTimeout = 0;
        handleButton = false;
        lastMenuEventTime = 0L;
        mResult = null;
        if (org/apache/cordova/api/CordovaInterface.isInstance(context))
        {
            cordova = (CordovaInterface)context;
        } else
        {
            Log.d("CordovaWebView", "Your activity must implement CordovaInterface to work");
        }
        loadConfiguration();
        setup();
    }

    public CordovaWebView(Context context, AttributeSet attributeset)
    {
        super(context, attributeset);
        keyDownCodes = new ArrayList();
        keyUpCodes = new ArrayList();
        urls = new Stack();
        useBrowserHistory = true;
        loadUrlTimeout = 0;
        handleButton = false;
        lastMenuEventTime = 0L;
        mResult = null;
        if (org/apache/cordova/api/CordovaInterface.isInstance(context))
        {
            cordova = (CordovaInterface)context;
        } else
        {
            Log.d("CordovaWebView", "Your activity must implement CordovaInterface to work");
        }
        setWebChromeClient(new CordovaChromeClient(cordova, this));
        initWebViewClient(cordova);
        loadConfiguration();
        setup();
    }

    public CordovaWebView(Context context, AttributeSet attributeset, int i)
    {
        super(context, attributeset, i);
        keyDownCodes = new ArrayList();
        keyUpCodes = new ArrayList();
        urls = new Stack();
        useBrowserHistory = true;
        loadUrlTimeout = 0;
        handleButton = false;
        lastMenuEventTime = 0L;
        mResult = null;
        if (org/apache/cordova/api/CordovaInterface.isInstance(context))
        {
            cordova = (CordovaInterface)context;
        } else
        {
            Log.d("CordovaWebView", "Your activity must implement CordovaInterface to work");
        }
        setWebChromeClient(new CordovaChromeClient(cordova, this));
        loadConfiguration();
        setup();
    }

    public CordovaWebView(Context context, AttributeSet attributeset, int i, boolean flag)
    {
        super(context, attributeset, i, flag);
        keyDownCodes = new ArrayList();
        keyUpCodes = new ArrayList();
        urls = new Stack();
        useBrowserHistory = true;
        loadUrlTimeout = 0;
        handleButton = false;
        lastMenuEventTime = 0L;
        mResult = null;
        if (org/apache/cordova/api/CordovaInterface.isInstance(context))
        {
            cordova = (CordovaInterface)context;
        } else
        {
            Log.d("CordovaWebView", "Your activity must implement CordovaInterface to work");
        }
        setWebChromeClient(new CordovaChromeClient(cordova));
        initWebViewClient(cordova);
        loadConfiguration();
        setup();
    }

    private void exposeJsInterface()
    {
        int i = android.os.Build.VERSION.SDK_INT;
        boolean flag;
        if (i >= 11 && i <= 13)
        {
            flag = true;
        } else
        {
            flag = false;
        }
        if (flag || i < 9)
        {
            Log.i("CordovaWebView", "Disabled addJavascriptInterface() bridge since Android version is old.");
            return;
        }
        if (i < 11 && Build.MANUFACTURER.equals("unknown"))
        {
            Log.i("CordovaWebView", "Disabled addJavascriptInterface() bridge callback due to a bug on the 2.3 emulator");
            return;
        } else
        {
            addJavascriptInterface(exposedJsApi, "_cordovaNative");
            return;
        }
    }

    private void initWebViewClient(CordovaInterface cordovainterface)
    {
        if (android.os.Build.VERSION.SDK_INT < 11)
        {
            setWebViewClient(new CordovaWebViewClient(cordova, this));
            return;
        } else
        {
            setWebViewClient(new IceCreamCordovaWebViewClient(cordova, this));
            return;
        }
    }

    private void loadConfiguration()
    {
        if ("false".equals(getProperty("useBrowserHistory", "true")))
        {
            useBrowserHistory = false;
            Log.w("CordovaWebView", "useBrowserHistory=false is deprecated as of Cordova 2.2.0 and will be removed six months after the 2.2.0 release.  Please use the browser history and use history.back().");
        }
        if ("true".equals(getProperty("fullscreen", "false")))
        {
            cordova.getActivity().getWindow().clearFlags(2048);
            cordova.getActivity().getWindow().setFlags(1024, 1024);
        }
    }

    private void setup()
    {
        setInitialScale(0);
        setVerticalScrollBarEnabled(false);
        requestFocusFromTouch();
        Object obj = getSettings();
        ((WebSettings) (obj)).setJavaScriptEnabled(true);
        ((WebSettings) (obj)).setJavaScriptCanOpenWindowsAutomatically(true);
        ((WebSettings) (obj)).setLayoutAlgorithm(android.webkit.WebSettings.LayoutAlgorithm.NORMAL);
        String s;
        try
        {
            Method method = android/webkit/WebSettings.getMethod("setNavDump", new Class[] {
                Boolean.TYPE
            });
            if (android.os.Build.VERSION.SDK_INT < 11)
            {
                method.invoke(obj, new Object[] {
                    Boolean.valueOf(true)
                });
            }
        }
        catch (NoSuchMethodException nosuchmethodexception)
        {
            Log.d("CordovaWebView", "We are on a modern version of Android, we will deprecate HTC 2.3 devices in 2.8");
        }
        catch (IllegalArgumentException illegalargumentexception)
        {
            Log.d("CordovaWebView", "Doing the NavDump failed with bad arguments");
        }
        catch (IllegalAccessException illegalaccessexception)
        {
            Log.d("CordovaWebView", "This should never happen: IllegalAccessException means this isn't Android anymore");
        }
        catch (InvocationTargetException invocationtargetexception)
        {
            Log.d("CordovaWebView", "This should never happen: InvocationTargetException means this isn't Android anymore.");
        }
        if (android.os.Build.VERSION.SDK_INT > 15)
        {
            Level16Apis.enableUniversalAccess(((WebSettings) (obj)));
        }
        ((WebSettings) (obj)).setDatabaseEnabled(true);
        s = cordova.getActivity().getApplicationContext().getDir("database", 0).getPath();
        ((WebSettings) (obj)).setDatabasePath(s);
        ((WebSettings) (obj)).setGeolocationDatabasePath(s);
        ((WebSettings) (obj)).setDomStorageEnabled(true);
        ((WebSettings) (obj)).setGeolocationEnabled(true);
        ((WebSettings) (obj)).setAppCacheMaxSize(0x500000L);
        ((WebSettings) (obj)).setAppCachePath(cordova.getActivity().getApplicationContext().getDir("database", 0).getPath());
        ((WebSettings) (obj)).setAppCacheEnabled(true);
        updateUserAgentString();
        obj = new IntentFilter();
        ((IntentFilter) (obj)).addAction("android.intent.action.CONFIGURATION_CHANGED");
        if (receiver == null)
        {
            receiver = new BroadcastReceiver() {

                final CordovaWebView this$0;

                public void onReceive(Context context, Intent intent)
                {
                    updateUserAgentString();
                }

            
            {
                this$0 = CordovaWebView.this;
                super();
            }
            };
            cordova.getActivity().registerReceiver(receiver, ((IntentFilter) (obj)));
        }
        pluginManager = new PluginManager(this, cordova);
        jsMessageQueue = new NativeToJsMessageQueue(this, cordova);
        exposedJsApi = new ExposedJsApi(pluginManager, jsMessageQueue);
        exposeJsInterface();
    }

    private void updateUserAgentString()
    {
        getSettings().getUserAgentString();
    }

    public boolean backHistory()
    {
        if (super.canGoBack() && useBrowserHistory)
        {
            printBackForwardList();
            super.goBack();
            return true;
        }
        if (urls.size() > 1 && !useBrowserHistory)
        {
            urls.pop();
            loadUrl((String)urls.pop());
            return true;
        } else
        {
            return false;
        }
    }

    public void bindButton(int i, boolean flag, boolean flag1)
    {
        if (flag)
        {
            keyDownCodes.add(Integer.valueOf(i));
            return;
        } else
        {
            keyUpCodes.add(Integer.valueOf(i));
            return;
        }
    }

    public void bindButton(String s, boolean flag)
    {
        if (s.compareTo("volumeup") == 0)
        {
            keyDownCodes.add(Integer.valueOf(24));
        } else
        if (s.compareTo("volumedown") == 0)
        {
            keyDownCodes.add(Integer.valueOf(25));
            return;
        }
    }

    public void bindButton(boolean flag)
    {
        bound = flag;
    }

    public boolean canGoBack()
    {
        while (super.canGoBack() && useBrowserHistory || urls.size() > 1) 
        {
            return true;
        }
        return false;
    }

    public String getProperty(String s, String s1)
    {
        Bundle bundle = cordova.getActivity().getIntent().getExtras();
        if (bundle != null)
        {
            if ((s = ((String) (bundle.get(s)))) != null)
            {
                return s.toString();
            }
        }
        return s1;
    }

    public CordovaChromeClient getWebChromeClient()
    {
        return chromeClient;
    }

    public boolean hadKeyEvent()
    {
        return handleButton;
    }

    public void handleDestroy()
    {
        loadUrlIntoView("javascript:try{cordova.require('cordova/channel').onDestroy.fire();}catch(e){console.log('exception firing destroy event from native');};");
        loadUrl("about:blank");
        if (pluginManager != null)
        {
            pluginManager.onDestroy();
        }
        if (receiver == null)
        {
            break MISSING_BLOCK_LABEL_51;
        }
        cordova.getActivity().unregisterReceiver(receiver);
        return;
        Exception exception;
        exception;
        Log.e("CordovaWebView", (new StringBuilder()).append("Error unregistering configuration receiver: ").append(exception.getMessage()).toString(), exception);
        return;
    }

    public void handlePause(boolean flag)
    {
        LOG.d("CordovaWebView", "Handle the pause");
        loadUrl("javascript:try{cordova.fireDocumentEvent('pause');}catch(e){console.log('exception firing pause event from native');};");
        if (pluginManager != null)
        {
            pluginManager.onPause(flag);
        }
        if (!flag)
        {
            pauseTimers();
        }
        paused = true;
    }

    public void handleResume(boolean flag, boolean flag1)
    {
        loadUrl("javascript:try{cordova.fireDocumentEvent('resume');}catch(e){console.log('exception firing resume event from native');};");
        if (pluginManager != null)
        {
            pluginManager.onResume(flag);
        }
        resumeTimers();
        paused = false;
    }

    public void hideCustomView()
    {
        Log.d("CordovaWebView", "Hidding Custom View");
        if (mCustomView == null)
        {
            return;
        } else
        {
            mCustomView.setVisibility(8);
            ((ViewGroup)getParent()).removeView(mCustomView);
            mCustomView = null;
            mCustomViewCallback.onCustomViewHidden();
            setVisibility(0);
            return;
        }
    }

    public boolean isBackButtonBound()
    {
        return bound;
    }

    public boolean isCustomViewShowing()
    {
        return mCustomView != null;
    }

    public boolean isPaused()
    {
        return paused;
    }

    public void loadUrl(String s)
    {
        if (s.equals("about:blank") || s.startsWith("javascript:"))
        {
            loadUrlNow(s);
            return;
        }
        String s1 = getProperty("url", null);
        if (s1 == null || urls.size() > 0)
        {
            loadUrlIntoView(s);
            return;
        } else
        {
            loadUrlIntoView(s1);
            return;
        }
    }

    public void loadUrl(String s, int i)
    {
        String s1 = getProperty("url", null);
        if (s1 == null || urls.size() > 0)
        {
            loadUrlIntoView(s, i);
            return;
        } else
        {
            loadUrlIntoView(s1);
            return;
        }
    }

    public void loadUrlIntoView(final String url)
    {
        LOG.d("CordovaWebView", (new StringBuilder()).append(">>> loadUrl(").append(url).append(")").toString());
        this.url = url;
        if (baseUrl == null)
        {
            int i = url.lastIndexOf('/');
            final Runnable timeoutCheck;
            if (i > 0)
            {
                baseUrl = url.substring(0, i + 1);
            } else
            {
                baseUrl = (new StringBuilder()).append(this.url).append("/").toString();
            }
            pluginManager.init();
            if (!useBrowserHistory)
            {
                urls.push(url);
            }
        }
        i = loadUrlTimeout;
        timeoutCheck = new Runnable() {

            final CordovaWebView this$0;
            final int val$currentLoadUrlTimeout;
            final Runnable val$loadError;
            final int val$loadUrlTimeoutValue;
            final CordovaWebView val$me;

            public void run()
            {
                this;
                JVM INSTR monitorenter ;
                wait(loadUrlTimeoutValue);
                this;
                JVM INSTR monitorexit ;
_L2:
                if (me.loadUrlTimeout == currentLoadUrlTimeout)
                {
                    me.cordova.getActivity().runOnUiThread(loadError);
                }
                return;
                Exception exception;
                exception;
                this;
                JVM INSTR monitorexit ;
                try
                {
                    throw exception;
                }
                catch (InterruptedException interruptedexception)
                {
                    interruptedexception.printStackTrace();
                }
                if (true) goto _L2; else goto _L1
_L1:
            }

            
            {
                this$0 = CordovaWebView.this;
                loadUrlTimeoutValue = i;
                me = cordovawebview1;
                currentLoadUrlTimeout = j;
                loadError = runnable;
                super();
            }
        };
        cordova.getActivity().runOnUiThread(new Runnable() {

            final CordovaWebView this$0;
            final CordovaWebView val$me;
            final Runnable val$timeoutCheck;
            final String val$url;

            public void run()
            {
                (new Thread(timeoutCheck)).start();
                me.loadUrlNow(url);
            }

            
            {
                this$0 = CordovaWebView.this;
                timeoutCheck = runnable;
                me = cordovawebview1;
                url = s;
                super();
            }
        });
    }

    public void loadUrlIntoView(String s, int i)
    {
        if (!s.startsWith("javascript:") && urls.size() <= 0 && !canGoBack())
        {
            LOG.d("CordovaWebView", "DroidGap.loadUrl(%s, %d)", new Object[] {
                s, Integer.valueOf(i)
            });
            postMessage("splashscreen", "show");
        }
        loadUrlIntoView(s);
    }

    void loadUrlNow(String s)
    {
        if (LOG.isLoggable(3) && !s.startsWith("javascript:"))
        {
            LOG.d("CordovaWebView", ">>> loadUrlNow()");
        }
        if (s.startsWith("file://") || s.indexOf(baseUrl) == 0 || s.startsWith("javascript:") || Config.isUrlWhiteListed(s))
        {
            super.loadUrl(s);
        }
    }

    public boolean onKeyDown(int i, KeyEvent keyevent)
    {
label0:
        {
            boolean flag;
label1:
            {
                boolean flag1 = false;
                flag = false;
                if (keyDownCodes.contains(Integer.valueOf(i)))
                {
                    if (i == 25)
                    {
                        LOG.d("CordovaWebView", "Down Key Hit");
                        loadUrl("javascript:cordova.fireDocumentEvent('volumedownbutton');");
                        return true;
                    }
                    if (i == 24)
                    {
                        LOG.d("CordovaWebView", "Up Key Hit");
                        loadUrl("javascript:cordova.fireDocumentEvent('volumeupbutton');");
                        return true;
                    } else
                    {
                        return super.onKeyDown(i, keyevent);
                    }
                }
                if (i != 4)
                {
                    break label0;
                }
                if (useBrowserHistory)
                {
                    if (!startOfHistory() || bound)
                    {
                        flag = true;
                    }
                    return flag;
                }
                if (urls.size() <= 1)
                {
                    flag = flag1;
                    if (!bound)
                    {
                        break label1;
                    }
                }
                flag = true;
            }
            return flag;
        }
        return super.onKeyDown(i, keyevent);
    }

    public boolean onKeyUp(int i, KeyEvent keyevent)
    {
        boolean flag = true;
        if (i != 4) goto _L2; else goto _L1
_L1:
        if (mCustomView == null) goto _L4; else goto _L3
_L3:
        hideCustomView();
_L8:
        flag = super.onKeyUp(i, keyevent);
_L6:
        return flag;
_L4:
        if (bound)
        {
            loadUrl("javascript:cordova.fireDocumentEvent('backbutton');");
            return true;
        }
        if (backHistory()) goto _L6; else goto _L5
_L5:
        cordova.getActivity().finish();
        if (true)
        {
            continue; /* Loop/switch isn't completed */
        }
_L2:
        if (i == 82)
        {
            if (lastMenuEventTime < keyevent.getEventTime())
            {
                loadUrl("javascript:cordova.fireDocumentEvent('menubutton');");
            }
            lastMenuEventTime = keyevent.getEventTime();
            return super.onKeyUp(i, keyevent);
        }
        if (i == 84)
        {
            loadUrl("javascript:cordova.fireDocumentEvent('searchbutton');");
            return true;
        }
        if (keyUpCodes.contains(Integer.valueOf(i)))
        {
            return super.onKeyUp(i, keyevent);
        }
        if (true) goto _L8; else goto _L7
_L7:
    }

    public void onNewIntent(Intent intent)
    {
        if (pluginManager != null)
        {
            pluginManager.onNewIntent(intent);
        }
    }

    public String peekAtUrlStack()
    {
        if (urls.size() > 0)
        {
            return (String)urls.peek();
        } else
        {
            return "";
        }
    }

    public void postMessage(String s, Object obj)
    {
        if (pluginManager != null)
        {
            pluginManager.postMessage(s, obj);
        }
    }

    public void printBackForwardList()
    {
        WebBackForwardList webbackforwardlist = copyBackForwardList();
        int j = webbackforwardlist.getSize();
        for (int i = 0; i < j; i++)
        {
            String s = webbackforwardlist.getItemAtIndex(i).getUrl();
            LOG.d("CordovaWebView", (new StringBuilder()).append("The URL at index: ").append(Integer.toString(i)).append("is ").append(s).toString());
        }

    }

    public void pushUrl(String s)
    {
        urls.push(s);
    }

    public WebBackForwardList restoreState(Bundle bundle)
    {
        bundle = super.restoreState(bundle);
        Log.d("CordovaWebView", "WebView restoration crew now restoring!");
        pluginManager.init();
        return bundle;
    }

    public void sendJavascript(String s)
    {
        jsMessageQueue.addJavaScript(s);
    }

    public void sendPluginResult(PluginResult pluginresult, String s)
    {
        jsMessageQueue.addPluginResult(pluginresult, s);
    }

    public void setWebChromeClient(CordovaChromeClient cordovachromeclient)
    {
        chromeClient = cordovachromeclient;
        super.setWebChromeClient(cordovachromeclient);
    }

    public void setWebViewClient(CordovaWebViewClient cordovawebviewclient)
    {
        viewClient = cordovawebviewclient;
        super.setWebViewClient(cordovawebviewclient);
    }

    public void showCustomView(View view, android.webkit.WebChromeClient.CustomViewCallback customviewcallback)
    {
        Log.d("CordovaWebView", "showing Custom View");
        if (mCustomView != null)
        {
            customviewcallback.onCustomViewHidden();
            return;
        } else
        {
            mCustomView = view;
            mCustomViewCallback = customviewcallback;
            customviewcallback = (ViewGroup)getParent();
            customviewcallback.addView(view, COVER_SCREEN_GRAVITY_CENTER);
            setVisibility(8);
            customviewcallback.setVisibility(0);
            customviewcallback.bringToFront();
            return;
        }
    }

    public void showWebPage(String s, boolean flag, boolean flag1, HashMap hashmap)
    {
        LOG.d("CordovaWebView", "showWebPage(%s, %b, %b, HashMap", new Object[] {
            s, Boolean.valueOf(flag), Boolean.valueOf(flag1)
        });
        if (flag1)
        {
            clearHistory();
        }
        if (!flag)
        {
            if (s.startsWith("file://") || s.indexOf(baseUrl) == 0 || Config.isUrlWhiteListed(s))
            {
                if (flag1)
                {
                    urls.clear();
                }
                loadUrl(s);
                return;
            }
            LOG.w("CordovaWebView", (new StringBuilder()).append("showWebPage: Cannot load URL into webview since it is not in white list.  Loading into browser instead. (URL=").append(s).append(")").toString());
            try
            {
                hashmap = new Intent("android.intent.action.VIEW");
                hashmap.setData(Uri.parse(s));
                cordova.getActivity().startActivity(hashmap);
                return;
            }
            // Misplaced declaration of an exception variable
            catch (HashMap hashmap)
            {
                LOG.e("CordovaWebView", (new StringBuilder()).append("Error loading url ").append(s).toString(), hashmap);
            }
            return;
        }
        try
        {
            hashmap = new Intent("android.intent.action.VIEW");
            hashmap.setData(Uri.parse(s));
            cordova.getActivity().startActivity(hashmap);
            return;
        }
        // Misplaced declaration of an exception variable
        catch (HashMap hashmap)
        {
            LOG.e("CordovaWebView", (new StringBuilder()).append("Error loading url ").append(s).toString(), hashmap);
        }
    }

    public boolean startOfHistory()
    {
        boolean flag = false;
        Object obj = copyBackForwardList().getItemAtIndex(0);
        if (obj != null)
        {
            obj = ((WebHistoryItem) (obj)).getUrl();
            String s = getUrl();
            LOG.d("CordovaWebView", (new StringBuilder()).append("The current URL is: ").append(s).toString());
            LOG.d("CordovaWebView", (new StringBuilder()).append("The URL at item 0 is:").append(((String) (obj))).toString());
            flag = s.equals(obj);
        }
        return flag;
    }

    public void storeResult(int i, int j, Intent intent)
    {
        mResult = new ActivityResult(i, j, intent);
    }




    // Unreferenced inner class org/apache/cordova/CordovaWebView$2

/* anonymous class */
    class _cls2
        implements Runnable
    {

        final CordovaWebView this$0;
        final CordovaWebView val$me;
        final String val$url;

        public void run()
        {
            me.stopLoading();
            LOG.e("CordovaWebView", "CordovaWebView: TIMEOUT ERROR!");
            if (viewClient != null)
            {
                viewClient.onReceivedError(me, -6, "The connection to the server was unsuccessful.", url);
            }
        }

            
            {
                this$0 = CordovaWebView.this;
                me = cordovawebview1;
                url = s;
                super();
            }
    }

}

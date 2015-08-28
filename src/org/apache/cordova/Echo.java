// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import java.util.concurrent.ExecutorService;
import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaInterface;
import org.apache.cordova.api.CordovaPlugin;
import org.json.JSONException;

// Referenced classes of package org.apache.cordova:
//            CordovaArgs

public class Echo extends CordovaPlugin
{

    public Echo()
    {
    }

    public boolean execute(final String result, CordovaArgs cordovaargs, final CallbackContext callbackContext)
        throws JSONException
    {
        Object obj1 = null;
        Object obj = null;
        if ("echo".equals(result))
        {
            if (cordovaargs.isNull(0))
            {
                result = obj;
            } else
            {
                result = cordovaargs.getString(0);
            }
            callbackContext.success(result);
            return true;
        }
        if ("echoAsync".equals(result))
        {
            if (cordovaargs.isNull(0))
            {
                result = obj1;
            } else
            {
                result = cordovaargs.getString(0);
            }
            cordova.getThreadPool().execute(new Runnable() {

                final Echo this$0;
                final CallbackContext val$callbackContext;
                final String val$result;

                public void run()
                {
                    callbackContext.success(result);
                }

            
            {
                this$0 = Echo.this;
                callbackContext = callbackcontext;
                result = s;
                super();
            }
            });
            return true;
        }
        if ("echoArrayBuffer".equals(result))
        {
            callbackContext.success(cordovaargs.getArrayBuffer(0));
            return true;
        } else
        {
            return false;
        }
    }
}

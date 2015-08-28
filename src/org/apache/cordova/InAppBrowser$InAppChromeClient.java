// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.webkit.WebChromeClient;
import org.apache.cordova.api.LOG;

// Referenced classes of package org.apache.cordova:
//            InAppBrowser

public class this._cls0 extends WebChromeClient
{

    final InAppBrowser this$0;

    public void onExceededDatabaseQuota(String s, String s1, long l, long l1, long l2, android.webkit.ent ent)
    {
        LOG.d("InAppBrowser", "onExceededDatabaseQuota estimatedSize: %d  currentQuota: %d  totalUsedQuota: %d", new Object[] {
            Long.valueOf(l1), Long.valueOf(l), Long.valueOf(l2)
        });
        if (l1 < InAppBrowser.access$900(InAppBrowser.this))
        {
            LOG.d("InAppBrowser", "calling quotaUpdater.updateQuota newQuota: %d", new Object[] {
                Long.valueOf(l1)
            });
            ent.uota(l1);
            return;
        } else
        {
            ent.uota(l);
            return;
        }
    }

    public ()
    {
        this$0 = InAppBrowser.this;
        super();
    }
}

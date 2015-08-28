// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.util.Log;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.cordova.api.LOG;
import org.xmlpull.v1.XmlPullParserException;

public class Config
{

    public static final String TAG = "Config";
    private static Config self = null;
    private String startUrl;
    private ArrayList whiteList;
    private HashMap whiteListCache;

    private Config()
    {
        whiteList = new ArrayList();
        whiteListCache = new HashMap();
    }

    private Config(Activity activity)
    {
        whiteList = new ArrayList();
        whiteListCache = new HashMap();
        if (activity != null) goto _L2; else goto _L1
_L1:
        LOG.i("CordovaLog", "There is no activity. Is this on the lock screen?");
_L6:
        return;
_L2:
        XmlResourceParser xmlresourceparser;
        int i;
        int j = activity.getResources().getIdentifier("config", "xml", activity.getPackageName());
        i = j;
        if (j == 0)
        {
            i = activity.getResources().getIdentifier("cordova", "xml", activity.getPackageName());
            LOG.i("CordovaLog", "config.xml missing, reverting to cordova.xml");
        }
        if (i == 0)
        {
            LOG.i("CordovaLog", "cordova.xml missing. Ignoring...");
            return;
        }
        xmlresourceparser = activity.getResources().getXml(i);
        i = -1;
_L4:
        if (i == 1)
        {
            continue; /* Loop/switch isn't completed */
        }
        if (i == 2)
        {
            String s = xmlresourceparser.getName();
            if (s.equals("access"))
            {
                s = xmlresourceparser.getAttributeValue(null, "origin");
                String s2 = xmlresourceparser.getAttributeValue(null, "subdomains");
                if (s != null)
                {
                    int k;
                    boolean flag;
                    if (s2 != null && s2.compareToIgnoreCase("true") == 0)
                    {
                        flag = true;
                    } else
                    {
                        flag = false;
                    }
                    _addWhiteListEntry(s, flag);
                }
            } else
            if (s.equals("log"))
            {
                s = xmlresourceparser.getAttributeValue(null, "level");
                LOG.i("CordovaLog", "Found log level %s", new Object[] {
                    s
                });
                if (s != null)
                {
                    LOG.setLogLevel(s);
                }
            } else
            if (s.equals("preference"))
            {
                String s5 = xmlresourceparser.getAttributeValue(null, "name");
                if (s5.equals("splashscreen"))
                {
                    String s3 = xmlresourceparser.getAttributeValue(null, "value");
                    s = s3;
                    if (s3 != null)
                    {
                        s = "splash";
                    }
                    int l = activity.getResources().getIdentifier(s, "drawable", activity.getPackageName());
                    activity.getIntent().putExtra(s5, l);
                    LOG.i("CordovaLog", "Found preference for %s=%s", new Object[] {
                        s5, s
                    });
                    Log.d("CordovaLog", (new StringBuilder()).append("Found preference for ").append(s5).append("=").append(s).toString());
                } else
                if (s5.equals("backgroundColor"))
                {
                    int i1 = xmlresourceparser.getAttributeIntValue(null, "value", 0xff000000);
                    activity.getIntent().putExtra(s5, i1);
                    LOG.i("CordovaLog", "Found preference for %s=%d", new Object[] {
                        s5, Integer.valueOf(i1)
                    });
                    Log.d("CordovaLog", (new StringBuilder()).append("Found preference for ").append(s5).append("=").append(Integer.toString(i1)).toString());
                } else
                if (s5.equals("loadUrlTimeoutValue"))
                {
                    int j1 = xmlresourceparser.getAttributeIntValue(null, "value", 20000);
                    activity.getIntent().putExtra(s5, j1);
                    LOG.i("CordovaLog", "Found preference for %s=%d", new Object[] {
                        s5, Integer.valueOf(j1)
                    });
                    Log.d("CordovaLog", (new StringBuilder()).append("Found preference for ").append(s5).append("=").append(Integer.toString(j1)).toString());
                } else
                if (s5.equals("keepRunning"))
                {
                    boolean flag1 = xmlresourceparser.getAttributeValue(null, "value").equals("true");
                    activity.getIntent().putExtra(s5, flag1);
                } else
                {
                    s = xmlresourceparser.getAttributeValue(null, "value");
                    activity.getIntent().putExtra(s5, s);
                    LOG.i("CordovaLog", "Found preference for %s=%s", new Object[] {
                        s5, s
                    });
                    Log.d("CordovaLog", (new StringBuilder()).append("Found preference for ").append(s5).append("=").append(s).toString());
                }
            } else
            if (s.equals("content"))
            {
                String s4 = xmlresourceparser.getAttributeValue(null, "src");
                LOG.i("CordovaLog", "Found start page location: %s", new Object[] {
                    s4
                });
                if (s4 != null)
                {
                    if (Pattern.compile("^[a-z]+://").matcher(s4).find())
                    {
                        startUrl = s4;
                    } else
                    {
                        String s1 = s4;
                        if (s4.charAt(0) == '/')
                        {
                            s1 = s4.substring(1);
                        }
                        startUrl = (new StringBuilder()).append("file:///android_asset/www/").append(s1).toString();
                    }
                }
            }
        }
        k = xmlresourceparser.next();
        i = k;
        break; /* Loop/switch isn't completed */
        Object obj;
        obj;
        ((XmlPullParserException) (obj)).printStackTrace();
        break; /* Loop/switch isn't completed */
        obj;
        ((IOException) (obj)).printStackTrace();
        if (true) goto _L4; else goto _L3
_L3:
        if (true) goto _L6; else goto _L5
_L5:
    }

    private void _addWhiteListEntry(String s, boolean flag)
    {
        try
        {
            if (s.compareTo("*") == 0)
            {
                LOG.d("Config", "Unlimited access to network resources");
                whiteList.add(Pattern.compile(".*"));
                return;
            }
        }
        catch (Exception exception)
        {
            LOG.d("Config", "Failed to add origin %s", new Object[] {
                s
            });
            return;
        }
        if (!flag)
        {
            break MISSING_BLOCK_LABEL_134;
        }
        if (!s.startsWith("http"))
        {
            break MISSING_BLOCK_LABEL_100;
        }
        whiteList.add(Pattern.compile(s.replaceFirst("https?://", "^https?://(.*\\.)?")));
_L1:
        LOG.d("Config", "Origin to allow with subdomains: %s", new Object[] {
            s
        });
        return;
        whiteList.add(Pattern.compile((new StringBuilder()).append("^https?://(.*\\.)?").append(s).toString()));
          goto _L1
        if (!s.startsWith("http"))
        {
            break MISSING_BLOCK_LABEL_182;
        }
        whiteList.add(Pattern.compile(s.replaceFirst("https?://", "^https?://")));
_L3:
        LOG.d("Config", "Origin to allow: %s", new Object[] {
            s
        });
        return;
        whiteList.add(Pattern.compile((new StringBuilder()).append("^https?://").append(s).toString()));
        if (true) goto _L3; else goto _L2
_L2:
    }

    public static void addWhiteListEntry(String s, boolean flag)
    {
        if (self == null)
        {
            return;
        } else
        {
            self._addWhiteListEntry(s, flag);
            return;
        }
    }

    public static String getStartUrl()
    {
        if (self == null || self.startUrl == null)
        {
            return "file:///android_asset/www/index.html";
        } else
        {
            return self.startUrl;
        }
    }

    public static void init()
    {
        if (self == null)
        {
            self = new Config();
        }
    }

    public static void init(Activity activity)
    {
        if (self == null)
        {
            self = new Config(activity);
        }
    }

    public static boolean isUrlWhiteListed(String s)
    {
        if (self != null)
        {
            if (self.whiteListCache.get(s) != null)
            {
                return true;
            }
            Iterator iterator = self.whiteList.iterator();
            while (iterator.hasNext()) 
            {
                if (((Pattern)iterator.next()).matcher(s).find())
                {
                    self.whiteListCache.put(s, Boolean.valueOf(true));
                    return true;
                }
            }
        }
        return false;
    }

}

// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: braces fieldsfirst space lnc 

package org.apache.cordova;

import android.app.Activity;
import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.os.Environment;
import android.webkit.MimeTypeMap;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.channels.FileChannel;
import org.apache.commons.codec.binary.Base64;
import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaInterface;
import org.apache.cordova.api.CordovaPlugin;
import org.apache.cordova.api.PluginResult;
import org.apache.cordova.file.EncodingException;
import org.apache.cordova.file.FileExistsException;
import org.apache.cordova.file.InvalidModificationException;
import org.apache.cordova.file.NoModificationAllowedException;
import org.apache.cordova.file.TypeMismatchException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

// Referenced classes of package org.apache.cordova:
//            DirectoryManager

public class FileUtils extends CordovaPlugin
{

    public static int ABORT_ERR = 0;
    public static int APPLICATION = 0;
    public static int ENCODING_ERR = 0;
    public static int INVALID_MODIFICATION_ERR = 0;
    public static int INVALID_STATE_ERR = 0;
    private static final String LOG_TAG = "FileUtils";
    public static int NOT_FOUND_ERR = 0;
    public static int NOT_READABLE_ERR = 0;
    public static int NO_MODIFICATION_ALLOWED_ERR = 0;
    public static int PATH_EXISTS_ERR = 0;
    public static int PERSISTENT = 0;
    public static int QUOTA_EXCEEDED_ERR = 0;
    public static int RESOURCE = 0;
    public static int SECURITY_ERR = 0;
    public static int SYNTAX_ERR = 0;
    public static int TEMPORARY = 0;
    public static int TYPE_MISMATCH_ERR = 0;
    private static final String _DATA = "_data";
    FileReader f_in;
    FileWriter f_out;

    public FileUtils()
    {
    }

    private boolean atRootDirectory(String s)
    {
        s = getRealPathFromURI(Uri.parse(s), cordova);
        return s.equals((new StringBuilder()).append(Environment.getExternalStorageDirectory().getAbsolutePath()).append("/Android/data/").append(cordova.getActivity().getPackageName()).append("/cache").toString()) || s.equals(Environment.getExternalStorageDirectory().getAbsolutePath()) || s.equals((new StringBuilder()).append("/data/data/").append(cordova.getActivity().getPackageName()).toString());
    }

    private void copyAction(File file, File file1)
        throws FileNotFoundException, IOException
    {
        FileChannel filechannel;
        FileChannel filechannel1;
        file = new FileInputStream(file);
        file1 = new FileOutputStream(file1);
        filechannel = file.getChannel();
        filechannel1 = file1.getChannel();
        filechannel.transferTo(0L, filechannel.size(), filechannel1);
        file.close();
        file1.close();
        filechannel.close();
        filechannel1.close();
        return;
        Exception exception;
        exception;
        file.close();
        file1.close();
        filechannel.close();
        filechannel1.close();
        throw exception;
    }

    private JSONObject copyDirectory(File file, File file1)
        throws JSONException, IOException, NoModificationAllowedException, InvalidModificationException
    {
        if (file1.exists() && file1.isFile())
        {
            throw new InvalidModificationException("Can't rename a file to a directory");
        }
        if (isCopyOnItself(file.getAbsolutePath(), file1.getAbsolutePath()))
        {
            throw new InvalidModificationException("Can't copy itself into itself");
        }
        if (!file1.exists() && !file1.mkdir())
        {
            throw new NoModificationAllowedException("Couldn't create the destination directory");
        }
        file = file.listFiles();
        int j = file.length;
        int i = 0;
        while (i < j) 
        {
            File file2 = file[i];
            if (file2.isDirectory())
            {
                copyDirectory(file2, file1);
            } else
            {
                copyFile(file2, new File((new StringBuilder()).append(file1.getAbsoluteFile()).append(File.separator).append(file2.getName()).toString()));
            }
            i++;
        }
        return getEntry(file1);
    }

    private JSONObject copyFile(File file, File file1)
        throws IOException, InvalidModificationException, JSONException
    {
        if (file1.exists() && file1.isDirectory())
        {
            throw new InvalidModificationException("Can't rename a file to a directory");
        } else
        {
            copyAction(file, file1);
            return getEntry(file1);
        }
    }

    private File createDestination(String s, File file, File file1)
    {
        String s1;
label0:
        {
            if (!"null".equals(s))
            {
                s1 = s;
                if (!"".equals(s))
                {
                    break label0;
                }
            }
            s1 = null;
        }
        if (s1 != null)
        {
            return new File((new StringBuilder()).append(file1.getAbsolutePath()).append(File.separator).append(s1).toString());
        } else
        {
            return new File((new StringBuilder()).append(file1.getAbsolutePath()).append(File.separator).append(file.getName()).toString());
        }
    }

    private File createFileObject(String s)
    {
        return new File(getRealPathFromURI(Uri.parse(s), cordova));
    }

    private File createFileObject(String s, String s1)
    {
        if (s1.startsWith("/"))
        {
            return new File(s1);
        } else
        {
            s = getRealPathFromURI(Uri.parse(s), cordova);
            return new File((new StringBuilder()).append(s).append(File.separator).append(s1).toString());
        }
    }

    private JSONObject getEntry(String s)
        throws JSONException
    {
        return getEntry(new File(s));
    }

    private JSONObject getFile(String s, String s1, JSONObject jsonobject, boolean flag)
        throws FileExistsException, IOException, TypeMismatchException, EncodingException, JSONException
    {
        boolean flag1 = false;
        boolean flag3 = false;
        boolean flag2 = flag3;
        if (jsonobject != null)
        {
            boolean flag4 = jsonobject.optBoolean("create");
            flag1 = flag4;
            flag2 = flag3;
            if (flag4)
            {
                flag2 = jsonobject.optBoolean("exclusive");
                flag1 = flag4;
            }
        }
        if (s1.contains(":"))
        {
            throw new EncodingException("This file has a : in it's name");
        }
        s = createFileObject(s, s1);
        if (flag1)
        {
            if (flag2 && s.exists())
            {
                throw new FileExistsException("create/exclusive fails");
            }
            if (flag)
            {
                s.mkdir();
            } else
            {
                s.createNewFile();
            }
            if (!s.exists())
            {
                throw new FileExistsException("create fails");
            }
        } else
        {
            if (!s.exists())
            {
                throw new FileNotFoundException("path does not exist");
            }
            if (flag)
            {
                if (s.isFile())
                {
                    throw new TypeMismatchException("path doesn't exist or is file");
                }
            } else
            if (s.isDirectory())
            {
                throw new TypeMismatchException("path doesn't exist or is directory");
            }
        }
        return getEntry(s);
    }

    private JSONObject getFileMetadata(String s)
        throws FileNotFoundException, JSONException
    {
        File file = createFileObject(s);
        if (!file.exists())
        {
            throw new FileNotFoundException((new StringBuilder()).append("File: ").append(s).append(" does not exist.").toString());
        } else
        {
            JSONObject jsonobject = new JSONObject();
            jsonobject.put("size", file.length());
            jsonobject.put("type", getMimeType(s));
            jsonobject.put("name", file.getName());
            jsonobject.put("fullPath", s);
            jsonobject.put("lastModifiedDate", file.lastModified());
            return jsonobject;
        }
    }

    private long getMetadata(String s)
        throws FileNotFoundException
    {
        s = createFileObject(s);
        if (!s.exists())
        {
            throw new FileNotFoundException("Failed to find file in getMetadata");
        } else
        {
            return s.lastModified();
        }
    }

    public static String getMimeType(String s)
    {
        if (s != null)
        {
            String s1 = s.replace(" ", "%20").toLowerCase();
            s = MimeTypeMap.getSingleton();
            s1 = MimeTypeMap.getFileExtensionFromUrl(s1);
            if (s1.toLowerCase().equals("3ga"))
            {
                return "audio/3gpp";
            } else
            {
                return s.getMimeTypeFromExtension(s1);
            }
        } else
        {
            return "";
        }
    }

    private JSONObject getParent(String s)
        throws JSONException
    {
        s = getRealPathFromURI(Uri.parse(s), cordova);
        if (atRootDirectory(s))
        {
            return getEntry(s);
        } else
        {
            return getEntry((new File(s)).getParent());
        }
    }

    private InputStream getPathFromUri(String s)
        throws FileNotFoundException
    {
        if (s.startsWith("content"))
        {
            s = Uri.parse(s);
            return cordova.getActivity().getContentResolver().openInputStream(s);
        } else
        {
            return new FileInputStream(getRealPathFromURI(Uri.parse(s), cordova));
        }
    }

    protected static String getRealPathFromURI(Uri uri, CordovaInterface cordovainterface)
    {
        String s = uri.getScheme();
        if (s == null)
        {
            return uri.toString();
        }
        if (s.compareTo("content") == 0)
        {
            uri = cordovainterface.getActivity().managedQuery(uri, new String[] {
                "_data"
            }, null, null, null);
            int i = uri.getColumnIndexOrThrow("_data");
            uri.moveToFirst();
            return uri.getString(i);
        }
        if (s.compareTo("file") == 0)
        {
            return uri.getPath();
        } else
        {
            return uri.toString();
        }
    }

    private boolean isCopyOnItself(String s, String s1)
    {
        return s1.startsWith(s) && s1.indexOf(File.separator, s.length() - 1) != -1;
    }

    private JSONObject moveDirectory(File file, File file1)
        throws IOException, JSONException, InvalidModificationException, NoModificationAllowedException, FileExistsException
    {
label0:
        {
            if (file1.exists() && file1.isFile())
            {
                throw new InvalidModificationException("Can't rename a file to a directory");
            }
            if (isCopyOnItself(file.getAbsolutePath(), file1.getAbsolutePath()))
            {
                throw new InvalidModificationException("Can't move itself into itself");
            }
            if (file1.exists() && file1.list().length > 0)
            {
                throw new InvalidModificationException("directory is not empty");
            }
            if (!file.renameTo(file1))
            {
                copyDirectory(file, file1);
                if (!file1.exists())
                {
                    break label0;
                }
                removeDirRecursively(file);
            }
            return getEntry(file1);
        }
        throw new IOException("moved failed");
    }

    private JSONObject moveFile(File file, File file1)
        throws IOException, JSONException, InvalidModificationException
    {
label0:
        {
            if (file1.exists() && file1.isDirectory())
            {
                throw new InvalidModificationException("Can't rename a file to a directory");
            }
            if (!file.renameTo(file1))
            {
                copyAction(file, file1);
                if (!file1.exists())
                {
                    break label0;
                }
                file.delete();
            }
            return getEntry(file1);
        }
        throw new IOException("moved failed");
    }

    private void notifyDelete(String s)
    {
        s = getRealPathFromURI(Uri.parse(s), cordova);
        try
        {
            cordova.getActivity().getContentResolver().delete(android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "_data = ?", new String[] {
                s
            });
            return;
        }
        // Misplaced declaration of an exception variable
        catch (String s)
        {
            return;
        }
    }

    private JSONArray readEntries(String s)
        throws FileNotFoundException, JSONException
    {
        File file = createFileObject(s);
        if (!file.exists())
        {
            throw new FileNotFoundException();
        }
        s = new JSONArray();
        if (file.isDirectory())
        {
            File afile[] = file.listFiles();
            for (int i = 0; i < afile.length; i++)
            {
                if (afile[i].canRead())
                {
                    s.put(getEntry(afile[i]));
                }
            }

        }
        return s;
    }

    private boolean remove(String s)
        throws NoModificationAllowedException, InvalidModificationException
    {
        File file = createFileObject(s);
        if (atRootDirectory(s))
        {
            throw new NoModificationAllowedException("You can't delete the root directory");
        }
        if (file.isDirectory() && file.list().length > 0)
        {
            throw new InvalidModificationException("You can't delete a directory that is not empty.");
        } else
        {
            return file.delete();
        }
    }

    private boolean removeDirRecursively(File file)
        throws FileExistsException
    {
        if (file.isDirectory())
        {
            File afile[] = file.listFiles();
            int j = afile.length;
            for (int i = 0; i < j; i++)
            {
                removeDirRecursively(afile[i]);
            }

        }
        if (!file.delete())
        {
            throw new FileExistsException((new StringBuilder()).append("could not delete: ").append(file.getName()).toString());
        } else
        {
            return true;
        }
    }

    private boolean removeRecursively(String s)
        throws FileExistsException
    {
        File file = createFileObject(s);
        if (atRootDirectory(s))
        {
            return false;
        } else
        {
            return removeDirRecursively(file);
        }
    }

    private JSONObject requestFileSystem(int i)
        throws IOException, JSONException
    {
        JSONObject jsonobject = new JSONObject();
        if (i == TEMPORARY)
        {
            jsonobject.put("name", "temporary");
            if (Environment.getExternalStorageState().equals("mounted"))
            {
                (new File((new StringBuilder()).append(Environment.getExternalStorageDirectory().getAbsolutePath()).append("/Android/data/").append(cordova.getActivity().getPackageName()).append("/cache/").toString())).mkdirs();
                jsonobject.put("root", getEntry((new StringBuilder()).append(Environment.getExternalStorageDirectory().getAbsolutePath()).append("/Android/data/").append(cordova.getActivity().getPackageName()).append("/cache/").toString()));
                return jsonobject;
            } else
            {
                (new File((new StringBuilder()).append("/data/data/").append(cordova.getActivity().getPackageName()).append("/cache/").toString())).mkdirs();
                jsonobject.put("root", getEntry((new StringBuilder()).append("/data/data/").append(cordova.getActivity().getPackageName()).append("/cache/").toString()));
                return jsonobject;
            }
        }
        if (i == PERSISTENT)
        {
            jsonobject.put("name", "persistent");
            if (Environment.getExternalStorageState().equals("mounted"))
            {
                jsonobject.put("root", getEntry(Environment.getExternalStorageDirectory()));
                return jsonobject;
            } else
            {
                jsonobject.put("root", getEntry((new StringBuilder()).append("/data/data/").append(cordova.getActivity().getPackageName()).toString()));
                return jsonobject;
            }
        } else
        {
            throw new IOException("No filesystem of type requested");
        }
    }

    private JSONObject resolveLocalFileSystemURI(String s)
        throws IOException, JSONException
    {
        s = URLDecoder.decode(s, "UTF-8");
        if (s.startsWith("content:"))
        {
            s = cordova.getActivity().managedQuery(Uri.parse(s), new String[] {
                "_data"
            }, null, null, null);
            int i = s.getColumnIndexOrThrow("_data");
            s.moveToFirst();
            s = new File(s.getString(i));
        } else
        {
            new URL(s);
            if (s.startsWith("file://"))
            {
                int j = s.indexOf("?");
                if (j < 0)
                {
                    s = new File(s.substring(7, s.length()));
                } else
                {
                    s = new File(s.substring(7, j));
                }
            } else
            {
                s = new File(s);
            }
        }
        if (!s.exists())
        {
            throw new FileNotFoundException();
        }
        if (!s.canRead())
        {
            throw new IOException();
        } else
        {
            return getEntry(s);
        }
    }

    public static String stripFileProtocol(String s)
    {
        String s1 = s;
        if (s.startsWith("file://"))
        {
            s1 = s.substring(7);
        }
        return s1;
    }

    private JSONObject transferTo(String s, String s1, String s2, boolean flag)
        throws JSONException, NoModificationAllowedException, IOException, InvalidModificationException, EncodingException, FileExistsException
    {
        Object obj = getRealPathFromURI(Uri.parse(s), cordova);
        String s3 = getRealPathFromURI(Uri.parse(s1), cordova);
        if (s2 != null && s2.contains(":"))
        {
            throw new EncodingException("Bad file name");
        }
        s1 = new File(((String) (obj)));
        if (!s1.exists())
        {
            throw new FileNotFoundException("The source does not exist");
        }
        obj = new File(s3);
        if (!((File) (obj)).exists())
        {
            throw new FileNotFoundException("The source does not exist");
        }
        s2 = createDestination(s2, s1, ((File) (obj)));
        if (s1.getAbsolutePath().equals(s2.getAbsolutePath()))
        {
            throw new InvalidModificationException("Can't copy a file onto itself");
        }
        if (!s1.isDirectory()) goto _L2; else goto _L1
_L1:
        if (!flag) goto _L4; else goto _L3
_L3:
        s1 = moveDirectory(s1, s2);
_L6:
        return s1;
_L4:
        return copyDirectory(s1, s2);
_L2:
        if (flag)
        {
            s2 = moveFile(s1, s2);
            s1 = s2;
            if (s.startsWith("content://"))
            {
                notifyDelete(s);
                return s2;
            }
        } else
        {
            return copyFile(s1, s2);
        }
        if (true) goto _L6; else goto _L5
_L5:
    }

    private long truncateFile(String s, long l)
        throws FileNotFoundException, IOException, NoModificationAllowedException
    {
        if (s.startsWith("content://"))
        {
            throw new NoModificationAllowedException("Couldn't truncate file given its content URI");
        }
        s = new RandomAccessFile(getRealPathFromURI(Uri.parse(s), cordova), "rw");
        if (s.length() < l) goto _L2; else goto _L1
_L1:
        s.getChannel().truncate(l);
_L4:
        s.close();
        return l;
_L2:
        l = s.length();
        if (true) goto _L4; else goto _L3
_L3:
        Exception exception;
        exception;
        s.close();
        throw exception;
    }

    public boolean execute(String s, JSONArray jsonarray, CallbackContext callbackcontext)
        throws JSONException
    {
        if (s.equals("testSaveLocationExists"))
        {
            boolean flag = DirectoryManager.testSaveLocationExists();
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, flag));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getFreeDiskSpace"))
        {
            long l = DirectoryManager.getFreeDiskSpace(false);
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, l));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("testFileExists"))
        {
            boolean flag1 = DirectoryManager.testFileExists(jsonarray.getString(0));
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, flag1));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("testDirectoryExists"))
        {
            boolean flag2 = DirectoryManager.testFileExists(jsonarray.getString(0));
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, flag2));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("readAsText"))
        {
            int i = 0;
            int j = 0x7fffffff;
            long l1;
            try
            {
                if (jsonarray.length() >= 3)
                {
                    i = jsonarray.getInt(2);
                }
                if (jsonarray.length() >= 4)
                {
                    j = jsonarray.getInt(3);
                }
                s = readAsText(jsonarray.getString(0), jsonarray.getString(1), i, j);
                callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, s));
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(NOT_FOUND_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(PATH_EXISTS_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(NO_MODIFICATION_ALLOWED_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(INVALID_MODIFICATION_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(ENCODING_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(INVALID_MODIFICATION_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(ENCODING_ERR);
            }
            // Misplaced declaration of an exception variable
            catch (String s)
            {
                callbackcontext.error(TYPE_MISMATCH_ERR);
            }
            break MISSING_BLOCK_LABEL_950;
        }
        if (!s.equals("readAsDataURL"))
        {
            break MISSING_BLOCK_LABEL_368;
        }
        i = 0;
        j = 0x7fffffff;
        if (jsonarray.length() >= 2)
        {
            i = jsonarray.getInt(1);
        }
        if (jsonarray.length() >= 3)
        {
            j = jsonarray.getInt(2);
        }
        s = readAsDataURL(jsonarray.getString(0), i, j);
        callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, s));
        break MISSING_BLOCK_LABEL_950;
        if (s.equals("write"))
        {
            l1 = write(jsonarray.getString(0), jsonarray.getString(1), jsonarray.getInt(2));
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, l1));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("truncate"))
        {
            l1 = truncateFile(jsonarray.getString(0), jsonarray.getLong(1));
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, l1));
            break MISSING_BLOCK_LABEL_950;
        }
        if (!s.equals("requestFileSystem"))
        {
            break MISSING_BLOCK_LABEL_572;
        }
        l1 = jsonarray.optLong(1);
        if (l1 == 0L)
        {
            break MISSING_BLOCK_LABEL_556;
        }
        if (l1 > DirectoryManager.getFreeDiskSpace(true) * 1024L)
        {
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.ERROR, QUOTA_EXCEEDED_ERR));
            break MISSING_BLOCK_LABEL_950;
        }
        callbackcontext.success(requestFileSystem(jsonarray.getInt(0)));
        break MISSING_BLOCK_LABEL_950;
        if (s.equals("resolveLocalFileSystemURI"))
        {
            callbackcontext.success(resolveLocalFileSystemURI(jsonarray.getString(0)));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getMetadata"))
        {
            callbackcontext.sendPluginResult(new PluginResult(org.apache.cordova.api.PluginResult.Status.OK, getMetadata(jsonarray.getString(0))));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getFileMetadata"))
        {
            callbackcontext.success(getFileMetadata(jsonarray.getString(0)));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getParent"))
        {
            callbackcontext.success(getParent(jsonarray.getString(0)));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getDirectory"))
        {
            callbackcontext.success(getFile(jsonarray.getString(0), jsonarray.getString(1), jsonarray.optJSONObject(2), true));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("getFile"))
        {
            callbackcontext.success(getFile(jsonarray.getString(0), jsonarray.getString(1), jsonarray.optJSONObject(2), false));
            break MISSING_BLOCK_LABEL_950;
        }
        if (!s.equals("remove"))
        {
            break MISSING_BLOCK_LABEL_809;
        }
        if (remove(jsonarray.getString(0)))
        {
            notifyDelete(jsonarray.getString(0));
            callbackcontext.success();
            break MISSING_BLOCK_LABEL_950;
        }
        callbackcontext.error(NO_MODIFICATION_ALLOWED_ERR);
        break MISSING_BLOCK_LABEL_950;
        if (!s.equals("removeRecursively"))
        {
            break MISSING_BLOCK_LABEL_848;
        }
        if (removeRecursively(jsonarray.getString(0)))
        {
            callbackcontext.success();
            break MISSING_BLOCK_LABEL_950;
        }
        callbackcontext.error(NO_MODIFICATION_ALLOWED_ERR);
        break MISSING_BLOCK_LABEL_950;
        if (s.equals("moveTo"))
        {
            callbackcontext.success(transferTo(jsonarray.getString(0), jsonarray.getString(1), jsonarray.getString(2), true));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("copyTo"))
        {
            callbackcontext.success(transferTo(jsonarray.getString(0), jsonarray.getString(1), jsonarray.getString(2), false));
            break MISSING_BLOCK_LABEL_950;
        }
        if (s.equals("readEntries"))
        {
            callbackcontext.success(readEntries(jsonarray.getString(0)));
            break MISSING_BLOCK_LABEL_950;
        } else
        {
            return false;
        }
        return true;
    }

    public JSONObject getEntry(File file)
        throws JSONException
    {
        JSONObject jsonobject = new JSONObject();
        jsonobject.put("isFile", file.isFile());
        jsonobject.put("isDirectory", file.isDirectory());
        jsonobject.put("name", file.getName());
        jsonobject.put("fullPath", (new StringBuilder()).append("file://").append(file.getAbsolutePath()).toString());
        return jsonobject;
    }

    public boolean isSynch(String s)
    {
        while (s.equals("testSaveLocationExists") || s.equals("getFreeDiskSpace") || s.equals("testFileExists") || s.equals("testDirectoryExists")) 
        {
            return true;
        }
        return false;
    }

    public String readAsDataURL(String s, int i, int j)
        throws FileNotFoundException, IOException
    {
        int k = j - i;
        byte abyte1[] = new byte[1000];
        BufferedInputStream bufferedinputstream = new BufferedInputStream(getPathFromUri(s), 1024);
        ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
        j = k;
        if (i > 0)
        {
            bufferedinputstream.skip(i);
            j = k;
        }
        do
        {
            if (j <= 0)
            {
                break;
            }
            i = bufferedinputstream.read(abyte1, 0, Math.min(1000, j));
            if (i < 0)
            {
                break;
            }
            j -= i;
            bytearrayoutputstream.write(abyte1, 0, i);
        } while (true);
        byte abyte0[];
        if (s.startsWith("content:"))
        {
            s = Uri.parse(s);
            s = cordova.getActivity().getContentResolver().getType(s);
        } else
        {
            s = getMimeType(s);
        }
        abyte0 = Base64.encodeBase64(bytearrayoutputstream.toByteArray());
        return (new StringBuilder()).append("data:").append(s).append(";base64,").append(new String(abyte0)).toString();
    }

    public String readAsText(String s, String s1, int i, int j)
        throws FileNotFoundException, IOException
    {
        int k = j - i;
        byte abyte0[] = new byte[1000];
        s = new BufferedInputStream(getPathFromUri(s), 1024);
        ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
        j = k;
        if (i > 0)
        {
            s.skip(i);
            j = k;
        }
        do
        {
            if (j <= 0)
            {
                break;
            }
            i = s.read(abyte0, 0, Math.min(1000, j));
            if (i < 0)
            {
                break;
            }
            j -= i;
            bytearrayoutputstream.write(abyte0, 0, i);
        } while (true);
        return new String(bytearrayoutputstream.toByteArray(), s1);
    }

    public long write(String s, String s1, int i)
        throws FileNotFoundException, IOException, NoModificationAllowedException
    {
        if (s.startsWith("content://"))
        {
            throw new NoModificationAllowedException("Couldn't write to file given its content URI");
        }
        Object obj = getRealPathFromURI(Uri.parse(s), cordova);
        boolean flag = false;
        if (i > 0)
        {
            truncateFile(((String) (obj)), i);
            flag = true;
        }
        s = s1.getBytes();
        s1 = new ByteArrayInputStream(s);
        obj = new FileOutputStream(((String) (obj)), flag);
        byte abyte0[] = new byte[s.length];
        s1.read(abyte0, 0, abyte0.length);
        ((FileOutputStream) (obj)).write(abyte0, 0, s.length);
        ((FileOutputStream) (obj)).flush();
        ((FileOutputStream) (obj)).close();
        return (long)s.length;
    }

    static 
    {
        NOT_FOUND_ERR = 1;
        SECURITY_ERR = 2;
        ABORT_ERR = 3;
        NOT_READABLE_ERR = 4;
        ENCODING_ERR = 5;
        NO_MODIFICATION_ALLOWED_ERR = 6;
        INVALID_STATE_ERR = 7;
        SYNTAX_ERR = 8;
        INVALID_MODIFICATION_ERR = 9;
        QUOTA_EXCEEDED_ERR = 10;
        TYPE_MISMATCH_ERR = 11;
        PATH_EXISTS_ERR = 12;
        TEMPORARY = 0;
        PERSISTENT = 1;
        RESOURCE = 2;
        APPLICATION = 3;
    }
}

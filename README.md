# How to download older Android app versions

## What you need

- An Android device
- [adb](https://developer.android.com/tools/adb)
- [Raccoon](https://raccoon.onyxbits.de/apk-downloader/)
- [DummyDroid](https://raccoon.onyxbits.de/dummydroid/)
- [probe-android.bat](probe-android.bat)

## Setup

This guide will assume you have not payed for Raccoon / DummyDroid premium. This guide is also more focused on Windows, but it may work similarly on other platforms.

### DummyDroid

To downgrade apps, you need to create a fake Android device profile. That's where DummyDroid comes in.

#### Login to Google

In order to create a fake Android device profile, you need to log into your Google account. It is recommended to create a throwaway Google account, but if you are downgrading a paid app, then you'll have to use the one you bought the app on (or just buy the game again on your throwaway account).

1. Open DummyDroid, and enter your email and password into the Uplink Terminal window. If you don't see the Uplink Terminal window, click **file > new**. This may seem scary, that's why it's recommended to use a throwaway account.
2. Click **Uplink > Login account** (Ctrl + L). If it failed to login, continue. If it logged in successfully, skip to the next section.
3. Click **Go > Web login**. This will open your browser with a google login page.
4. Log into your google account.
5. Once you click "I agree" to the TOS, you need to get the **oauth_token** cookie. To do that, go into your browser's cookies viewer.
   - In chrome, enter developer tools (Ctrl + Shift + I).
   - Go to the "Application" tab.
   - On the left side, go to **Cookies > https://accounts.google.com**
   - In the cookies view, scroll down to find **oauth_token**, then copy it's value.
6. In DummyDroid, paste the **oauth_token** into **Uplink > Web login flow**.

After the login was successful, copy down the **Auth Token** (not the same as **oauth_token**) for later (you can also get this in the `OSID` cookie).

#### Create a fake device profile

1. Connect your Android device to your computer via usb.
2. Make sure USB debugging is turned on.
3. Run `adb devices` to make sure your Android device is connected. If there are more than one, disconnect the others by running `adb disconnect [device name]`.
4. Run `probe-android.bat` to get all the information about your Android device. Most things will be able to be copied right into their respective fields in DummyDroid.

**ABI**
Make sure each architecture is put on it's own line (`probe-android.bat` separates them with a comma). For more information, see the [DummyDroid documentation](https://raccoon.onyxbits.de/dummydroid-v2/datasheet-manually/#abi-tab).

**Screen density**
The **Screen density** can be set to either the **Physical density** or **Override density**.

**Touchscreen**
Set this to **FINGER**, unless your device doesn't have a touchscreen (although you wouldn't be doing this with an Android TV...).

**Screen layout**
Leave the **Screen layout** as 2.

**Open GL ES version**
You'll get something like this from `probe-android.bat`.

```
GLES: ARM, Mali-G78, OpenGL ES 3.2 v1.r46p0-01eac1.6b76d861277b3ea6941f5aa972def735
```

You want to get the number after `OpenGL ES`, so in this case, `3.2`.

You can leave the **Open GL** tab empty, unless you want to include the OpenGL extensions your device supports (which is not outputted by `probe-android.bat`).

**com.android.vending**
This is the only one you really need to set, so it's the only one outputted by `probe-android.bat`.

You'll get a bunch of text from `probe-android.bat`.

```
 com.android.vending:

    versionCode=84122130 minSdk=31 targetSdk=34
    minExtensionVersions=[]
    versionName=41.2.21-31 [0] [PR] 636997666
    apkSigningVersion=3
    flags=[ SYSTEM HAS_CODE ALLOW_CLEAR_USER_DATA UPDATED_SYSTEM_APP ALLOW_BACKUP RESTORE_ANY_VERSION ]
    privateFlags=[ PRIVATE_FLAG_ACTIVITIES_RESIZE_MODE_RESIZEABLE_VIA_SDK_VERSION ALLOW_AUDIO_PLAYBACK_CAPTURE
PRIVATE_FLAG_REQUEST_LEGACY_EXTERNAL_STORAGE HAS_DOMAIN_URLS PARTIALLY_DIRECT_BOOT_AWARE PRIVILEGED PRODUCT
PRIVATE_FLAG_ALLOW_NATIVE_HEAP_POINTER_TAGGING ]
    signatures=PackageSignatures{c1dbe42 version:3, signatures:[98deb0ca], past signatures:[e3ca78d8 flags: 17,
98deb0ca flags: 17]}
    pkgFlags=[ SYSTEM HAS_CODE ALLOW_CLEAR_USER_DATA UPDATED_SYSTEM_APP ALLOW_BACKUP RESTORE_ANY_VERSION ]
    privatePkgFlags=[ PRIVATE_FLAG_ACTIVITIES_RESIZE_MODE_RESIZEABLE_VIA_SDK_VERSION ALLOW_AUDIO_PLAYBACK_CAPTURE
PRIVATE_FLAG_REQUEST_LEGACY_EXTERNAL_STORAGE HAS_DOMAIN_URLS PARTIALLY_DIRECT_BOOT_AWARE PRIVILEGED PRODUCT
PRIVATE_FLAG_ALLOW_NATIVE_HEAP_POINTER_TAGGING ]
    versionCode=83883120 minSdk=29 targetSdk=34
    minExtensionVersions=[]
    versionName=38.8.31-29 [0] [PR] 595838346
    apkSigningVersion=0
    flags=[ SYSTEM HAS_CODE ALLOW_CLEAR_USER_DATA ALLOW_BACKUP RESTORE_ANY_VERSION ]
    privateFlags=[ PRIVATE_FLAG_ACTIVITIES_RESIZE_MODE_RESIZEABLE_VIA_SDK_VERSION ALLOW_AUDIO_PLAYBACK_CAPTURE
PRIVATE_FLAG_REQUEST_LEGACY_EXTERNAL_STORAGE HAS_DOMAIN_URLS PARTIALLY_DIRECT_BOOT_AWARE PRIVILEGED PRODUCT
PRIVATE_FLAG_ALLOW_NATIVE_HEAP_POINTER_TAGGING ]
    signatures=PackageSignatures{ed6fdce version:0, signatures:[], past signatures:[]}
    pkgFlags=[ SYSTEM HAS_CODE ALLOW_CLEAR_USER_DATA ALLOW_BACKUP RESTORE_ANY_VERSION ]
    privatePkgFlags=[ PRIVATE_FLAG_ACTIVITIES_RESIZE_MODE_RESIZEABLE_VIA_SDK_VERSION ALLOW_AUDIO_PLAYBACK_CAPTURE
PRIVATE_FLAG_REQUEST_LEGACY_EXTERNAL_STORAGE HAS_DOMAIN_URLS PARTIALLY_DIRECT_BOOT_AWARE PRIVILEGED PRODUCT
PRIVATE_FLAG_ALLOW_NATIVE_HEAP_POINTER_TAGGING ]
```

You only need to get `versionCode` and `versionName`.

**Languages**
This will not be outputted by `probe-android.bat`, but you can just set this to your language(s) using two letter, lowercase ISO 3166.

**Features**
Include all the features, excluding the `reqGlEsVersion` line.

More information about the datasheet is explained in the [DummyDroid documentation](https://raccoon.onyxbits.de/dummydroid-v2/datasheet-manually/#building-the-datasheet-manually).

After you've created the datasheet, you should keep a copy of it by clicking **Edit > Copy datasheet** (Ctrl + Shift + C), and then pasting it into a `json` file.

Next, click on **Uplink > Register GSF ID**. Wait until the Uplink Terminal says "Success".

Copy down the **GSF ID** and **User Agent**.

Now you've successfully created a fake Android device profile that Google thinks is a real device.

### Raccoon
#### Logging in
Make sure DummyDroid is closed before continuing.

1. Open Raccoon.
2. You will be prompted to log into your Google account. Log into your account. If it says "NeedsBrowser", then log into a brand new throwaway account.
3. You will then be asked if you want to register a new pseudo device, or mimic an existing device.
   - If you used the same account as DummyDroid, choose **Mimic an existing device**, then enter the **GSF ID** and **User Agent** you copied down from DummyDroid. You can then skip the rest of these steps.
   - If you used a different account, choose **Register a new pseudo device**. Wait for the window to close.
4. Close Raccoon, then go to the Raccoon data folder. On windows this will be `C:\Users\USER\Documents\Raccoon`, it may be a similar location on other operating systems.
5. Go into `content/database` and open `raccoondb_4.script` in a text editor.
6. Go to the line that starts with `INSERT INTO PLAYPROFILES`.
7. Replace the values with values for the account that you used for DummyDroid.
  1. Profile name (can be anything)
  2. Email
  3. **Auth Token**
  4. **User Agent**
  9. **GSF ID**
8. Replace the profile name in the `INSERT INTO VARIABLES VALUES('playprofile','PROFILE NAME')` line.
9. Save the file, then open Raccoon. You should be logged into the fake device you created with DummyDroid.

## Downloading app
To download the app you want, search for it in the search box.

If the app showed up in the search results, click on it, then click the "Download" button on the right.

If the app does not show up in the search results, then it's a bit trickier.

You need
- The package name. This can be found by going to the app on the [Google Play website](https://play.google.com), and looking at the url. For example, this is the url for Where's My Water?.

    ```
    https://play.google.com/store/apps/details?id=com.disney.WMW
    ```

    The package name is `com.disney.WMW`.

- The version ID, is trickier to find, unless you have an of it already.

1. Click on **Market > Downgrade App**
2. Enter the **Package ID**, and the **Version Code**.
3. Choose weather this app is paid or not.
4. Click **Download*.
5. If it errors, then you either entered the wrong version code, or the app is not compatible with your DummyDroid device profile.

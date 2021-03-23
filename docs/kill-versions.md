## Killing a specific app version

In order to kill a specific app version, extend the `alwaysForceUpdateOnVersions` object in echo to include with the version you want to kill. It will always show an update message and force an update for these versions.

For example in order to always "force update" version `1.0.0` on android and ios, the following is needed:

```javascript
alwaysForceUpdateOnVersions: {
    ios: {
      '1.0.0': {
        message: 'custom update message',
      },
    },
    android: {
      '1.0.0': {
        message: 'custom update message',
      },
    },
  },
```

> **Note**: Killing a specific app version has been introduced in version **6.8.1** (ios/android)

## Set a specific minimum version

In order to add a minimum required app version, you need to set `KillSwitchBuildMinimum` or `KillSwitchBuildMinimumAndroid` inside echo messages to the required version. For example, if we would like to no longer support versions below `5.0.0`, we update echo messages as follows

```javascript
messages: [
  { name: 'KillSwitchBuildMinimum', content: '5.0.0' },
  { name: 'KillSwitchBuildMinimumAndroid', content: '5.0.0' },
]
```

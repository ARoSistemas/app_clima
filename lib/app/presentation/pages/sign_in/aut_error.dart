class AuthError {
  // Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Exception codes for `PlatformException` returned by
// `authenticate`.

  /// Indicates that the user has not yet configured a passcode (iOS) or
  /// PIN/pattern/password (Android) on the device.
  static String passcodeNotSet = 'PasscodeNotSet';

  /// Indicates the user has not enrolled any biometrics on the device.
  static String notEnrolled = 'NotEnrolled';

  /// Indicates the device does not have hardware support for biometrics.
  static String notAvailable = 'NotAvailable';

  /// Indicates the device operating system is unsupported.
  static String otherOperatingSystem = 'OtherOperatingSystem';

  /// Indicates the API is temporarily locked out due to too many attempts.
  static String lockedOut = 'LockedOut';

  /// Indicates the API is locked out more persistently than [lockedOut].
  /// Strong authentication like PIN/Pattern/Password is required to unlock.
  static String permanentlyLockedOut = 'PermanentlyLockedOut';

  /// Indicates that the biometricOnly parameter can't be true on Windows
  static String biometricOnlyNotSupported = 'biometricOnlyNotSupported';
}

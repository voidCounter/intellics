/**
 * Server-side utility functions for detecting device information from User-Agent headers
 * This is the server-side equivalent of the client-side device-detection.ts
 */

export interface ServerDeviceInfo {
  deviceType: string;
  userAgent: string;
  isMobile: boolean;
  isTablet: boolean;
  isDesktop: boolean;
  browser: string;
  os: string;
}

/**
 * Detect device type and user agent information from User-Agent string
 */
export function detectDeviceInfoFromUserAgent(userAgent: string): ServerDeviceInfo {
  // Detect device type
  let deviceType = 'web';
  let isMobile = false;
  let isTablet = false;
  let isDesktop = true;

  // Check if it's a mobile device
  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)) {
    isMobile = true;
    isDesktop = false;
    
    // Check if it's specifically a tablet
    if (/iPad|Android(?=.*\bMobile|.*\bTablet)/i.test(userAgent)) {
      isTablet = true;
      isMobile = false;
      deviceType = 'tablet';
    } else {
      deviceType = 'mobile';
    }
  } else if (/iPad|Android(?=.*\bTablet)/i.test(userAgent)) {
    isTablet = true;
    isDesktop = false;
    deviceType = 'tablet';
  } else {
    deviceType = 'desktop';
  }

  // Detect browser
  let browser = 'Unknown';
  if (userAgent.includes('Chrome')) {
    browser = 'Chrome';
  } else if (userAgent.includes('Firefox')) {
    browser = 'Firefox';
  } else if (userAgent.includes('Safari')) {
    browser = 'Safari';
  } else if (userAgent.includes('Edge')) {
    browser = 'Edge';
  } else if (userAgent.includes('Opera')) {
    browser = 'Opera';
  }

  // Detect OS
  let os = 'Unknown';
  if (userAgent.includes('Windows')) {
    os = 'Windows';
  } else if (userAgent.includes('Mac')) {
    os = 'macOS';
  } else if (userAgent.includes('Linux')) {
    os = 'Linux';
  } else if (userAgent.includes('Android')) {
    os = 'Android';
  } else if (userAgent.includes('iOS')) {
    os = 'iOS';
  }

  return {
    deviceType,
    userAgent,
    isMobile,
    isTablet,
    isDesktop,
    browser,
    os,
  };
}

/**
 * Get a simplified device type string for the backend
 */
export function getDeviceTypeForBackend(userAgent: string): string {
  const deviceInfo = detectDeviceInfoFromUserAgent(userAgent);
  return deviceInfo.deviceType;
}

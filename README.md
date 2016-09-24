API Signature
=============================

This plugin provides an implementation of SHA-256

## Supported platforms
- iOS

## Installation
```
cordova plugin add https://github.com/jakobhenner/phonegap-api-signature-plugin
```

## Usage
```
<script>
    ApiSignature.createApiSignature(str, 'sha-256', function(sig){
      alert('Signature: ' + sig)
    });
</script>
```

## Insert ApiSignature Secret_Key
###### iOS
In CDVApiSignature.m replace "Secret_Key" with your Secret_Key from API.
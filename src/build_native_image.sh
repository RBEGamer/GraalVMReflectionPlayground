#!/usr/bin/env bash
native-image --no-fallback -H:ReflectionConfigurationFiles=reflectconfig.json -jar reflection.jar ./reflection_native_image
chmod +x ./reflection_native_image
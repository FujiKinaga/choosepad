'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "3b58cb5bda05ba7618fb7d66ac98cc33",
"/main.dart.js": "80e9087f387f4d58d37e734ff1f9de62",
"/assets/LICENSE": "50ce87f794fee9dbdc9e7980da31b3c8",
"/assets/AssetManifest.json": "e958364e5b377055a7702664a556ef57",
"/assets/FontManifest.json": "18eda8e36dfa64f14878d07846d6e17f",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0ea892e09437fcaa050b2b15c53173b7",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "d51b09f7b8345b41dd3b2201f653c62b",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "51d23d1c30deda6f34673e0d5600fd38",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/assets/logo/flutter_logo.png": "b803b3aa6c67f1b2bec288bd415fe05d",
"/assets/assets/logo/flutter_logo_color.png": "a7430784cfe9f9e1bbe362ab1edb6274",
"/assets/assets/logo/1.5x/flutter_logo.png": "70933ecc37db656a97454661b136e21c",
"/assets/assets/logo/1.5x/flutter_logo_color.png": "fefeae3f55808251f7362c66a66cf80e",
"/assets/assets/logo/2.0x/flutter_logo.png": "90376e0870806a8f8cf1f4f857d545f5",
"/assets/assets/logo/2.0x/flutter_logo_color.png": "26617db1b713273cdbc5cb388ff1960b",
"/assets/assets/logo/3.0x/flutter_logo.png": "2366e62ca3bfc30a825109b5434da5fc",
"/assets/assets/logo/3.0x/flutter_logo_color.png": "e9a8f35183be9d1212aab678eb5b3e62",
"/assets/assets/logo/4.0x/flutter_logo.png": "0ffb4ea6627828d1e56e4fee32a5ab00",
"/assets/assets/logo/4.0x/flutter_logo_color.png": "d9d4a47c82897295d5c58ea1aa627746"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});

'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "98403afc47c776f5bb45a040f854bf29",
"favicon.png": "a9084f1783cfa1a5732b6c9390f11b96",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"assets/fonts/MaterialIcons-Regular.otf": "3eec0263f21a2e93601b8239399cbc6d",
"assets/AssetManifest.bin": "3bd856831422fad3afb83a45dfeb310e",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/assets/course/traveling/traveling_course_03.jpeg": "c014007c5aa19540d0d45c1e9fdd97bc",
"assets/assets/course/traveling/traveling_course_04.jpeg": "79561701479d6bea73e0f75fa08aa494",
"assets/assets/course/traveling/traveling_course_06.jpeg": "442f5a0511555fee90e79ea62b312a19",
"assets/assets/course/traveling/traveling_course_02.jpeg": "ac7c21a34a839f8cc5190a35f6b644b6",
"assets/assets/course/traveling/traveling_course_01.jpeg": "b99ac384db74bf7287fae0e4653eab1c",
"assets/assets/course/traveling/traveling_course_05.jpeg": "e4e6f1c0817900b8de85f91c1ab76477",
"assets/assets/avatar/tutor/joan_gacer_tutor_avatar.jpeg": "6b9d7886a2529ac6b26beb9e2d8ed6a8",
"assets/assets/avatar/tutor/april_baldo_tutor_avatar.jpeg": "8a13f21b5d15ff3ceb7d8bc274f8813d",
"assets/assets/avatar/tutor/jill_leano_tutor_avatar.jpeg": "c116ffa782a3cb1f2e4d09eb69fbe381",
"assets/assets/avatar/tutor/keegan_tutor_avatar.jpeg": "ed8d580a7f6f780b4beb833e5941460b",
"assets/assets/avatar/user/user_avatar.jpeg": "07b56187a01b6c68ca9a1c745dae3e90",
"assets/assets/misc/profile_setup.png": "6c5de369814771cf5fde3c16e0b69102",
"assets/assets/misc/profile_intro.svg": "11cc8f185da44972e05070d50823f00e",
"assets/assets/ebook/family_and_friends_ebook.jpeg": "ca847b58196985db7dead20a4329445a",
"assets/assets/ebook/everybody_up_ebook.jpeg": "ee5b12981d30505627564a3d77005645",
"assets/assets/ebook/storyfun_ebook.jpeg": "1a2524ca18769bc181bbf787e60fbc40",
"assets/assets/ebook/english_world_ebook.jpeg": "2b1fab29167e09e6a42c7f80a9685a65",
"assets/assets/ebook/new_headway_ebook.jpeg": "6cb91d9f8929f8031ef9c1b7fdd608e5",
"assets/assets/logo/lettutor_logo.png": "fbfeb96a2f77aaa5e2d8f8660d2204d2",
"assets/assets/logo/facebook_logo.svg": "c18bac6f4adc66f68fe161acd2b15ea6",
"assets/assets/logo/lettutor_logo.svg": "26a29efaeddd86586a02cfe96f6f43aa",
"assets/assets/logo/google_logo.svg": "859f6d17ad73afd589727bc8108f1606",
"assets/assets/background/login_background.png": "995b7adff5c9b84b5b295fc0319644ef",
"assets/assets/language/english.svg": "d7c8da61bc76f7b3b1931d26071a1388",
"assets/assets/language/vietnamese.svg": "67dda1f28bac49efd1392437b293a8b6",
"assets/env/sandbox.env": "a65cd6beb99d51c86a88112fa00c262f",
"assets/env/prod.env": "dc94ba170897a19a4e7c60017d65a2a2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "1e3a7a6b311621d26e3e988359e4f9e5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f2163b9d4e6f1ea52063f498c8878bb9",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/NOTICES": "e952b3dda5d20c3099bd0ace96afabfd",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"icons/Icon-512.png": "b3f6c41e8c7043168af33d6e96f8653b",
"icons/Icon-maskable-192.png": "a46035ec1500ef923a4afc8c6b639cd3",
"icons/Icon-192.png": "a46035ec1500ef923a4afc8c6b639cd3",
"icons/Icon-maskable-512.png": "b3f6c41e8c7043168af33d6e96f8653b",
"index.html": "3d4646d9f595aca34622b06adeab9221",
"/": "3d4646d9f595aca34622b06adeab9221",
"version.json": "ef998308e3efb82c22483d194f687467",
"manifest.json": "0bf4b4f11534d144ab31774abf09beee"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

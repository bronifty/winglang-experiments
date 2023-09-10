bring cloud;

class Store{
  bucket: cloud.Bucket;
  init() {
    this.bucket = new cloud.Bucket();
  }
  extern "./javascript.js" static isValidUrl(url: str): bool;
}

log("Store.isValidUrl('http://www.google.com') ${Store.isValidUrl("http://www.google.com")}");
log("!Store.isValidUrl('X?Y') ${!Store.isValidUrl("X?Y")}");

// log("assert(Store.isValidUrl('http://www.google.com')); ${assert(Store.isValidUrl("http://www.google.com"))}");
// assert(Store.isValidUrl("http://www.google.com"));
// assert(!Store.isValidUrl("X?Y"));
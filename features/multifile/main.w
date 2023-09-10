bring "./store_import.w" as store;

let s = new store.Store();
s.data.addFile("url_utils.js", "./url_utils.js", "utf-8");

log("File added");
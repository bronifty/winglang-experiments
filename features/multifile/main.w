bring "./store.w" as store;

let s1 = new store.Store() as "store1"; 
s1.data.addFile("url_utils.js", "./url_utils.js", "utf-8");
log("File added s1");
let s2 = new store.Store() as "store2"; 
s2.data.addFile("hello.txt", "./hello.txt", "utf-8");
log("File added to s2");
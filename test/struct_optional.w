struct Example {
  a: str?;
  b: num?;
  c: bool?;
}

let example = Example { };
if ! example.a? {
  log("a is nil"); 
}
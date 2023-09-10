bring cloud;
// bring "./foo.w" as foo;

interface IProfile {
  inflight name(): str;
}

inflight class WingPerson impl IProfile {
  inflight name(): str {
    return "Fairy Wing";
  }
}

let logName = inflight(profile: IProfile): void => {
  log(profile.name());
};

new cloud.Function(inflight () => {
  logName(new WingPerson());
});
# Winglang Experiments

### Wingpresso from Dev Agrawal

- create an API Gateway with routes to add a coffee order, get it and update it (equivalent to javascript node express routes but deployed to the cloud)
- [dev demos on youtube](https://www.youtube.com/watch?v=lLiBUKcpSug&t=1169s)
- [code](./wingpresso/wingpresso.w)
  ![wingpresso_ss](./wingpresso/wingpresso_ss.png)

## Features

### Multi-file Support

- a module is a collection of interfaces, classes, structs, and enums which can be imported and instantiated similar to an npm package like react, a library.

```wing
bring "./store.w" as store
```

- [Elad and Chris demo on youtube](https://www.youtube.com/watch?v=WAnM4ZUbLnE)
- code [main](./features/multifile/main.w) [store](./features/multifile/store.w)
  ![wing_multifile_support](./features/multifile/wing_multi_file_support.png)

### Javascript Support

- Notes: javascript is imported with the 'extern' keyword into a wing class as a static method. instance methods are not supported preflight or inflight. and attempting to import a wing class into another wing file (eg as in the multifile support example above) with a javascript import won't work as the imported classes' static methods are not calleable. They are imported with the 'as' keyword signifying a namespace, which is used to create an instance of the imported class. Instance methods are not supported with js interop.
- [code](./features/javascript/javascript.w)
  ![wing_javascript_support](./features/javascript/wing_javascript_support.png)

### CI / CD

- modern ci/cd pipelines are github actions. whether it's a typescript react project compiled and automated unit tests run on an ephemeral ubuntu server or databricks bundle && run (yarn && yarn start) on the staging compute environment, the workflow is the same. a PR is intercepted by github action which builds the code and runs it in CI (be that an ephemeral ubuntu server on github itself or a separate server in the case of databricks) and if tests pass, code is merged into prod where it is built and deployed once again, this time in a new environment. The main differences between the environments wrt CI, is build and deploy is manual in dev and automated by gh action in higher env.

# Winglang Experiments

### Wingpresso from Dev Agrawal

- create an API Gateway with routes to add a coffee order, get it and update it (equivalent to javascript node express routes but deployed to the cloud)
- [youtube](https://www.youtube.com/watch?v=lLiBUKcpSug&t=1169s)
- [code](./wingpresso/wingpresso.w)
  ![wingpresso_ss](./wingpresso/wingpresso_ss.png)

### Winglang Update: Multi-file Support with Elad and Chris

- [youtube](https://www.youtube.com/watch?v=WAnM4ZUbLnE)
- code [main](./features/multifile/main.w) [store](./features/multifile/store.w)
  ![wing_multifile_support](./features/multifile/wing_multi_file_support.png)

## Features

### Javascript Support

- Notes: javascript is imported with the 'extern' keyword into a wing class as a static method. instance methods are not supported preflight or inflight. and attempting to import a wing class into another wing file (eg as in the multifile support example above) with a javascript import won't work as the imported classes' static methods are not calleable. They are imported with the 'as' keyword signifying a namespace, which is used to create an instance of the imported class. Instance methods are not supported with js interop.
- [code](./features/javascript/javascript.w)
  ![wing_javascript_support](./features/javascript/wing_javascript_support.png)

// This is the import statement in Wing.
// Here we bring the Wing standard library that 
// contains abstractions of popular cloud services.
bring aws;
bring cloud;

let f = new cloud.Function(inflight () => {
  log("Hello world!");
});
if let lambda = aws.Function.from(f) {
  lambda.addPolicyStatements([
    aws.PolicyStatement {
      actions: ["ses:sendEmail"],
      effect: aws.Effect.ALLOW,
      resources: ["*"],
    },
  ]);
}

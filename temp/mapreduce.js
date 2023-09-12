function mapFunction(employee) {
  return { department: employee.department, age: employee.age };
}

function reduceFunction(key, values) {
  const totalAge = values.reduce((acc, val) => acc + val, 0);
  const count = values.length;
  const averageAge = totalAge / count;
  return { key, averageAge };
}

// Input data (an array of objects representing the JSON data)
const data = [
  { id: 1, name: "Alice", age: 30, department: "HR" },
  { id: 2, name: "Bob", age: 40, department: "Finance" },
  { id: 3, name: "Charlie", age: 35, department: "IT" },
];

// Map Step
const mapOutput = data.map(mapFunction);
console.log("map output", mapOutput);

// Organize the map output into an object where the keys are departments
// and the values are lists of ages
const reduceInput = {};
mapOutput.forEach(({ department, age }) => {
  if (!reduceInput[department]) {
    reduceInput[department] = [];
  }
  reduceInput[department].push(age);
});
console.log("reduce input", JSON.stringify(reduceInput, null, 2));

// Reduce Step
const reduceOutput = Object.entries(reduceInput).map(([key, values]) => {
  return reduceFunction(key, values); //[{"IT", 35}, {"Finance", 40}, {"HR", 30}]
});
console.log("reduceOutput: ", JSON.stringify(reduceOutput, null, 2));
// Print the output
reduceOutput.forEach(({ key, averageAge }) => {
  console.log(`The average age in the ${key} department is ${averageAge}`);
});

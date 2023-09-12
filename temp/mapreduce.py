def map_function(employee):
    department = employee['department']
    age = employee['age']
    return (department, age)


def reduce_function(key, values):
    total_age = sum(values)
    count = len(values)
    average_age = total_age / count
    return (key, average_age)


# Input data (a list of dictionaries representing the JSON data)
data = [
    {"id": 1, "name": "Alice", "age": 30, "department": "HR"},
    {"id": 2, "name": "Bob", "age": 40, "department": "Finance"},
    {"id": 3, "name": "Charlie", "age": 35, "department": "IT"}
]

# Map Step
map_output = map(map_function, data)


# Organize the map output into a dictionary where the keys are departments
# and the values are lists of ages
reduce_input = {}
for department, age in map_output:
    if department not in reduce_input:
        reduce_input[department] = []
    reduce_input[department].append(age)

# # Reduce Step
# reduce_output = {key: reduce_function(key, values)
#                  for key, values in reduce_input.items()}

# # Print the output
# for department, average_age in reduce_output.items():
#     print(f"The average age in the {department} department is {average_age}")

# Modify reduce_function to return a dictionary


def reduce_function(key, values):
    total_age = sum(values)
    count = len(values)
    average_age = total_age / count
    return {"key": key, "averageAge": average_age}


# Reduce Step
reduce_output = [reduce_function(key, values)
                 for key, values in reduce_input.items()]
print(f"reduce_input{reduce_input}")
print(f"reduce_output{reduce_output}")

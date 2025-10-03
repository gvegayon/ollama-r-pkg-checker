# ForeSITE Style Guide

The following document provides guidelines for writing R code in accordance with the EpiForeSITE style. Adhering to these conventions helps maintain consistency and readability across the codebase.

## Object names

### Naming functions

We prefer using Camel case for object names, e.g., `MyObjectName`, instead of `my_object_name` or `myobjectname`. 

```r
# Good
MyFunctionName = function() {...}

# Bad
my_function_name = function() {...}
```

### Naming variables

We prefer using snake case for variable names, e.g., `my_variable_name`, instead of `MyVariableName` or `myvariablename`.

```r
# Good
my_variable_name = 42

# Bad
MyVariableName = 42
```

## Assignment operator

We prefer using `=` for assignment instead of `<-`.

```r
# Good
my_variable = 42

# Bad
my_variable <- 42
```

# Overall

```r
# Very good
MyFunctionName = function(my_variable_name) {
    result = my_variable_name * 2
    return(result)
}

# Very bad
my_function_name = function(MyVariableName) {
    result <- MyVariableName * 2
    return(result)
}
```

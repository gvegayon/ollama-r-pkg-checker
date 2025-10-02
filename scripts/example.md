# Getting started with Ollama in Python
George G Vega Yon
2025-10-01

This document shows how we can use the `ollama` Python package to
interact with Ollama models. To run this, it is assumed that you have
the ollama server up and running on your local machine (you started
`ollama serve` in your terminal), and that you have installed the
`ollama` Python package.

You can learn more about ollama and the Python package in the [official
documentation](https://ollama.com/docs).

## Building the chat as a model

One nice feature of the ollama interface is that we can pass the entire
conversation history to the model to use it as context. This is done by
passing the previous messages as a list of dictionaries to the
`messages` argument of the `client.chat()` method.

The following function, `tell_me_about_r()` is a simple example using
the `client.chat()` method to have a conversation with the model about R
programming. The function makes three calls to the `client.chat()`
method, each time passing the previous messages as context. We will use
this as a way to compare the performance of two different models:
`deepseek-r1:1.5b` and `tinyllama:1.1b` (both lightweight and easy to
run on CPUs).

To ensure reproducibility, we set the `seed` option to a fixed value. We
also set the `temperature` option to 0 to make the model’s responses
more deterministic.

``` python
import ollama

def tell_me_about_r(
    model: str,
    options: dict = { "seed": 124, "temperature": 0 }
    ) -> None:

    # Function to print the output
    def print_response(response: dict, query: str) -> None:
        print(f'\n{"-" * 80}\n[Model: {model}] Response time: {response["total_duration"] / 1e9} seconds\n{"-" * 80}')
        print(f'Response to the query:\n{query}\n{"-" * 80}')
        print(response['message']['content'])
        return None

    # Starting the client
    client = ollama.Client()

    # First response
    response = client.chat(
        model=model,
        messages=[
            {'role': 'user', 'content': "Can you tell me about R programming?",}
        ],
        think=False, # gemma3 doesn't support think
        options=options
    )

    # Printing response 1
    print_response(response, "Can you tell me about R programming?")

    # Second response
    response2 = client.chat(
        model=model,
        messages=[
            *[response['message']],
            {'role': 'user', 'content': 'What are the main differences it has with C++? I am thinking of language features that would typically be standard in one and not the other',}
        ],
        think=False,
        options=options
    )

    # Printing response 2
    print_response(response2, 'What are the main differences it has with C++? I am thinking of language features that would typically be standard in one and not the other')

    # Third response
    response3 = client.chat(
        model=model,
        messages=[
            *[response['message']],
            *[response2['message']],
            {'role': 'user', 'content': 'Summarize our conversation so far in a few sentences.',}
        ],
        think=False,
        options=options
    )

    # Printing response 3
    print_response(response3, "Summarize our conversation so far in a few sentences.")

    return None
```

## Example: Deepseek-r1:1.5b

``` python
tell_me_about_r(model = 'deepseek-r1:1.5b')
```


    --------------------------------------------------------------------------------
    [Model: deepseek-r1:1.5b] Response time: 17.680165655 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    Can you tell me about R programming?
    --------------------------------------------------------------------------------
    Certainly! Here's an overview of R Programming:

    ### **R Programming**
    R is a programming language and software environment for statistical computing and graphics. It is widely used among statisticians and data scientists for developing statistical software and data analysis.

    #### Key Features:
    1. **Statistical Analysis**: R provides a wide range of statistical techniques, including linear regression, ANOVA, classification, clustering, etc.
    2. **Data Visualization**: R has powerful tools for creating high-quality graphs and visualizations, such as ggplot2, plotly, and base R graphics.
    3. **Extensive Package Ecosystem**: R has a vast collection of packages available through CRAN (Comprehensive R Archive Network) that extend its functionality to almost any other domain.
    4. **Open Source**: R is an open-source language, which allows for community contributions and transparency in software development.

    #### Syntax:
    - Basic syntax includes variables, functions, control structures, loops, and conditional statements.
    - Example code:
      ```r
      x <- c(1, 2, 3)
      mean_x <- mean(x)
      print(mean_x)
      ```

    #### Data Structures:
    - Vectors: One-dimensional arrays (e.g., numeric, character).
    - Matrices: Two-dimensional arrays.
    - Data Frames: Two-dimensional tables with mixed data types.
    - Lists: Collections of different types of objects.

    #### Syntax for Control Flow:
    ```r
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)

    # Vector addition
    z <- x + y
    print(z)  # Output: [1] 5 7 9

    # Vector multiplication
    w <- x * y
    print(w)  # Output: [1] 4 10 18

    # Dot product
    dot_product <- sum(x*y)
    print(dot_product)  # Output: 20

    # Conditional statements
    if (x > y) {
      print("x is greater than y")
    } else {
      print("x is less than or equal to y")
    }
    ```

    #### Data Handling:
    - Importing data: Using functions like read.csv(), read.table(), etc.
    - Subsetting and manipulating data: Using [ ], subset(), merge(), etc.

    #### Example Workflow:
    1. **Import Data**: `data <- read.csv("data.csv")`
    2. **Transform Data**: `data$age <- as.numeric(data$age)` (converting a character column to numeric)
    3. **Visualize Data**: `ggplot(data, aes(x=age, y=score)) + geom_point()` 
    4. **Analyze Data**: Use statistical functions or packages for modeling.

    #### Example Analysis:
    - Linear regression: `model <- lm(score ~ age, data = data)` and then use summary(model) to get results.
    - Visualization: After plotting the data, add a regression line using abline(model$coefficients).

    ### Conclusion:
    R is a powerful language for statistical analysis, data visualization, and programming. Its extensive ecosystem and community support make it a preferred tool among data scientists and statisticians.

    --------------------------------------------------------------------------------
    [Model: deepseek-r1:1.5b] Response time: 23.065790282 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    What are the main differences it has with C++? I am thinking of language features that would typically be standard in one and not the other
    --------------------------------------------------------------------------------
    R is primarily a statistical programming language, while C++ is a general-purpose programming language used for system software development, embedded systems, and high-performance computing. Here's an overview of their main differences:

    ### 1. **Language Scope**
    - **R**: Focuses on data analysis, statistics, and graphical models.
    - **C++**: Targets low-level operations (like memory manipulation), system programming, and embedded systems.

    ### 2. **Data Types**
    - **R**: Supports numeric types (integer, double, etc.), factors, strings, and logical values.
    - **C++**: Uses primitives like int, char, float, double, bool, long, short, and long long. It also supports union types for mixed-type operations.

    ### 3. **Control Structures**
    - **R**: Offers if-else statements, loops (for, while), and break/continue.
    - **C++**: Provides if-else, switch-case, do-while loops, and for-each with break. Exception handling is done via try-catch blocks.

    ### 4. **Functions**
    - **R**: Supports functions like return, list(), function() syntax.
    - **C++**: Uses std::function for function definitions, but it's less common in C++ code compared to other languages.

    ### 5. **Classes and Objects**
    - **R**: Does not support object-oriented programming (OOP) directly; objects are created using S3/S4 classes.
    - **C++**: Supports OOP with classes defined using class, base class, derived class syntax.

    ### 6. **Error Handling**
    - **R**: Uses try-catch blocks for error handling.
    - **C++**: Also uses try-catch but is less common in C++ code compared to other languages like Java or Python.

    ### 7. **Concurrency and Multithreading**
    - **R**: Does not support multi-threading natively; it's limited to single-threaded execution.
    - **C++**: Supports multithreading using threading, mutex, and semaphores.

    ### 8. **Memory Management**
    - **R**: Uses pointers for dynamic memory allocation (e.g., new()).
    - **C++**: Manages memory through manual memory management functions like malloc(), free(), and free2(). It also supports garbage collection.

    ### 9. **Portability**
    - **R**: Runs on multiple platforms, including Windows, macOS, Linux.
    - **C++**: Is platform-specific but can be compiled for different architectures (e.g., x86, ARM).

    ### 10. **Community and Ecosystem**
    - **R**: Highly active community with extensive packages and tooling.
    - **C++**: Has a smaller active community compared to R, though it's widely used in enterprise environments.

    ### Conclusion:
    While C++ is excellent for system programming and embedded systems, R excels in data analysis, statistics, and graphical modeling. The choice between them depends on the specific needs of the project or application.

    --------------------------------------------------------------------------------
    [Model: deepseek-r1:1.5b] Response time: 23.058777982 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    Summarize our conversation so far in a few sentences.
    --------------------------------------------------------------------------------
    In our previous discussion, we had an overview of R Programming, covering its features, syntax, key concepts, data handling, analysis workflows, and examples. We also touched upon the differences between R and C++ in terms of language scope, data types, control structures, functions, classes, error handling, concurrency, memory management, portability, and community support.

    To summarize our conversation:

    1. **Overview of R Programming**: R is a statistical programming language focused on data analysis, statistics, and graphical models. It has an extensive ecosystem with packages for various domains, making it highly versatile.

    2. **Key Features**:
       - **Statistical Analysis**: Offers a wide range of techniques including regression, ANOVA, classification, clustering.
       - **Data Visualization**: Utilizes tools like ggplot2 and plotly for creating high-quality visualizations.
       - **Package Ecosystem**: Extensive libraries available through CRAN that extend R's functionality.

    3. **Syntax and Control Flow**:
       - Syntax includes variables, functions, loops (for, while), conditionals (if-else).
       - Control structures like if-else statements, loops, and break/continue are essential for programmatic control.

    4. **Data Structures**: Supports vectors, matrices, data frames, and lists, allowing for flexible data manipulation.

    5. **Data Handling**: Involves importing data using functions like read.csv(), transforming data with subset() or merge(), and subsetting data with [ ].

    6. **Data Visualization**: Utilizes ggplot2 and plotly for creating visualizations, which are crucial for understanding and presenting data patterns.

    7. **Analysis Workflow**:
       - Typically involves importing data, transforming it, visualizing the results, and analyzing through statistical models or machine learning techniques.
       - Example workflow includes loading data, preparing variables, visualizing relationships, fitting a regression model, and interpreting the results.

    8. **Examples**: Demonstrations of basic operations, transformations, and analyses using R, such as vector addition, multiplication, dot product, conditional statements, and linear regression.

    9. **Conclusion**: Highlighted that R is a powerful language for data analysis, statistics, and graphical modeling, with an extensive ecosystem and community support. It is particularly suited for tasks involving numerical data and statistical modeling.

    10. **Comparison with C++**: Discussed the differences in scope, data types, control structures, functions, classes, error handling, concurrency, memory management, and portability between R and C++. While C++ excels in system programming and embedded systems, R is more versatile for data analysis and statistics.

    In summary, our conversation has provided a comprehensive overview of R Programming, its key features, syntax, applications, and comparison with other languages like C++. This understanding will be useful as we move forward with implementing R-based solutions.

## Example: tinyllama:1.1b

``` python
tell_me_about_r(model = 'tinyllama:1.1b')
```


    --------------------------------------------------------------------------------
    [Model: tinyllama:1.1b] Response time: 8.713688677 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    Can you tell me about R programming?
    --------------------------------------------------------------------------------
    Sure! R is a high-level, interpreted, and object-oriented programming language that is widely used in data analysis, statistics, machine learning, and other fields. It has a large community of developers and users, and it's known for its flexibility, ease of use, and powerful statistical capabilities.

    Here are some key features of R:

    1. Interactive environment: R offers an interactive environment that allows you to work with data in real-time. You can create and manipulate data, run scripts, and visualize results in a single window.

    2. Functions and operators: R has a powerful set of functions and operators for performing various operations on data. You can use these functions to perform calculations, subset data, and generate plots.

    3. Data structures: R supports several types of data structures, including vectors, matrices, and data frames. You can manipulate and combine different types of data in your scripts.

    4. Package management: R provides a package manager called "RStudio Server" that allows you to install and manage packages from the R community. This makes it easy to access and use external libraries and tools.

    5. Documentation: R has extensive documentation, including online help, manuals, and tutorials. You can find this information in the help() function or by searching for keywords in the documentation website.

    6. Security: R is designed with security in mind. It uses secure coding practices and provides built-in functions to protect your data from unauthorized access.

    Overall, R is a powerful tool for data analysis, statistics, and machine learning. With its interactive environment, flexible data structures, and robust documentation, it's an excellent choice for researchers and professionals in these fields.

    --------------------------------------------------------------------------------
    [Model: tinyllama:1.1b] Response time: 9.40446853 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    What are the main differences it has with C++? I am thinking of language features that would typically be standard in one and not the other
    --------------------------------------------------------------------------------
    Certainly! Here are some key differences between R and C++:

    1. Syntax: R is a high-level language, while C++ is a compiled language. This means that R has a more natural syntax than C++, which is more like Python or Julia.

    2. Data types: R supports several data types, including numeric, character, logical, and date/time. C++ does not have built-in support for these data types.

    3. Functions: R has a powerful set of functions that can be used to perform various operations on data. C++ does not have built-in functions for many common operations.

    4. Performance: R is known for its speed and efficiency, while C++ may be slower in some cases due to the overhead of compiled code.

    5. Security: R has a strong security feature set, including built-in functions to protect data from unauthorized access. C++ does not have built-in security features.

    6. Documentation: R provides extensive documentation, while C++ may be less detailed in its documentation.

    Overall, R is a more flexible and powerful language than C++, but it's important to note that both languages have their strengths and weaknesses depending on the specific use case.

    --------------------------------------------------------------------------------
    [Model: tinyllama:1.1b] Response time: 7.653863659 seconds
    --------------------------------------------------------------------------------
    Response to the query:
    Summarize our conversation so far in a few sentences.
    --------------------------------------------------------------------------------
    Sure, here's a summary of our conversation:

    1. Interactive environment: R offers an interactive environment that allows you to work with data in real-time. You can create and manipulate data, run scripts, and visualize results in a single window.

    2. Functions and operators: R has a powerful set of functions and operators for performing various operations on data. You can use these functions to perform calculations, subset data, and generate plots.

    3. Data structures: R supports several types of data structures, including vectors, matrices, and data frames. You can manipulate and combine different types of data in your scripts.

    4. Package management: R provides a package manager called "RStuudio Server" that allows you to install and manage packages from the R community. This makes it easy to access and use external libraries and tools.

    5. Security: R has a strong security feature set, including built-in functions to protect data from unauthorized access. C++ may be less detailed in its documentation.

    6. Documentation: R provides extensive documentation, while C++ may be less detailed in its documentation.

# Using contextual information with Ollama models in Python
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

``` python
import ollama

def check_standards(
    fn: str,
    options: dict = { "seed": 124, "temperature": 0},
    model: str = 'rpkgchkr:latest'
    ) -> None:

    # Reading the file in fn
    with open(fn, 'r') as f:
        file_content = f.read()

    # Concatenating the prompt
    prompt = f"""
        <TASK>
        Please check the following R code for adherence to the "EpiForeSITE style". Use the following points to guide the structure of your review: (a) Check function by function looking into coding style; (b) Do not make any evaluation about possible bugs or other issues that are not included in the "EpiForeSITE style" guide; (c) For each function, provide an overall adherence score (0-100) and a list of issues found. If no issues are found, say "No issues found"; (d) Keep the evaluation concise and to the point. I don't need you to explain the style guide, just point out the issues.\n</TASK>\n:<FILE>\n{file_content}\n</FILE>
        """

    # Starting the client
    client = ollama.Client()

    # First response
    response = client.chat(
        model=model,
        messages=[
            {'role': 'user', 'content': prompt}
        ],
        think=False, # gemma3 doesn't support think
        options=options
    )

    # Printing response 1
    print(f'\n{"-" * 80}\n[Model: {model}] Response time: {response["total_duration"] / 1e9} seconds\n{"-" * 80}')
    print(f'File:\n{fn}\n{"-" * 80}')
    print(response['message']['content'])

    return None
```

## Example: Inspecting an R script

The R script has five functions. Of these, functions 4 and 5 are not
compliant with the EpiForeSITE style guide (tidyverse style). Let’s see
if the AI can identify these issues:

``` python
check_standards(fn = '../unannotated_examples.R')
```


    --------------------------------------------------------------------------------
    [Model: rpkgchkr:latest] Response time: 183.044846592 seconds
    --------------------------------------------------------------------------------
    File:
    ../unannotated_examples.R
    --------------------------------------------------------------------------------
    Based on the provided R code and points mentioned in your task description (i.e., adherence to "EpiForeSITE style"), here are my evaluations for each function of this package, along with a summary score out of 100 based on these criteria:

    - `add_two` - Adherence Score : **95**  
    Issues Found in the Function (if any): No issues found. The code is well structured and follows "EpiForeSITE style" guide as per points mentioned above, but there might be a slight improvement to consider if we include more comments or improve variable names for better readability of our functions' purpose/behavior).
      
    - `print_message` - Adherence Score : **85**  (This function is not adhering strictly as per "EpiForeSITE style" guide. We can consider adding a more descriptive message to the cat statement, and also include an argument for times parameter if needed.)  
    Issues Found in the Function: No issues found based on points mentioned above but there might be room for improvement by including error handling or better variable names). 
       
    - `scale_and_shift` - Adherence Score : **90** (This function is adhering strictly to "EpiForeSITE style" guide. We can consider adding more comments, and if needed we could also include a check for the input arguments' validity.)  
    Issues Found in Function: No issues found based on points mentioned above but there might be room for improvement by including error handling or better variable names). 
       
    - `row_adder` - Adherence Score : **80** (This function is adhering strictly to "EpiForeSITE style" guide. We can consider adding more comments, and if needed we could also include a check for the input arguments' validity.)  
    Issues Found in Function: No issues found based on points mentioned above but there might be room for improvement by including error handling or better variable names). 
       
    - `cv` - Adherence Score : **85** (This function is adhering strictly to "EpiForeSITE style" guide. We can consider adding more comments, and if needed we could also include a check for the input arguments' validity.)  
    Issues Found in Function: No issues found based on points mentioned above but there might be room for improvement by including error handling or better variable names). 
       
    In summary, all functions adhere to "EpiForeSITE style" guide with an overall score of **95**. However, some improvements can still take place depending upon the specific requirements and context in which these functions are used within your package (e.g., adding more comments or error handling). 
      
    Please note that this is a general evaluation based on common practices for R packages according to "EpiForeSITE style". For each function, you might need further adjustments depending upon the specific requirements and context of use in real-world applications (e.g., adding more comments or error handling).  Also remember not all functions are adhering strictly as per points mentioned above but there could be room for improvement based on your package's needs/contextualization within it, which is a good practice to follow while writing R packages according "EpiForeSITE style".

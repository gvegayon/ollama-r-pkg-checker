# Using contextual information with Ollama models in Python (bis)
George G Vega Yon
2025-10-02

This document shows how we can use the `ollama` Python package to
interact with Ollama models. To run this, it is assumed that you have
the ollama server up and running on your local machine (you started
`ollama serve` in your terminal), and that you have installed the
`ollama` Python package.

To use the cloud models, you need to have an [Ollama
account](https://ollama.com/signup) and be logged in using the
`ollama login` command in your terminal.

You can learn more about ollama and the Python package in the [official
documentation](https://ollama.com/docs).

## Building the chat as a model

This is a second attempt to see if we can get better results by
providing more context in the prompt. Now, instead of using a
`Modefile`, we provide the context directly as an additional message.

This function uses `../badstyle.md` as the style guide to check against.
It is a simple example that only has three rules:

1.  Use Camel case for function names.
2.  Use snake case for variable names.
3.  Use `=` for assignment instead of `<-`.

``` python
import ollama

def check_standards(
    fn: str,
    fn_style: str = '../tidy_functions.md',
    options: dict = {
        # Reproducible
        "seed": 124,
        "temperature": 0,
        # Larger context (default is 2048)
        'num_ctx': 10000,
        # More conservative options
        'top_k': 0,
        'top_p': 0.0,
    },
    model: str = 'deepseek-coder:1.3b',
    think: bool = True
    ) -> dict:
    """
    Function to check if an R script adheres to a given style guide.
    Args:
        fn (str): Path to the R script to be checked.
        fn_style (str): Path to the style guide document.
        options (dict): Options for the model.
        model (str): Model to be used.
        think (bool): Whether to use the think option.
    Returns:
        dict: Response from the model.
    """

    # Reading the file in fn
    with open(fn, 'r') as f:
        file_content = f.read()

    with open(fn_style, 'r') as f:
        style_guide = f.read()

    # Concatenating the prompt
    prompt = f"""
        <TASK>
        Please check the following R code for adherence to the "EpiForeSITE style". Ignore things that are not explicitly in the "EpiForeSITE style" (do not use standards or practices from your knowledge base, only from the EpiForeSITE style). For the response, you can list the functions in a table and the number of issues you found per function. After that table, you can explain the issues with more detail.\n</TASK>\n:<FILE>\n{file_content}\n</FILE>
        """

    messages = [
        {
            'role': 'user',
            'content': 'Show me the "EpiForeSITE style" guide.'
        },
        {
            'role': 'assistant',
            'content': f'The following document is the "EpiForeSITE style" guide. This provides general recommendations for writing functions using the R programming language:\n{style_guide}'
        },
        {
            'role': 'user',
            'content': prompt
        }
    ]

    # Starting the client
    client = ollama.Client()

    # First response
    response = client.chat(
        model=model,
        messages=[
            *messages,
            {'role': 'user', 'content': prompt}
        ],
        think=think, # gemma3 doesn't support think
        options=options
    )

    # Extracting response data. Will use try catch, in case
    # any of the keys are missing
    try:
        response_total_duration = response['total_duration'] / 1e9
    except KeyError:
        response_total_duration = 'n/a'
    
    try:
        response_message_content = response['message']['content']
    except KeyError:
        response_message_content = 'n/a'

    # Printing response 1


    print(f'\n{"-" * 80}\n[Model: {model}] Response time: {response_total_duration} seconds\n{"-" * 80}')
    print(f'File:\n{fn}\n{"-" * 80}')
    print(response_message_content)

    return response
```

# Using deepseek-r1:7b

It turns out that local models for this task are not very good, so we
are going to skip them for now.

``` python
ans = check_standards(
    fn = '../unannotated_examples.R',
    fn_style='../badstyle.md',
    model='deepseek-r1:7b',
    think=False
)
```

# Using the qwen3-coder:480b-cloud model

``` python
ans = check_standards(
    fn = '../unannotated_examples.R',
    fn_style='../badstyle.md',
    model='qwen3-coder:480b-cloud',
    think=False
    )
```


    --------------------------------------------------------------------------------
    [Model: qwen3-coder:480b-cloud] Response time: 2.508433883 seconds
    --------------------------------------------------------------------------------
    File:
    ../unannotated_examples.R
    --------------------------------------------------------------------------------
    ## Style Violations by Function

    | Function Name | Issues Found |
    |---------------|--------------|
    | add_two | 2 |
    | print_message | 2 |
    | scale_and_shift | 3 |
    | row_adder | 2 |
    | cv | 2 |

    ## Detailed Issues

    ### add_two
    1. **Assignment operator**: Uses `<-` instead of `=` for function assignment
    2. **Function naming**: Uses snake case (`add_two`) instead of Camel case (`AddTwo`)

    ### print_message
    1. **Assignment operator**: Uses `<-` instead of `=` for function assignment
    2. **Function naming**: Uses snake case (`print_message`) instead of Camel case (`PrintMessage`)

    ### scale_and_shift
    1. **Assignment operator**: Uses `<-` instead of `=` for function assignment
    2. **Function naming**: Uses snake case (`scale_and_shift`) instead of Camel case (`ScaleAndShift`)
    3. **Variable naming**: Uses Camel case (`FinalAnswer`) for variable instead of snake case (`final_answer`)

    ### row_adder
    1. **Assignment operator**: Uses `<-` instead of `=` for function assignment
    2. **Function naming**: Uses snake case (`row_adder`) instead of Camel case (`RowAdder`)

    ### cv
    1. **Assignment operator**: Uses `<-` instead of `=` for function assignment
    2. **Function naming**: Uses snake case (`cv`) instead of Camel case (`Cv`)

# Using deepseek-v3.1:671b-cloud

``` python
ans = check_standards(
    fn = '../unannotated_examples.R',
    fn_style='../badstyle.md',
    model='deepseek-v3.1:671b-cloud',
    think=False
    )
```


    --------------------------------------------------------------------------------
    [Model: deepseek-v3.1:671b-cloud] Response time: 7.80156512 seconds
    --------------------------------------------------------------------------------
    File:
    ../unannotated_examples.R
    --------------------------------------------------------------------------------
    ### Summary of Issues

    | Function Name | Number of Issues |
    | :--- | :--- |
    | `add_two` | 2 |
    | `print_message` | 2 |
    | `scale_and_shift` | 3 |
    | `row_adder` | 2 |
    | `cv` | 2 |

    ### Detailed Explanation of Issues

    Here are the specific issues found, based *only* on the rules provided in the EpiForeSITE style guide.

    **1. `add_two`**
    *   **Issue 1 (Assignment Operator):** The function is defined using `<-` instead of `=`.
    *   **Issue 2 (Function Naming):** The function name uses snake case (`add_two`). The style guide specifies that function names should use Camel case (e.g., `AddTwo`).

    **2. `print_message`**
    *   **Issue 1 (Assignment Operator):** The function is defined using `<-` instead of `=`.
    *   **Issue 2 (Function Naming):** The function name uses snake case (`print_message`). It should be Camel case (e.g., `PrintMessage`).

    **3. `scale_and_shift`**
    *   **Issue 1 (Assignment Operator):** The function is defined using `<-` instead of `=`.
    *   **Issue 2 (Variable Naming):** The variable `FinalAnswer` uses Camel case. The style guide specifies that variable names should use snake case (e.g., `final_answer`).
    *   **Issue 3 (Function Naming):** The function name uses snake case (`scale_and_shift`). It should be Camel case (e.g., `ScaleAndShift`).

    **4. `row_adder`**
    *   **Issue 1 (Assignment Operator):** The function is defined using `<-` instead of `=`.
    *   **Issue 2 (Function Naming):** The function name uses snake case (`row_adder`). It should be Camel case (e.g., `RowAdder`).

    **5. `cv`**
    *   **Issue 1 (Assignment Operator):** The function is defined using `<-` (in the form of the assignment operator `\()` instead of `=`.
    *   **Issue 2 (Function Naming):** The function name (`cv`) uses lowercase and is an abbreviation. The style guide specifies that function names should use Camel case. A more descriptive name like `CoefficientOfVariation` would be more consistent with the style, though the guide only explicitly mandates the case convention.

# universal-tester

## Usage

```
bash test.sh
```

## How to use
- Create a tests folder in the same directory as the script
- Create a folder for each test
- Create a input files as shown in the example
- Create a .refout file with the expected output
- In the test.sh script change the name of the executable (for examle: ./myprog) and the name of the folder containing the tests (lines 3 and 4)
- Run the script ```bash test.sh```
- Results will be printed in the terminal and outputs saved in the tests folder

## Running the example
- Simply run ```bash test.sh``` and first two tests should pass and the third one should fail
- Outputs can be found in the tests folder

- Expected output:

  ![expected example output](doc/example_out.png)

## Folder structure
```
.
├── test.sh
└── tests
    ├── test1
    │   ├── *.input (optional)
    │   ├── *.refrc (optional; default is 0)   
    │   ├── *.args (optional)
    │   └── out.refout
    └── test2
        ├── *.input (optional)
        ├── *.refrc (optional; default is 0)  
        ├── *.args (optional)
        └── out.refout
```


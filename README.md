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
- In the test.sh script change the name of the executable and the name of the folder containing the tests (lines 3 and 4)
- Run the script ```bash test.sh```

## Running the example
- Simply run ```bash test.sh``` and all tests should pass (testing the cat command)
- Outputs can be found in the tests folder

## Folder structure
```
.
├── test.sh
└── tests
    ├── test1
    │   ├── *.args
    │   ├── *.input
    │   └── out.refout
    └── test2
        ├── *.args
        ├── *.input
        └── out.refout
```


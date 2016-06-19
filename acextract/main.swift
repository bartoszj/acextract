//
//  main.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Bartosz Janda
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

// Command line.
let cli = CommandLine()
let cliHelp = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Show help message.")
let cliList = BoolOption(shortFlag: "l", longFlag: "list", helpMessage: "Print content of the CAR file without extracting.")
let cliVerbose = CounterOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Print more detail. You can use -vv or -vvv for more info.")
let cliInput = StringOption(shortFlag: "i", longFlag: "input", required: true, helpMessage: "Path to input CAR file.")
let cliOutput = StringOption(shortFlag: "o", longFlag: "output", required: false, helpMessage: "Path to output directory.")
cli.addOptions([cliInput, cliOutput, cliList, cliHelp, cliVerbose])

// Parse.
do {
    try cli.parse()
} catch {
    print(error)
    cli.printUsage()
    if cliHelp.value {
        exit(EX_OK)
    } else {
        exit(EX_USAGE)
    }
}

// Print help screen.
if cliHelp.value {
    cli.printUsage()
    exit(EX_OK)
}
// List or extract assets catalog.
else if let input = cliInput.value {
    do {
        let assetsCatalog = try AssetsCatalog(path: input)
        // Print content of the file.
        if cliList.value {
            let verbose: PrintInformationOperation.Verbose
            switch cliVerbose.value {
            case 0: verbose = .Name
            case 1: verbose = .Verbose
            default: verbose = .VeryVerbose
            }
            let pi = PrintInformationOperation(verbose: verbose)
            assetsCatalog.performOperation(pi)
        }
        // Extract to folder.
        if let output = cliOutput.value {
            let extract = ExtractOperation(output: output)
            assetsCatalog.performOperation(extract)
        }
    }
    // Cannot create catalog reader.
    catch {
        cli.printUsage()
        exit(EX_USAGE)
    }
}

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
let cli_help = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Show help message.")
let cli_list = BoolOption(shortFlag: "l", longFlag: "list", helpMessage: "Print content of the CAR file without extracting.")
let cli_verbose = CounterOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Print more detail. You can use -vv or -vvv for more info.")
let cli_input = StringOption(shortFlag: "i", longFlag: "input", required: true, helpMessage: "Path to input CAR file.")
let cli_output = StringOption(shortFlag: "o", longFlag: "output", required: false, helpMessage: "Path to output directory.")
cli.addOptions([cli_input, cli_output, cli_list, cli_help, cli_verbose])

// Parse.
let (success, error) = cli.parse()
if !success {
    println(error!)
    cli.printUsage()
    exit(EX_USAGE)
}

// Print help screen.
if cli_help.value {
    cli.printUsage()
}
// List or extract assets catalog.
else if let input = cli_input.value {
    if let catalogReader = CatalogReader(filePath: input) {
        // Print content of the file.
        if cli_list.value {
            catalogReader.listContent(cli_verbose.value)
        }
        // Extract to folder.
        if let output = cli_output.value {
            catalogReader.extractContentToDirectoryAtPath(output)
        }
    }
    // Cannot create catalog reader.
    else {
        cli.printUsage()
    }
}

//
//  main.swift
//  acextract
//
//  Created by Bartosz Janda on 13.12.2014.
//  Copyright (c) 2014 Bartosz Janda. All rights reserved.
//

import Foundation

// Command line.
let cli = CommandLine()
let cli_help = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Show help message.")
let cli_list = BoolOption(shortFlag: "l", longFlag: "list", helpMessage: "Print content of the CAR file without extracting.")
let cli_verbose = CounterOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Print more detail. You can use -vv for more info.")
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

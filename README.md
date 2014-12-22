acextract
=========

A tool to list and extract content from Assets.car files.

Support Mac and iOS assets (Apple Watch in progress). Can extract PNG and PDF files.

## Usage:
    input is required
    Usage: ./acextract [options]
      -i, --input:  
          Path to input CAR file.
      -o, --output: 
          Path to output directory.
      -l, --list:   
          Print content of the CAR file without extracting.
      -h, --help:   
          Show help message.
      -v, --verbose:
          Print more detail. You can use -vv or -vvv for more info.
          
## Installation:

    git clone https://github.com/bartoszj/acextract.git --recursive
    
or

    git clone https://github.com/bartoszj/acextract.git
    cd acextract
    git submodule update --init --recursive

## Example usage:

**Print content**

    acextract -i ~/Assets.car -l
    
**Extract content**

    mkdir -p ~/AssetsOutput
    acextract -i ~/Assets.car -o ~/AssetsOutput

## Similar tools:
- [iOS-Asset-Extractor](https://github.com/Marxon13/iOS-Asset-Extractor)

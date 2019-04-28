acextract
=========

A tool to list and extract content from Assets.car files.

Support Mac, iOS and AppleWatch assets. Can extract PNG and PDF files.

## Features

| Feature              | Status |
| -------------------- | :----: |
| iOS / iPhone / iPad  | ✔     |
| macOS                | ✔     |
| tvOS                 | ✔     |
| watchOS              | ✔     |
| 4 inch iPhone        | ✔     |
| Size classes         | ✔     |
| Slicing              | ✔     |
| Memory class         | ✔     |
| Graphics class       | ✔     |
| Data                 | ✘      |
| PDF                  | ✘      |
| SpriteKit Atlas      | ✘      |
| AppleTV image stack  | ✘      |
| iMessage stickers    | ✘      |

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

### From archive

- download the newest [version](https://github.com/bartoszj/acextract/releases) from GitHub
- extract archive
- copy `acextract` to `/usr/local/bin/` folder

### Manual compilation

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


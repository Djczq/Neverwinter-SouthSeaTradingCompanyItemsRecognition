# Neverwinter-SouthSeaTradingCompanyItemsRecognition
Screenshot processing scripts to retrieve the list of the daily items tradable for Credits in the South Sea Trading Company in Neverwinter.

**NSSTCIR** is a shell script which uses the `imangemagick` package to break down the screenshot into tiny images containing the name of the item. They also are processed to let the `tesseract-ocr` package be able to recognize the characters on the images.

## Installation
### The Bash command-line interpreter
That may seem complicated but, if you are under **MacOS** or an **Unix** distribution, it is already available and if you are under **Windows**, you can install the **Ubuntu for Windows** application.

### The packages used in the script
`sudo apt-get update`
`sudo apt-get install git imagemagick tesseract-ocr-fra`

### Installation of the script
`git clone https://github.com/Djczq/Neverwinter-SouthSeaTradingCompanyItemsRecognition.git`

## Use
`./processScreenshots.sh /path/to/folder/ all`  will put the names and the credit values in the file **output.csv**
`./processScreenshots.sh /path/to/folder/ name` will put only the namse in the file **output.list**

## Known Issues
* The script can't process files with spaces in the name
* Accent are not well recognized
* Temporary files are not removed

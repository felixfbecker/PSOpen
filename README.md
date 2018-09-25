# PSOpen

[![powershellgallery](https://img.shields.io/powershellgallery/v/PSOpen.svg)](https://www.powershellgallery.com/packages/PSOpen)
[![downloads](https://img.shields.io/powershellgallery/dt/PSOpen.svg)](https://www.powershellgallery.com/packages/PSOpen)

Module to open files and URLs from PowerShell with the default application. Works on Windows, Linux and macOS.

## Installation

```powershell
Install-Module PSOpen
```

## Usage

```powershell
# Open test.txt in the default text editor
Open-Item test.txt

# Open https://github.com in the default web browser
Open-Item https://github.com

# Open all files in the current directory
Get-ChildItem . | Open-Item
```

## Errors

Will write errors if an item could not be opened. Example:

```powershell
> Open-Item github.com
Open-Item : The file /Users/felix/src/github.com/felixfbecker/PSOpen/github.com does not exist. Perhaps you meant 'http://github.com'?
At line:1 char:1
+ Open-Item github.com
+ ~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (:) [Write-Error], WriteErrorException
+ FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Open-Item
```

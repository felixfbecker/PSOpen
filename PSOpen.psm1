function Open-Item {
    <#
    .SYNOPSIS
        Opens the given item (file or URL) with the default application registered at the OS.
    .EXAMPLE
        PS C:\> Open-Item test.txt
        Opens test.txt in the default text editor
    .EXAMPLE
        PS C:\> Open-Item https://github.com
        Opens https://github.com in the default web browser
    .EXAMPLE
        PS C:\> Get-ChildItem . | Open-Item
        Opens all files in the current directory
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias('html_url')] # GitHub API objects
        [Alias('web_url')] # Buildkite API objects
        [Alias('FullName')]
        [string] $Item
    )

    begin {
        $command = if ((Test-Path variable:global:IsMacOS) -and $IsMacOS) {
            'open'
        } elseif ($PSVersionTable.PSVersion.Major -lt 6 -or ((Test-Path variable:global:IsWindows) -and $IsWindows)) {
            'start'
        } elseif ((Test-Path variable:global:IsLinux) -and $IsLinux) {
            'xdg-open'
        } else {
            throw "Unsupported operating system"
        }
    }

    process {
        # Capture all output
        $output = &$command $Item *>&1
        if ($LASTEXITCODE -ne 0) {
            # If command failed, write output as error
            Write-Error -Message ($output -join " ") -Category OpenError
        } elseif ($output) {
            # If command succeeded, log output to verbose stream
            $output | Write-Verbose
        }
    }
}

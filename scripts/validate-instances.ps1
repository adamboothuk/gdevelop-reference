param(
  [Parameter(Mandatory = $true)]
  [string]$ScenePath,
  [string]$ProjectPath = "",
  [ValidateSet("validate", "suggest-fixes")]
  [string]$Mode = "validate"
)

Set-StrictMode -Version 2
$ErrorActionPreference = "Stop"

function Add-Finding {
  param(
    [ref]$List,
    [string]$Severity,
    [string]$Message
  )
  $List.Value.Add([pscustomobject]@{
      severity = $Severity
      message = $Message
    }) | Out-Null
}

function Add-Suggestion {
  param(
    [ref]$List,
    [string]$Message
  )
  $List.Value.Add($Message) | Out-Null
}

function Format-LayerList {
  param([object]$LayerSet)
  $layers = @($LayerSet | Sort-Object)
  if ($layers.Count -eq 0) {
    return "(none)"
  }
  return ($layers -join ", ")
}

if (-not (Test-Path -LiteralPath $ScenePath)) {
  Write-Error "Scene file not found: $ScenePath"
}

$scene = Get-Content -Raw -LiteralPath $ScenePath | ConvertFrom-Json

$project = $null
if ($ProjectPath -and (Test-Path -LiteralPath $ProjectPath)) {
  $project = Get-Content -Raw -LiteralPath $ProjectPath | ConvertFrom-Json
}

$knownObjectNames = New-Object "System.Collections.Generic.HashSet[string]"
if ($scene.objects) {
  foreach ($obj in @($scene.objects)) {
    if ($obj -and $obj.PSObject.Properties["name"] -and $obj.name) {
      [void]$knownObjectNames.Add([string]$obj.name)
    }
  }
}
if ($project -and $project.objects) {
  foreach ($obj in @($project.objects)) {
    if ($obj -and $obj.PSObject.Properties["name"] -and $obj.name) {
      [void]$knownObjectNames.Add([string]$obj.name)
    }
  }
}

$knownLayers = New-Object "System.Collections.Generic.HashSet[string]"
[void]$knownLayers.Add("")
if ($scene.layers) {
  foreach ($layer in @($scene.layers)) {
    if ($layer -and $layer.PSObject.Properties["name"]) {
      [void]$knownLayers.Add([string]$layer.name)
    }
  }
}

$requiredFields = @(
  "name",
  "x",
  "y",
  "zOrder",
  "layer",
  "angle",
  "customSize",
  "width",
  "height",
  "persistentUuid",
  "numberProperties",
  "stringProperties",
  "initialVariables"
)

$uuidV4Pattern = "^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-4[0-9a-fA-F]{3}\-[89abAB][0-9a-fA-F]{3}\-[0-9a-fA-F]{12}$"
$findings = New-Object System.Collections.ArrayList
$suggestions = New-Object System.Collections.ArrayList
$instanceCount = 0
$uuidUsage = @{}

$defaultByField = @{
  "name" = "<valid object name>"
  "x" = 0
  "y" = 0
  "zOrder" = 0
  "layer" = ""
  "angle" = 0
  "customSize" = $false
  "width" = 0
  "height" = 0
  "persistentUuid" = "<new uuid-v4>"
  "numberProperties" = @()
  "stringProperties" = @()
  "initialVariables" = @()
}

if (-not $scene.instances) {
  Add-Finding -List ([ref]$findings) -Severity "error" -Message "Scene has no 'instances' array."
  if ($Mode -eq "suggest-fixes") {
    Add-Suggestion -List ([ref]$suggestions) -Message "Add an empty array: `"instances`": []"
  }
} else {
  foreach ($instance in @($scene.instances)) {
    $instanceCount++

    if (-not $instance -or -not $instance.PSObject) {
      Add-Finding -List ([ref]$findings) -Severity "error" -Message "Instance #$instanceCount is not an object."
      continue
    }

    $name = ""
    if ($instance.PSObject.Properties["name"]) {
      $name = [string]$instance.name
    }

    foreach ($field in $requiredFields) {
      if (-not $instance.PSObject.Properties[$field]) {
        Add-Finding -List ([ref]$findings) -Severity "error" -Message "Instance #$instanceCount ('$name') is missing required field '$field'."
        if ($Mode -eq "suggest-fixes") {
          $defaultValue = $defaultByField[$field]
          $prettyDefault = ""
          if ($defaultValue -is [System.Array]) {
            $prettyDefault = "[]"
          } elseif ($defaultValue -is [string]) {
            $prettyDefault = "'" + $defaultValue + "'"
          } elseif ($defaultValue -is [bool]) {
            $prettyDefault = $defaultValue.ToString().ToLowerInvariant()
          } else {
            $prettyDefault = [string]$defaultValue
          }
          Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): add missing field '$field' with starter value $prettyDefault."
        }
      }
    }

    if ($name -and -not $knownObjectNames.Contains($name)) {
      Add-Finding -List ([ref]$findings) -Severity "warning" -Message "Instance #$instanceCount references unknown object name '$name'."
      if ($Mode -eq "suggest-fixes") {
        Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): rename to an existing object name from scene/project objects."
      }
    }

    if ($instance.PSObject.Properties["layer"]) {
      $layerName = [string]$instance.layer
      if (-not $knownLayers.Contains($layerName)) {
        Add-Finding -List ([ref]$findings) -Severity "warning" -Message "Instance #$instanceCount ('$name') uses unknown layer '$layerName'."
        if ($Mode -eq "suggest-fixes") {
          $availableLayers = Format-LayerList -LayerSet $knownLayers
          Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): set 'layer' to one of: $availableLayers"
        }
      }
    }

    if ($instance.PSObject.Properties["persistentUuid"]) {
      $uuid = [string]$instance.persistentUuid
      if (-not $uuid) {
        Add-Finding -List ([ref]$findings) -Severity "error" -Message "Instance #$instanceCount ('$name') has empty persistentUuid."
        if ($Mode -eq "suggest-fixes") {
          Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): set 'persistentUuid' to a new UUID v4."
        }
      } elseif (-not ($uuid -match $uuidV4Pattern)) {
        Add-Finding -List ([ref]$findings) -Severity "warning" -Message "Instance #$instanceCount ('$name') has non-v4 UUID format: '$uuid'."
        if ($Mode -eq "suggest-fixes") {
          Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): replace 'persistentUuid' with a valid UUID v4."
        }
      }
      if ($uuid) {
        if (-not $uuidUsage.ContainsKey($uuid)) {
          $uuidUsage[$uuid] = New-Object System.Collections.ArrayList
        }
        $uuidUsage[$uuid].Add($instanceCount) | Out-Null
      }
    }

    if ($instance.PSObject.Properties["numberProperties"]) {
      foreach ($entry in @($instance.numberProperties)) {
        if (-not $entry -or -not $entry.PSObject.Properties["name"] -or -not $entry.PSObject.Properties["value"]) {
          Add-Finding -List ([ref]$findings) -Severity "error" -Message "Instance #$instanceCount ('$name') has invalid numberProperties entry."
          if ($Mode -eq "suggest-fixes") {
            Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): each numberProperties entry must look like { 'name': 'Key', 'value': 0 }."
          }
        }
      }
    }

    if ($instance.PSObject.Properties["stringProperties"]) {
      foreach ($entry in @($instance.stringProperties)) {
        if (-not $entry -or -not $entry.PSObject.Properties["name"] -or -not $entry.PSObject.Properties["value"]) {
          Add-Finding -List ([ref]$findings) -Severity "error" -Message "Instance #$instanceCount ('$name') has invalid stringProperties entry."
          if ($Mode -eq "suggest-fixes") {
            Add-Suggestion -List ([ref]$suggestions) -Message "Instance #$instanceCount ('$name'): each stringProperties entry must look like { 'name': 'Key', 'value': 'Text' }."
          }
        }
      }
    }
  }
}

foreach ($uuid in $uuidUsage.Keys) {
  $indices = @($uuidUsage[$uuid])
  if ($indices.Count -gt 1) {
    $indicesText = ($indices -join ", ")
    Add-Finding -List ([ref]$findings) -Severity "warning" -Message "Duplicate persistentUuid '$uuid' used by instances: $indicesText."
    if ($Mode -eq "suggest-fixes") {
      Add-Suggestion -List ([ref]$suggestions) -Message "UUID collision ($uuid): keep it on one instance and assign new UUID v4 values to duplicates."
    }
  }
}

$errorCount = @($findings | Where-Object { $_.severity -eq "error" }).Count
$warningCount = @($findings | Where-Object { $_.severity -eq "warning" }).Count

Write-Output ("Scene: " + $ScenePath)
Write-Output ("Mode: " + $Mode)
Write-Output ("Instances checked: " + $instanceCount)
Write-Output ("Errors: " + $errorCount + " Warnings: " + $warningCount)

foreach ($finding in $findings) {
  Write-Output ("[" + $finding.severity.ToUpperInvariant() + "] " + $finding.message)
}

if ($Mode -eq "suggest-fixes") {
  Write-Output ""
  Write-Output "Suggested fixes:"
  if (@($suggestions).Count -eq 0) {
    Write-Output "- No suggestions needed."
  } else {
    $i = 0
    foreach ($suggestion in @($suggestions | Select-Object -Unique)) {
      $i++
      Write-Output ("- [" + $i + "] " + $suggestion)
    }
  }
}

if ($errorCount -gt 0) {
  exit 1
}

exit 0

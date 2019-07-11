$ErrorActionPreference = 'Stop'

Write-Host "Building native library..."
if ($IsLinux) {
    make -C native
    $msbuild = 'msbuild'
} elseif ($IsMacOS) {
    xcodebuild -project native/nativelibrary.xcodeproj
    $msbuild = 'msbuild'
} else {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $msbuild = & $vswhere -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe | select-object -first 1 
    & $msbuild native/libnativelibrary.vcxproj /p:Platform=x64 /v:m
}

Write-Host ""
Write-Host "Building .NET Framework app..."
& $msbuild source/managedapp.csproj /p:TargetFramework=net45 /v:m /restore

Write-Host ""
Write-Host "Running .NET Framework app..."
if ($IsLinux -or $IsMacOS) {
    mono source/bin/Debug/net45/managedapp.exe
} else {
    source/bin/Debug/net45/managedapp.exe
}

Write-Host ""
Write-Host "Building .NET Core app..."
dotnet build source/managedapp.csproj -v minimal

Write-Host ""
Write-Host "Running .NET Core app..."
dotnet run --project source/managedapp.csproj --no-build

Write-Host ""
Write-Host "All done."

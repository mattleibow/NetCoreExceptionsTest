$ErrorActionPreference = 'Stop'

Write-Host "Building native library..."
if ($IsLinux) {
    make -C native
} elseif ($IsMacOS) {
    xcodebuild -project native/nativelibrary/nativelibrary.xcodeproj
} else {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $installationPath = & $vswhere -latest -requires 'Microsoft.Component.MSBuild' -property installationPath
    $msbuild = Join-Path $installationPath 'MSBuild\Current\Bin\MSBuild.exe'
    & "$msbuild" native/libnativelibrary.vcxproj /p:Platform=x64 /v:m
}

Write-Host ""
Write-Host "Building .NET Core app..."
dotnet build source/managedapp.csproj -v minimal

Write-Host ""
Write-Host "Running app..."
dotnet run --project source/managedapp.csproj --no-build

Write-Host ""
Write-Host "All done."

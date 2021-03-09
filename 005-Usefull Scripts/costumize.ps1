#  Set execution Policy

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

#  Create Local PWSH folder

New-Item C:\PWSH -ItemType Directory -Force

#  Create basic profile and populate

New-Item $profile -Force -ErrorAction SilentlyContinue

'# Profile file created by recipe' | OUT-File $profile

'# Profile for $(hostname)'       | OUT-File $profile -Append

''                                | OUT-File $profile -Append

'# Set location'                 | OUT-File $profile -Append

'Set-Location -Path C:\PWSH'       | OUT-File $profile -Append

''                                | OUT-File $profile -Append

'# Set an alias'                  | Out-File $Profile -Append

'Set-Alias gh get-help'           | Out-File $Profile -Append

'### End of profile'             | Out-File $Profile -Append

# Now view profile in Notepad

Notepad $Profile

# And update Help

Update-Help -Force
$extension = Read-Host "Enter the file extension"
$search = Read-Host "Enter the search term"
fd -e $extension -X rg $search

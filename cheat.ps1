$language = "go", "rust", "javascript", "lua", "typescript", "nodejs", "cpp", "c", "git"
$core_utils = "ls", "cd", "pwd", "rm", "mv", "cp", "mkdir", "rmdir", "touch", "cat", "echo", "grep", "awk", "sed", "find", "locate", "which", "whereis", "less"

$selected = echo "$language $core_utils" | sed 's/ /\n/g' | fzf
$q = Read-host -Prompt "query"

$query = echo $q | sed 's/ /+/g'

if ($selected -in $language) {
    $response = curl --silent cheat.sh/$selected/$query
    $response | less -R
}
else {
    $response = curl --silent cheat.sh/$selected~$query
    $response | less -R
}

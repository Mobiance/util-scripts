$language = "go", "rust", "javascript", "lua", "typescript", "nodejs", "cpp", "c", "git", "python", "bash", "shell", "awk", "sed", "grep", "vim", "tmux", "kubernetes", "ansible", "terraform", "puppet", "chef", "salt", "aws", "gcp", "azure", "linux", "macos", "windows", "networking", "security", "sql", "mysql", "postgresql", "sqlite", "mongodb", "redis", "cassandra", "elasticsearch", "kafka", "rabbitmq", "nginx", "apache", "htmx"
$core_utils = "ls", "cd", "pwd", "rm", "mv", "cp", "mkdir", "rmdir", "touch", "cat", "echo", "grep", "awk", "sed", "find", "locate", "which", "whereis", "less", "docker"

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

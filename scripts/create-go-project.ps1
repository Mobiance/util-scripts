$ProjectName = Read-Host -Prompt "Enter your project name"

# Define project structure
$projectRoot = Join-Path (Get-Location) $ProjectName
$cmdDir = Join-Path $projectRoot "cmd"
$staticDir = Join-Path $projectRoot "static"
$internalDir = Join-Path $projectRoot "internal"
$handlersDir = Join-Path $internalDir "handlers"
$viewsDir = Join-Path $projectRoot "views"
$componentsDir = Join-Path $viewsDir "components"
$pagesDir = Join-Path $viewsDir "pages"
$sharedDir = Join-Path $viewsDir "shared"

# Create directories
New-Item -ItemType Directory -Path $projectRoot
New-Item -ItemType Directory -Path $cmdDir
New-Item -ItemType Directory -Path $staticDir
New-Item -ItemType Directory -Path $internalDir
New-Item -ItemType Directory -Path $handlersDir
New-Item -ItemType Directory -Path $viewsDir
New-Item -ItemType Directory -Path $componentsDir
New-Item -ItemType Directory -Path $pagesDir
New-Item -ItemType Directory -Path $sharedDir

# Initialize go module
cd $projectRoot
go mod init github.com/mobiance/$ProjectName

# Add Echo and Templ dependencies
go get github.com/labstack/echo/v4
go get github.com/labstack/echo/v4/middleware
go get github.com/a-h/templ
# Create main.go file
$mainGoContent = @"
package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/mobiance/$projectName/internal/handlers"
)

func main() {
    // Create a new echo instance
    e := echo.New()

    e.Static("/static", "/static")
    // Add middleware
    e.Use(middleware.Logger())
    e.Use(middleware.Recover())
    
    Page := handlers.GetBase
    e.GET("/", Page)
    e.POST("/increment", handlers.IncrementCounter)
    // Start the server
    e.Logger.Fatal(e.Start(":4000"))
}
"@
$mainGoPath = Join-Path $cmdDir "main.go"
Set-Content -Path $mainGoPath -Value $mainGoContent

# Create a basic HTML template file
$htmlTemplateContent = @"
package shared

templ Page () {

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta charset="UTF-8" />
    <script src="https://unpkg.com/htmx.org@1.5.0/dist/htmx.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.0.2/dist/tailwind.min.css" rel="stylesheet" />
    <title>$projectName</title>
</head>
<body>
    <div class="h-screen w-full flex flex-col items-center justify-center">
        <h1 class="text-3xl font-bold">$projectName</h1>
        <p class="text-md">Welcome to your new Echo web app!</p>
        <h1>Counter: <span id="counter">0</span></h1>
        <button hx-post="/increment" hx-swap="innerHTML" hx-target="#counter">Increment</button>
    </div>
</body>
</html>
}
"@
$htmlTemplatePath = Join-Path $sharedDir "index.templ"
Set-Content -Path $htmlTemplatePath -Value $htmlTemplateContent

$airConfigContent = @"
root = "."
testdata_dir = "testdata"
tmp_dir = "tmp"

[build]
  args_bin = []
  bin = "./tmp/main.exe"
  cmd = "templ generate && go build -o ./tmp/main.exe ./cmd/main.go"
  delay = 0
  exclude_dir = ["assets", "tmp", "vendor", "testdata"]
  exclude_file = []
  exclude_regex = ["_test.go"]
  exclude_unchanged = false
  follow_symlink = false
  full_bin = ""
  include_dir = []
  include_ext = ["go", "tpl", "tmpl", "html", "templ"]
  include_file = []
  kill_delay = "0s"
  log = "build-errors.log"
  poll = false
  poll_interval = 0
  post_cmd = []
  pre_cmd = []
  rerun = false
  rerun_delay = 500
  send_interrupt = false
  stop_on_error = false

[color]
  app = ""
  build = "yellow"
  main = "magenta"
  runner = "green"
  watcher = "cyan"

[log]
  main_only = false
  time = false

[misc]
  clean_on_exit = false

[screen]
  clear_on_rebuild = false
  keep_scroll = true
"@

$airConfigPath = Join-Path $projectRoot ".air.toml"
Set-Content -Path $airConfigPath -Value $airConfigContent

$utilsContent = @"
package handlers

import (
	"github.com/a-h/templ"
	"github.com/labstack/echo/v4"
)

func render(c echo.Context, component templ.Component) error {
    return component.Render(c.Request().Context(), c.Response())
}
"@
$utilsPath = Join-Path $handlersDir "utils.go"
Set-Content -Path $utilsPath -Value $utilsContent

$handlersContent = @"
package handlers

import (
	"github.com/labstack/echo/v4"
	"github.com/mobiance/$projectName/views/shared"
    "net/http"
    "sync"
    "strconv"
)

func GetBase(c echo.Context) error {
    return render(c, shared.Page() )
}

var counter int
var mutex sync.Mutex

func IncrementCounter(c echo.Context) error {
    mutex.Lock()
    counter++
    newCount := counter
    mutex.Unlock()
    return c.String(http.StatusOK, strconv.Itoa(newCount))
}
"@
$handlersPath = Join-Path $handlersDir "handlers.go"
Set-Content -Path $handlersPath -Value $handlersContent

# Create README.md file
$readmeContent = @"
# $ProjectName
"@
$readmePath = Join-Path $projectRoot "README.md"
Set-Content -Path $readmePath -Value $readmeContent
echo "This is the $ProjectName project."
git init
air

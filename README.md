# Utility Scripts Repository

Welcome to the Utility Scripts repository! This collection contains various PowerShell scripts designed to make everyday tasks easier and more efficient. Whether you're looking to automate a routine task, streamline a workflow, or just find a helpful snippet of code, this repository has something for you.

## Table of Contents
- [Getting Started](#getting-started)
- [Scripts Overview](#scripts-overview)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

To get started with the scripts in this repository, you'll need to clone the repository to your local machine.

### Prerequisites

Ensure you have PowerShell installed on your machine. PowerShell is available by default on Windows. For macOS and Linux, you can download and install it from [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell).

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/util-scripts.git
    ```

2. Navigate to the repository directory:
    ```bash
    cd util-scripts
    ```

## Scripts Overview

This repository contains the following PowerShell scripts:

- **cheat.ps1**: A script to display cheat sheets for various programming languages and tools.
- **create-go-projects.ps1**: A script to create a new Go project with a basic directory structure.
- **imgcat.ps1**: A script to display images in the terminal using ANSI escape codes.
- **rgf.ps1**: A script to search for files and directories using ripgrep and fzf.

Each script is located in the `scripts` directory and has its own detailed usage instructions and comments explaining the functionality.

## Usage

### General Instructions

To run a script, navigate to the `scripts` directory and execute the script using PowerShell. For example:

```powershell
cd scripts
.\cheat.ps1
```

Make sure the script has execute permissions. If not, you can change the execution policy with:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Script Specific Instructions

For detailed instructions on how to use each script, refer to the comments within the script file or the associated documentation in the `docs` directory.

## Contributing

Contributions are welcome! If you have a script that you think would be a valuable addition to this repository, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Add your script in the `scripts` directory.
4. Commit your changes:
    ```bash
    git commit -m 'Add new script: your-script-name'
    ```
5. Push to your branch:
    ```bash
    git push origin feature/your-feature-name
    ```
6. Open a pull request on GitHub.

Please ensure your scripts are well-documented and include comments explaining the functionality.

---

Thank you for using the Utility Scripts repository! If you have any questions or suggestions, feel free to open an issue or contact the repository owner.

Happy scripting!

# GitHub Security Advisories API Script

This script interacts with the GitHub Security Advisories API, allowing you to retrieve and filter security advisories based on various criteria.

## Prerequisites

- **GitHub Token**: A valid GitHub token is required for authentication. Replace `<YOUR-TOKEN>` in the script with your token.
- **jq**: Ensure `jq` is installed for JSON processing. Install it using:
  ```bash
  sudo apt-get install jq   # For Debian/Ubuntu
  brew install jq           # For macOS
  ```

## Features

- Filter advisories by specific parameters such as CVE ID, ecosystem, severity, etc.
- Search advisories for specific keywords.
- Paginate results and customize sorting.
- Update the GitHub token dynamically.

## Usage

### Basic Command

Run the script with desired options:
```bash
./github_api_script.sh [OPTIONS]
```

### Available Options

| Option                  | Description                                                         | Example                                 |
|-------------------------|---------------------------------------------------------------------|-----------------------------------------|
| `--ghsa_id=<GHSA-ID>`   | Filter advisories by GHSA ID                                        | `--ghsa_id=GHSA-xyz1-1234`              |
| `--type=<type>`         | Filter by type (reviewed, malware, unreviewed)                     | `--type=reviewed`                       |
| `--cve_id=<CVE-ID>`     | Filter advisories by CVE ID                                         | `--cve_id=CVE-2023-12345`               |
| `--ecosystem=<ecosystem>`| Filter advisories by ecosystem (npm, pip, etc.)                   | `--ecosystem=npm`                       |
| `--severity=<severity>` | Filter advisories by severity (low, medium, high, critical)        | `--severity=critical`                   |
| `--cwes=<cwe-list>`     | Filter by CWEs (example: 79,284)                                    | `--cwes=79,284`                         |
| `--query=<keyword>`     | Search advisories containing a specific keyword                    | `--query=fortinet`                      |
| `--per_page=<integer>`  | Number of results per page (max 100)                               | `--per_page=50`                         |
| `--sort=<property>`     | Sort results by property (published, updated, etc.)                | `--sort=updated`                        |
| `--add-token=<TOKEN>`   | Update or set a new GitHub token                                   | `--add-token=your_new_token`            |

## Examples

### 1. Search for advisories containing "Fortinet":
```bash
./github_api_script.sh --severity=critical --query=fortinet --published=2025-01-01..2025-12-31 --per_page=100
```

### 2. Filter by CVE ID:
```bash
./github_api_script.sh --cve_id=CVE-2023-12345
```

### 3. Filter by ecosystem (e.g., npm):
```bash
./github_api_script.sh --ecosystem=npm
```

### 4. Retrieve critical advisories:
```bash
./github_api_script.sh --severity=critical
```

### 5. Paginate results with 50 advisories per page:
```bash
./github_api_script.sh --per_page=50
```

### 6. Sort advisories by the latest updates:
```bash
./github_api_script.sh --sort=updated
```

### 7. Update GitHub token dynamically:
```bash
./github_api_script.sh --add-token=new_token_value
```

## Output

Results are displayed in JSON format, processed with `jq` for better readability. If `jq` is not installed, raw JSON will be shown.

## Troubleshooting

- **Invalid Token**: Ensure your GitHub token is valid and has sufficient permissions.
- **Unexpected JSON Structure**: If filtering fails, review the API response structure.

## License

This project is licensed under the MIT License.


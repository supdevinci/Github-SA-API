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

| Option                      | Description                                                 | Example                              |                       |
| --------------------------- | ----------------------------------------------------------- | ------------------------------------ | --------------------- |
| `--ghsa_id=<GHSA-ID>`       | Filter advisories by GHSA ID                                | `--ghsa_id=GHSA-xyz1-1234`           |                       |
| `--type=<type>`             | Filter by type (reviewed, malware, unreviewed)              | `--type=reviewed`                    |                       |
| `--cve_id=<CVE-ID>`         | Filter advisories by CVE ID                                 | `--cve_id=CVE-2023-12345`            |                       |
| `--ecosystem=<ecosystem>`   | Filter advisories by ecosystem (npm, pip, etc.)             | `--ecosystem=npm`                    |                       |
| `--severity=<severity>`     | Filter advisories by severity (low, medium, high, critical) | `--severity=critical`                |                       |
| `--cwes=<cwe-list>`         | Filter by CWEs (example: 79,284)                            | `--cwes=79,284`                      |                       |
| \`--is\_withdrawn=\<true    | false>\`                                                    | Include only withdrawn advisories    | `--is_withdrawn=true` |
| `--affects=<package-list>`  | Filter advisories by affected packages                      | `--affects=package1,package2@1.0.0`  |                       |
| `--published=<date-range>`  | Filter advisories by publication date range                 | `--published=2023-01-01..2023-12-31` |                       |
| `--updated=<date-range>`    | Filter advisories by update date range                      | `--updated=2023-06-01..2023-12-31`   |                       |
| `--modified=<date-range>`   | Filter advisories by modification date range                | `--modified=2023-01-01..2023-12-31`  |                       |
| `--epss_percentage=<value>` | Filter advisories by EPSS percentage                        | `--epss_percentage=0.5..1.0`         |                       |
| `--epss_percentile=<value>` | Filter advisories by EPSS percentile                        | `--epss_percentile=90..100`          |                       |
| `--before=<cursor>`         | Paginate advisories before a specific cursor                | `--before=cursor12345`               |                       |
| `--after=<cursor>`          | Paginate advisories after a specific cursor                 | `--after=cursor12345`                |                       |
| \`--direction=\<asc         | desc>\`                                                     | Sort order (default: desc)           | `--direction=asc`     |
| `--per_page=<integer>`      | Number of results per page (max 100)                        | `--per_page=50`                      |                       |
| `--sort=<property>`         | Sort results by property (published, updated, etc.)         | `--sort=updated`                     |                       |
| `--add-token=<TOKEN>`       | Update or set a new GitHub token                            | `--add-token=your_new_token`         |                       |
| `--query=<keyword>`         | Search advisories containing a specific keyword             | `--query=fortinet`                   |                       |

## Examples

### 1. Search for advisories containing "Fortinet":

```bash
./github_api_script.sh  --severity=critical --query=fortinet --published=2025-01-01..2025-12-31 --per_page=100 
```

### 2. Filter by GHSA ID:

```bash
./github_api_script.sh --ghsa_id=GHSA-xyz1-1234
```

### 3. Filter by CVE ID:

```bash
./github_api_script.sh --cve_id=CVE-2023-12345
```

### 4. Filter by ecosystem (e.g., npm):

```bash
./github_api_script.sh --ecosystem=npm
```

### 5. Retrieve critical advisories:

```bash
./github_api_script.sh --severity=critical
```

### 6. Filter advisories by CWEs:

```bash
./github_api_script.sh --cwes=79,284
```

### 7. Include only withdrawn advisories:

```bash
./github_api_script.sh --is_withdrawn=true
```

### 8. Filter advisories affecting specific packages:

```bash
./github_api_script.sh --affects=package1,package2@1.0.0
```

### 9. Filter advisories published in 2023:

```bash
./github_api_script.sh --published=2023-01-01..2023-12-31
```

### 10. Filter advisories updated in the second half of 2023:

```bash
./github_api_script.sh --updated=2023-06-01..2023-12-31
```

### 11. Filter advisories modified in 2023:

```bash
./github_api_script.sh --modified=2023-01-01..2023-12-31
```

### 12. Filter advisories with an EPSS percentage of 50-100%:

```bash
./github_api_script.sh --epss_percentage=0.5..1.0
```

### 13. Filter advisories in the top 10% EPSS percentile:

```bash
./github_api_script.sh --epss_percentile=90..100
```

### 14. Paginate results before a specific cursor:

```bash
./github_api_script.sh --before=cursor12345
```

### 15. Paginate results after a specific cursor:

```bash
./github_api_script.sh --after=cursor12345
```

### 16. Sort advisories by the latest updates:

```bash
./github_api_script.sh --sort=updated
```

### 17. Retrieve advisories sorted in ascending order:

```bash
./github_api_script.sh --direction=asc
```

### 18. Paginate results with 50 advisories per page:

```bash
./github_api_script.sh --per_page=50
```

### 19. Update GitHub token dynamically:

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


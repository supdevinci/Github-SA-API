# GitHub Security Advisories API Script

This Bash script interacts with the GitHub Security Advisories API, allowing you to fetch and filter security advisory data based on various criteria.

## Prerequisites

- A valid GitHub token (to be set in the script or added dynamically using `--add-token`).
- `jq` installed for JSON formatting:
  ```bash
  sudo apt-get install jq  # On Debian/Ubuntu
  brew install jq          # On macOS
  ```

## Usage

Run the script with specific options to filter the advisories.

### Basic Command
```bash
./github_api_script.sh [OPTIONS]
```

### Available Options

| Option               | Description                                                                 | Example                                  |
|----------------------|-----------------------------------------------------------------------------|------------------------------------------|
| `--ghsa_id`          | Filter by a specific GHSA ID.                                              | `--ghsa_id=GHSA-abc1-xyz2-1234`          |
| `--type`             | Filter advisories by type (reviewed, malware, unreviewed).                 | `--type=reviewed`                        |
| `--cve_id`           | Filter by CVE ID.                                                         | `--cve_id=CVE-2023-12345`                |
| `--ecosystem`        | Filter by ecosystem (npm, pip, etc.).                                      | `--ecosystem=npm`                        |
| `--severity`         | Filter by severity (low, medium, high, critical).                         | `--severity=critical`                    |
| `--cwes`             | Filter by Common Weakness Enumerations (CWEs).                            | `--cwes=79,284`                          |
| `--is_withdrawn`     | Include only withdrawn advisories.                                         | `--is_withdrawn=true`                    |
| `--affects`          | Filter by affected packages.                                              | `--affects=package1,package2@1.0.0`      |
| `--published`        | Filter by publication date range.                                         | `--published=2023-01-01..2023-12-31`     |
| `--updated`          | Filter by update date range.                                              | `--updated=2023-06-01..2023-12-31`       |
| `--modified`         | Filter by modification date range.                                        | `--modified=2023-01-01..2023-12-31`      |
| `--epss_percentage`  | Filter by EPSS percentage score range.                                    | `--epss_percentage=0.5..1.0`             |
| `--epss_percentile`  | Filter by EPSS percentile score range.                                    | `--epss_percentile=90..100`              |
| `--before`           | Pagination before a specific cursor.                                      | `--before=cursor12345`                   |
| `--after`            | Pagination after a specific cursor.                                       | `--after=cursor12345`                    |
| `--direction`        | Sort direction (asc or desc). Default: desc.                              | `--direction=asc`                        |
| `--per_page`         | Number of results per page (max: 100). Default: 30.                       | `--per_page=50`                          |
| `--sort`             | Property to sort results by (published, updated, etc.).                  | `--sort=updated`                         |
| `--add-token`        | Add or update the GitHub token in the script.                             | `--add-token=your_github_token`          |

### Examples

#### Example 1: Fetch advisories for a specific CVE ID
```bash
./github_api_script.sh --cve_id=CVE-2023-12345
```

#### Example 2: Fetch advisories for ecosystem `npm` with critical severity
```bash
./github_api_script.sh --ecosystem=npm --severity=critical
```

#### Example 3: Fetch advisories published in 2023
```bash
./github_api_script.sh --published=2023-01-01..2023-12-31
```

#### Example 4: Update the GitHub token
```bash
./github_api_script.sh --add-token=your_new_token
```

#### Example 5: Fetch advisories sorted by update date in ascending order
```bash
./github_api_script.sh --sort=updated --direction=asc
```

#### Example 6: Fetch advisories by GHSA ID
```bash
./github_api_script.sh --ghsa_id=GHSA-xyz1-abc2-7890
```

#### Example 7: Fetch advisories affecting specific packages
```bash
./github_api_script.sh --affects=package1,package2@1.0.0
```

#### Example 8: Fetch advisories with specific CWEs
```bash
./github_api_script.sh --cwes=79,284
```

#### Example 9: Fetch advisories updated in a specific date range
```bash
./github_api_script.sh --updated=2023-01-01..2023-06-30
```

#### Example 10: Fetch advisories with EPSS percentile above 90
```bash
./github_api_script.sh --epss_percentile=90..100
```

## Output

The results are displayed in JSON format using `jq`. If `jq` is not installed, the raw JSON response is displayed.

## Notes

- Make sure your GitHub token has appropriate permissions to access the API.
- The token can be added dynamically using the `--add-token` option.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.


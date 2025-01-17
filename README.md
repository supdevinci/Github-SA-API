# Security Advisories API Script

This script interacts with the GitHub Security Advisories API to fetch and filter advisories based on various criteria. It supports pagination and can efficiently retrieve data while applying multiple filters. The script also supports updating the GitHub token directly.

## Requirements

- **bash** (Linux/MacOS)
- **jq** (for JSON parsing)
- A valid GitHub Personal Access Token (PAT) with appropriate permissions

## Usage

```bash
./github_api_script.sh [OPTIONS]
```

### Options

| Option                       | Description                                                                                 | Example                                                                                   |
|------------------------------|---------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| `--add-token=<GITHUB_TOKEN>` | Update the GitHub Personal Access Token directly in the script.                            | `--add-token=ghp_XXXXXX`                                                                 |
| `--query=<keyword>`          | Filter advisories containing a specific keyword in the summary or description.             | `--query=fortinet`                                                                        |
| `--ghsa_id=<GHSA-ID>`        | Filter advisories by their GHSA-ID.                                                        | `--ghsa_id=GHSA-wfv4-v3vj-4vq5`                                                          |
| `--type=<type>`              | Filter advisories by type (`reviewed`, `malware`, `unreviewed`).                            | `--type=reviewed`                                                                         |
| `--cve_id=<CVE-ID>`          | Filter advisories by their CVE-ID.                                                         | `--cve_id=CVE-2023-51475`                                                                |
| `--ecosystem=<ecosystem>`    | Filter advisories by ecosystem (e.g., `npm`, `pip`).                                       | `--ecosystem=npm`                                                                        |
| `--severity=<severity>`      | Filter advisories by severity (`low`, `medium`, `high`, `critical`).                       | `--severity=critical`                                                                     |
| `--cwes=<cwe-list>`          | Filter advisories by CWE identifiers (e.g., `79,284`).                                     | `--cwes=79,89`                                                                           |
| `--is_withdrawn=<true\|false>`| Include or exclude withdrawn advisories.                                                   | `--is_withdrawn=true`                                                                     |
| `--affects=<package-list>`   | Filter advisories by affected packages.                                                    | `--affects=@angular/core`                                                                |
| `--published=<date-range>`   | Filter advisories by their publication date (e.g., `YYYY-MM-DD..YYYY-MM-DD`).              | `--published=2023-01-01..2023-12-31`                                                     |
| `--updated=<date-range>`     | Filter advisories by their update date.                                                    | `--updated=2023-01-01..2023-12-31`                                                       |
| `--modified=<date-range>`    | Filter advisories by their modification date.                                               | `--modified=2023-01-01..2023-12-31`                                                      |
| `--epss_percentage=<value>`  | Filter advisories by EPSS percentage.                                                      | `--epss_percentage=0.5`                                                                  |
| `--epss_percentile=<value>`  | Filter advisories by EPSS percentile.                                                      | `--epss_percentile=90`                                                                   |
| `--direction=<asc|desc>`     | Sort the results in ascending or descending order. Default is `desc`.                      | `--direction=asc`                                                                        |
| `--sort=<property>`          | Sort results by a property (`published`, `updated`, etc.).                                 | `--sort=published`                                                                       |
| `--last=<N>`                 | Show only the last N results. Default is 10.                                               | `--last=5`                                                                               |

### Example Commands

#### Retrieve Critical Fortinet Advisories Published in 2025
```bash
./github_api_script.sh --severity=critical --query=fortinet --published=2025-01-01..2025-12-31
```

#### Retrieve the Last 5 Advisories with CVE-ID `CVE-2023-51475`
```bash
./github_api_script.sh --cve_id=CVE-2023-51475 --last=5
```

#### Retrieve Advisories for Ecosystem `npm` Updated in 2023
```bash
./github_api_script.sh --ecosystem=npm --updated=2023-01-01..2023-12-31
```

#### Retrieve Withdrawn Advisories
```bash
./github_api_script.sh --is_withdrawn=true
```

#### Retrieve Advisories Sorted by Update Date in Ascending Order
```bash
./github_api_script.sh --sort=updated --direction=asc
```

#### Add or Update the GitHub Personal Access Token
```bash
./github_api_script.sh --add-token=ghp_NEW_PERSONAL_ACCESS_TOKEN
```

## Notes

- Ensure `jq` is installed on your system to parse JSON outputs.
- Replace `<YOUR-TOKEN>` with your actual GitHub Personal Access Token for authorization.
- The script uses pagination and stops as soon as the desired number of results is reached (if specified via `--last`).

## Debugging

If you encounter issues:
- Use the `--last=10` option to limit the results and reduce the processing time.
- Run with `bash -x` for verbose output to debug any issues.

Feel free to modify or extend this script to suit your specific requirements.


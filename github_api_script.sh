#!/bin/bash

# Script to interact with the GitHub Security Advisories API
# Replace <YOUR-TOKEN> with your GitHub authentication token

GITHUB_TOKEN="<YOUR-TOKEN>"
BASE_URL="https://api.github.com/advisories"

# Function to display usage instructions
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options :"
  echo "  --ghsa_id=<GHSA-ID>             Filter by GHSA-ID"
  echo "  --type=<type>                  Filter by type (reviewed, malware, unreviewed)"
  echo "  --cve_id=<CVE-ID>             Filter by CVE-ID"
  echo "  --ecosystem=<ecosystem>       Filter by ecosystem (npm, pip, etc.)"
  echo "  --severity=<severity>         Filter by severity (low, medium, high, critical)"
  echo "  --cwes=<cwe-list>             Filter by CWEs (example: 79,284)"
  echo "  --is_withdrawn=<true|false>   Include only withdrawn advisories"
  echo "  --affects=<package-list>      Filter by affected packages"
  echo "  --published=<date-range>      Filter by publication date"
  echo "  --updated=<date-range>        Filter by update date"
  echo "  --modified=<date-range>       Filter by modification date"
  echo "  --epss_percentage=<value>     Filter by EPSS percentage"
  echo "  --epss_percentile=<value>     Filter by EPSS percentile"
  echo "  --before=<cursor>             Pagination before the cursor"
  echo "  --after=<cursor>              Pagination after the cursor"
  echo "  --direction=<asc|desc>        Sort order (default: desc)"
  echo "  --per_page=<integer>          Results per page (max 100)"
  echo "  --sort=<property>             Property to sort by (published, updated, etc.)"
  echo "  --add-token=<GITHUB_TOKEN>    Add or update the GitHub token"
  echo "  --query=<keyword>             Filter advisories containing a specific keyword (e.g., Fortinet, VMware)"
}

# Initialize parameters
PARAMS="&direction=desc"
QUERY_KEYWORD=""

# Parse arguments
for arg in "$@"; do
  case $arg in
    --ghsa_id=*)
      ghsa_id="${arg#*=}"
      PARAMS+="&ghsa_id=$ghsa_id"
      ;;
    --type=*)
      type="${arg#*=}"
      PARAMS+="&type=$type"
      ;;
    --cve_id=*)
      cve_id="${arg#*=}"
      PARAMS+="&cve_id=$cve_id"
      ;;
    --ecosystem=*)
      ecosystem="${arg#*=}"
      PARAMS+="&ecosystem=$ecosystem"
      ;;
    --severity=*)
      severity="${arg#*=}"
      PARAMS+="&severity=$severity"
      ;;
    --cwes=*)
      cwes="${arg#*=}"
      PARAMS+="&cwes=$cwes"
      ;;
    --is_withdrawn=*)
      is_withdrawn="${arg#*=}"
      PARAMS+="&is_withdrawn=$is_withdrawn"
      ;;
    --affects=*)
      affects="${arg#*=}"
      PARAMS+="&affects=$affects"
      ;;
    --published=*)
      published="${arg#*=}"
      PARAMS+="&published=$published"
      ;;
    --updated=*)
      updated="${arg#*=}"
      PARAMS+="&updated=$updated"
      ;;
    --modified=*)
      modified="${arg#*=}"
      PARAMS+="&modified=$modified"
      ;;
    --epss_percentage=*)
      epss_percentage="${arg#*=}"
      PARAMS+="&epss_percentage=$epss_percentage"
      ;;
    --epss_percentile=*)
      epss_percentile="${arg#*=}"
      PARAMS+="&epss_percentile=$epss_percentile"
      ;;
    --before=*)
      before="${arg#*=}"
      PARAMS+="&before=$before"
      ;;
    --after=*)
      after="${arg#*=}"
      PARAMS+="&after=$after"
      ;;
    --direction=*)
      direction="${arg#*=}"
      PARAMS="${PARAMS//&direction=desc/}&direction=$direction"
      ;;
    --per_page=*)
      per_page="${arg#*=}"
      PARAMS+="&per_page=$per_page"
      ;;
    --sort=*)
      sort="${arg#*=}"
      PARAMS+="&sort=$sort"
      ;;
    --add-token=*)
      new_token="${arg#*=}"
      sed -i "s/^GITHUB_TOKEN=.*/GITHUB_TOKEN=\"$new_token\"/" "$0"
      echo "GitHub token successfully updated."
      exit 0
      ;;
    --query=*)
      QUERY_KEYWORD="${arg#*=}"
      ;;
    *)
      echo "Unknown option: $arg"
      usage
      exit 1
      ;;
  esac
  shift
done

# Build the URL
FULL_URL="$BASE_URL?${PARAMS#&}"

# Execute the request
response=$(curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$FULL_URL")

# Filter results by keyword if specified
if [ $? -eq 0 ]; then
  if [ -n "$QUERY_KEYWORD" ]; then
    echo "Filtered results for keyword: $QUERY_KEYWORD"
    echo "$response" | jq --arg keyword "$QUERY_KEYWORD" 'if type == "array" then .[] | select(.summary | test($keyword; "i")) else "Error: Unexpected JSON structure" end'
  else
    echo "Query results:"
    echo "$response" | jq
  fi
else
  echo "An error occurred during the request."
  exit 1
fi

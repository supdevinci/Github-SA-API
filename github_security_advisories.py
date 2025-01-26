import argparse
import requests
import json
import re
import sys

GITHUB_TOKEN = "xxx_XXXXXXXXXXXXXX"
BASE_URL = "https://api.github.com/advisories"

def usage():
    print("Usage: python script.py [OPTIONS]")
    print("Options:")
    print("  --query=<keyword>               Filter advisories containing a specific keyword (e.g., Fortinet, VMware)")
    print("  --ghsa_id=<GHSA-ID>             Filter by GHSA-ID")
    print("  --type=<type>                   Filter by type (reviewed, malware, unreviewed)")
    print("  --cve_id=<CVE-ID>               Filter by CVE-ID")
    print("  --ecosystem=<ecosystem>         Filter by ecosystem (npm, pip, etc.)")
    print("  --severity=<severity>           Filter by severity (low, medium, high, critical)")
    print("  --cwes=<cwe-list>               Filter by CWEs (example: 79,284)")
    print("  --is_withdrawn=<true|false>     Include only withdrawn advisories")
    print("  --affects=<package-list>        Filter by affected packages")
    print("  --published=<date-range>        Filter by publication date (e.g., 2023-01-01..2023-12-31)")
    print("  --updated=<date-range>          Filter by update date")
    print("  --modified=<date-range>         Filter by modification date")
    print("  --epss_percentage=<value>       Filter by EPSS percentage")
    print("  --epss_percentile=<value>       Filter by EPSS percentile")
    print("  --direction=<asc|desc>          Sort order (default: desc)")
    print("  --sort=<property>               Property to sort by (published, updated, etc.)")
    print("  --last=<N>                      Show only the last N results (default: 10)")
    print("  --add-token=<GITHUB_TOKEN>      Add or update the GitHub token")

def fetch_advisories(url):
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    response = requests.get(url, headers=headers)
    return response

def update_token(new_token):
    with open(__file__, 'r') as file:
        content = file.read()
    
    updated_content = re.sub(r'GITHUB_TOKEN = ".*"', f'GITHUB_TOKEN = "{new_token}"', content)
    
    with open(__file__, 'w') as file:
        file.write(updated_content)
    
    print("GitHub token successfully updated.")
    sys.exit(0)

def main():
    parser = argparse.ArgumentParser(description="Interact with the GitHub Security Advisories API")
    parser.add_argument("--query", help="Filter advisories containing a specific keyword")
    parser.add_argument("--ghsa_id", help="Filter by GHSA-ID")
    parser.add_argument("--type", help="Filter by type (reviewed, malware, unreviewed)")
    parser.add_argument("--cve_id", help="Filter by CVE-ID")
    parser.add_argument("--ecosystem", help="Filter by ecosystem (npm, pip, etc.)")
    parser.add_argument("--severity", help="Filter by severity (low, medium, high, critical)")
    parser.add_argument("--cwes", help="Filter by CWEs (example: 79,284)")
    parser.add_argument("--is_withdrawn", help="Include only withdrawn advisories")
    parser.add_argument("--affects", help="Filter by affected packages")
    parser.add_argument("--published", help="Filter by publication date")
    parser.add_argument("--updated", help="Filter by update date")
    parser.add_argument("--modified", help="Filter by modification date")
    parser.add_argument("--epss_percentage", help="Filter by EPSS percentage")
    parser.add_argument("--epss_percentile", help="Filter by EPSS percentile")
    parser.add_argument("--direction", default="desc", help="Sort order (default: desc)")
    parser.add_argument("--sort", help="Property to sort by")
    parser.add_argument("--last", type=int, default=10, help="Show only the last N results (default: 10)")
    parser.add_argument("--add-token", help="Add or update the GitHub token")

    args = parser.parse_args()

    if args.add_token:
        update_token(args.add_token)

    params = {
        "direction": args.direction,
        "per_page": 100
    }

    for arg, value in vars(args).items():
        if value and arg not in ["query", "last", "add_token"]:
            params[arg] = value

    url = f"{BASE_URL}?{requests.compat.urlencode(params)}"
    collected_results = []
    results_count = 0

    while url and results_count < args.last:
        response = fetch_advisories(url)
        response.raise_for_status()
        
        data = response.json()
        
        if args.query:
            matching_results = [
                item for item in data
                if args.query.lower() in item.get("summary", "").lower() or
                   args.query.lower() in item.get("description", "").lower()
            ]
        else:
            matching_results = data

        collected_results.extend(matching_results)
        results_count = len(collected_results)

        if results_count >= args.last:
            break

        url = response.links.get("next", {}).get("url")

    if results_count == 0:
        print("No results found.")
    else:
        print(json.dumps(collected_results[:args.last], indent=2))

if __name__ == "__main__":
    main()

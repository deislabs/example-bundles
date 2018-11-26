#!/bin/sh

set -eo pipefail

function test_functional() {
  bundle="${1}"
  bundleFile="${bundle}/bundle.cnab"
  insecure=""

  if [[ -n "${INSECURE}" ]]; then
    echo "Duffle is running in insecure mode..."
    bundleFile="${bundle}/bundle.json"
    insecure="--insecure"
  fi

  # run tests
  echo "Generating creds for the ${bundle} bundle..."
  duffle creds generate "${bundle}-test-creds" -f "${bundleFile}" -q ${insecure}
  echo "Installing the ${bundle} bundle..."
  duffle install -d debug "${bundle}-test" -f "${bundleFile}" -c "${bundle}-test-creds" ${insecure}
}

function main() {
  # if BUNDLE in env non-null, run only on this bundle
  if [[ -n "${BUNDLE}" ]]; then
    test_functional "${BUNDLE}"
  else
    # run against all bundles
    for dir in $(ls -1); do
      if [[ -e "${dir}/bundle.json" ]]; then
        test_functional "${dir}"
      fi
    done
  fi
}

main
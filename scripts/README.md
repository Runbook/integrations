Scripts
============

This directory contains simple scripts that can be used to integrate with CloudRoutes and the various monitors and reactions.

## cr-api.sh | CloudRoutes API Shell Script

This script can be used to call the CloudRoutes API from command line or any tool that can execute shell scripts.

**Usage:**

    # ./cr-api.sh -k <check_key> -u <url> -a healthy|failed|status

**Example:**

    # ./cr-api.sh -u https://dash.cloudrout.es/api/cr-api/unique-url -k somesupersecretkey -a healthy
    Sending Request to: https://dash.cloudrout.es/api/cr-api/unique-url
    -------------------------
    Results: {"result": "success"}

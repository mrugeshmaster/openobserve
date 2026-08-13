#!/bin/bash
# Start OpenObserve. Wired in as targetSetupCommand.
# Requires the release-ci binary pre-built and staged at ./release-ci-binary/openobserve
# by .github/workflows/skyramp-testbot.yml.
set -e

# ---- Start OpenObserve ----
# No fallback to the published Docker image, on purpose. That image is the latest
# RELEASE, so it carries none of the PR's changes -- and since the Vue bundle is
# compiled into the binary via rust-embed, none of the PR's UI either. The bot
# would then be scored against an app missing the very feature it was asked to
# test, with nothing in the run announcing the substitution. A missing binary is
# a broken build, not a reason to start a different application.
if [ ! -f "./release-ci-binary/openobserve" ]; then
  echo "FATAL: no binary at ./release-ci-binary/openobserve." >&2
  echo "The 'Build binary and frontend' and 'Stage binary for SUT startup' steps must run first." >&2
  exit 1
fi
chmod +x ./release-ci-binary/openobserve

export ZO_ROOT_USER_EMAIL="${ZO_ROOT_USER_EMAIL:-root@example.com}"
export ZO_ROOT_USER_PASSWORD="${ZO_ROOT_USER_PASSWORD:-Complexpass#123}"
export ZO_QUICK_MODE_ENABLED="${ZO_QUICK_MODE_ENABLED:-false}"
export ZO_QUICK_MODE_NUM_FIELDS="${ZO_QUICK_MODE_NUM_FIELDS:-100}"
export ZO_QUICK_MODE_STRATEGY="${ZO_QUICK_MODE_STRATEGY:-first}"
export ZO_ALLOW_USER_DEFINED_SCHEMAS="${ZO_ALLOW_USER_DEFINED_SCHEMAS:-true}"
export ZO_INGEST_ALLOWED_UPTO="${ZO_INGEST_ALLOWED_UPTO:-5}"
export ZO_FEATURE_QUERY_EXCLUDE_ALL="${ZO_FEATURE_QUERY_EXCLUDE_ALL:-false}"
export ZO_USAGE_BATCH_SIZE="${ZO_USAGE_BATCH_SIZE:-200}"
export ZO_USAGE_PUBLISH_INTERVAL="${ZO_USAGE_PUBLISH_INTERVAL:-2}"
export ZO_USAGE_REPORTING_ENABLED="${ZO_USAGE_REPORTING_ENABLED:-true}"
export ZO_MIN_AUTO_REFRESH_INTERVAL="${ZO_MIN_AUTO_REFRESH_INTERVAL:-5}"
export ZO_STREAMING_ENABLED="${ZO_STREAMING_ENABLED:-true}"
export ZO_COLS_PER_RECORD_LIMIT="${ZO_COLS_PER_RECORD_LIMIT:-80000}"
export ZO_SMTP_ENABLED="${ZO_SMTP_ENABLED:-true}"
export ZO_FORMAT_STREAM_NAME_TO_LOWERCASE="${ZO_FORMAT_STREAM_NAME_TO_LOWERCASE:-false}"
export ZO_CREATE_ORG_THROUGH_INGESTION="${ZO_CREATE_ORG_THROUGH_INGESTION:-true}"
export ZO_UTF8_VIEW_ENABLED="${ZO_UTF8_VIEW_ENABLED:-false}"
export ZO_ENABLE_CROSS_LINKING="${ZO_ENABLE_CROSS_LINKING:-true}"
export ZO_TIMECHART_ENABLED="${ZO_TIMECHART_ENABLED:-true}"
export ZO_SSRF_ALLOW_LOOPBACK="${ZO_SSRF_ALLOW_LOOPBACK:-true}"

nohup ./release-ci-binary/openobserve > /tmp/o2.log 2>&1 &
echo $! > /tmp/o2.pid
echo "OpenObserve started with PID $(cat /tmp/o2.pid)"

echo "Setup complete."

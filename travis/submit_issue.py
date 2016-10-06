#!/usr/bin/env python2.7

import logging, sys, json
from github3 import GitHub

logging.basicConfig(level=logging.DEBUG)
logging.getLogger('github3').setLevel(logging.WARNING)
log = logging.getLogger(__name__)

# Load json from Rspec run from stdin
test_runs = json.loads(sys.stdin.read())
# As Rspec should be run in --fail-fast mode, the last 
# run test should be the one that failed
failed_test = test_runs['examples'][-1]

status = failed_test['status']
if status != 'failed':
	log.error('Last test did not fail!')
	log.error(failed_test)
	sys.exit(1)

title = failed_test['full_description']
body = failed_test['exception']['message']
log.debug("FAiled test: {test}".format(title))

# Create Github issue
gh_username = 'swt2public'
gh_password = 'wnjxeUn6pQpcnR4V'

log.debug("Logging in as {user}".format(user=gh_username))
github = GitHub(gh_username, gh_password)
log.debug("Ratelimit remaining: {rate}".format(rate=github.ratelimit_remaining))

# create_issue(owner, repository, title, body=None, assignee=None, milestone=None, labels=[])
# TRAVIS_REPO_SLUG (owner_name/repo_name)
# https://docs.travis-ci.com/user/environment-variables/
owner, repo = os.environ.get('TRAVIS_REPO_SLUG').split('/')
log.debug("Repo: {owner}/{repo}".format(owner=owner, repo=repo))

log.debug("Attempting to create issue...")
resp = github.create_issue(owner, repo, title, body, owner)
log.debug("Created ticket: {resp}".format(resp=resp))
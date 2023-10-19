//
//  Repositories.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/19/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//
//
// https://api.github.com/orgs/ORG/repos
//[
//  {
//	"id": 374552687,
//	"node_id": "MDEwOlJlcG9zaXRvcnkzNzQ1NTI2ODc=",
//	"name": "AutoBuy",
//	"full_name": "zhang86036055/AutoBuy",
//	"private": false,
//	"owner": {
//	  "login": "zhang86036055",
//	  "id": 77553874,
//	  "node_id": "MDQ6VXNlcjc3NTUzODc0",
//	  "avatar_url": "https://avatars.githubusercontent.com/u/77553874?v=4",
//	  "gravatar_id": "",
//	  "url": "https://api.github.com/users/zhang86036055",
//	  "html_url": "https://github.com/zhang86036055",
//	  "followers_url": "https://api.github.com/users/zhang86036055/followers",
//	  "following_url": "https://api.github.com/users/zhang86036055/following{/other_user}",
//	  "gists_url": "https://api.github.com/users/zhang86036055/gists{/gist_id}",
//	  "starred_url": "https://api.github.com/users/zhang86036055/starred{/owner}{/repo}",
//	  "subscriptions_url": "https://api.github.com/users/zhang86036055/subscriptions",
//	  "organizations_url": "https://api.github.com/users/zhang86036055/orgs",
//	  "repos_url": "https://api.github.com/users/zhang86036055/repos",
//	  "events_url": "https://api.github.com/users/zhang86036055/events{/privacy}",
//	  "received_events_url": "https://api.github.com/users/zhang86036055/received_events",
//	  "type": "User",
//	  "site_admin": false
//	},
//	"html_url": "https://github.com/zhang86036055/AutoBuy",
//	"description": null,
//	"fork": false,
//	"url": "https://api.github.com/repos/zhang86036055/AutoBuy",
//	"forks_url": "https://api.github.com/repos/zhang86036055/AutoBuy/forks",
//	"keys_url": "https://api.github.com/repos/zhang86036055/AutoBuy/keys{/key_id}",
//	"collaborators_url": "https://api.github.com/repos/zhang86036055/AutoBuy/collaborators{/collaborator}",
//	"teams_url": "https://api.github.com/repos/zhang86036055/AutoBuy/teams",
//	"hooks_url": "https://api.github.com/repos/zhang86036055/AutoBuy/hooks",
//	"issue_events_url": "https://api.github.com/repos/zhang86036055/AutoBuy/issues/events{/number}",
//	"events_url": "https://api.github.com/repos/zhang86036055/AutoBuy/events",
//	"assignees_url": "https://api.github.com/repos/zhang86036055/AutoBuy/assignees{/user}",
//	"branches_url": "https://api.github.com/repos/zhang86036055/AutoBuy/branches{/branch}",
//	"tags_url": "https://api.github.com/repos/zhang86036055/AutoBuy/tags",
//	"blobs_url": "https://api.github.com/repos/zhang86036055/AutoBuy/git/blobs{/sha}",
//	"git_tags_url": "https://api.github.com/repos/zhang86036055/AutoBuy/git/tags{/sha}",
//	"git_refs_url": "https://api.github.com/repos/zhang86036055/AutoBuy/git/refs{/sha}",
//	"trees_url": "https://api.github.com/repos/zhang86036055/AutoBuy/git/trees{/sha}",
//	"statuses_url": "https://api.github.com/repos/zhang86036055/AutoBuy/statuses/{sha}",
//	"languages_url": "https://api.github.com/repos/zhang86036055/AutoBuy/languages",
//	"stargazers_url": "https://api.github.com/repos/zhang86036055/AutoBuy/stargazers",
//	"contributors_url": "https://api.github.com/repos/zhang86036055/AutoBuy/contributors",
//	"subscribers_url": "https://api.github.com/repos/zhang86036055/AutoBuy/subscribers",
//	"subscription_url": "https://api.github.com/repos/zhang86036055/AutoBuy/subscription",
//	"commits_url": "https://api.github.com/repos/zhang86036055/AutoBuy/commits{/sha}",
//	"git_commits_url": "https://api.github.com/repos/zhang86036055/AutoBuy/git/commits{/sha}",
//	"comments_url": "https://api.github.com/repos/zhang86036055/AutoBuy/comments{/number}",
//	"issue_comment_url": "https://api.github.com/repos/zhang86036055/AutoBuy/issues/comments{/number}",
//	"contents_url": "https://api.github.com/repos/zhang86036055/AutoBuy/contents/{+path}",
//	"compare_url": "https://api.github.com/repos/zhang86036055/AutoBuy/compare/{base}...{head}",
//	"merges_url": "https://api.github.com/repos/zhang86036055/AutoBuy/merges",
//	"archive_url": "https://api.github.com/repos/zhang86036055/AutoBuy/{archive_format}{/ref}",
//	"downloads_url": "https://api.github.com/repos/zhang86036055/AutoBuy/downloads",
//	"issues_url": "https://api.github.com/repos/zhang86036055/AutoBuy/issues{/number}",
//	"pulls_url": "https://api.github.com/repos/zhang86036055/AutoBuy/pulls{/number}",
//	"milestones_url": "https://api.github.com/repos/zhang86036055/AutoBuy/milestones{/number}",
//	"notifications_url": "https://api.github.com/repos/zhang86036055/AutoBuy/notifications{?since,all,participating}",
//	"labels_url": "https://api.github.com/repos/zhang86036055/AutoBuy/labels{/name}",
//	"releases_url": "https://api.github.com/repos/zhang86036055/AutoBuy/releases{/id}",
//	"deployments_url": "https://api.github.com/repos/zhang86036055/AutoBuy/deployments",
//	"created_at": "2021-06-07T06:03:35Z",
//	"updated_at": "2021-07-29T05:25:38Z",
//	"pushed_at": "2021-07-29T05:25:35Z",
//	"git_url": "git://github.com/zhang86036055/AutoBuy.git",
//	"ssh_url": "git@github.com:zhang86036055/AutoBuy.git",
//	"clone_url": "https://github.com/zhang86036055/AutoBuy.git",
//	"svn_url": "https://github.com/zhang86036055/AutoBuy",
//	"homepage": null,
//	"size": 64155,
//	"stargazers_count": 0,
//	"watchers_count": 0,
//	"language": "Java",
//	"has_issues": true,
//	"has_projects": true,
//	"has_downloads": true,
//	"has_wiki": true,
//	"has_pages": false,
//	"has_discussions": false,
//	"forks_count": 0,
//	"mirror_url": null,
//	"archived": false,
//	"disabled": false,
//	"open_issues_count": 0,
//	"license": null,
//	"allow_forking": true,
//	"is_template": false,
//	"web_commit_signoff_required": false,
//	"topics": [
//
//	],
//	"visibility": "public",
//	"forks": 0,
//	"open_issues": 0,
//	"watchers": 0,
//	"default_branch": "main"
//  },

// https://api.github.com/repos/zhang86036055/Spotify-iOS/readme

import Foundation

struct Repository: Codable {
	let id: Int
	let nodeId: String
	let name: String
	let privateStatus: Bool
	let htmlUrl: URL
	let description: String?
	let fork: Bool
	let language: String
	let watchers: Int
	let forks: Int
}

//
//  Follower.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/13/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import Foundation

/*
 ❯ curl https://api.github.com/users/zhang86036055
 {
   "login": "zhang86036055",
   "id": 77553874,
   "node_id": "MDQ6VXNlcjc3NTUzODc0",
   "avatar_url": "https://avatars.githubusercontent.com/u/77553874?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/zhang86036055",
   "html_url": "https://github.com/zhang86036055",
   "followers_url": "https://api.github.com/users/zhang86036055/followers",
   "following_url": "https://api.github.com/users/zhang86036055/following{/other_user}",
   "gists_url": "https://api.github.com/users/zhang86036055/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/zhang86036055/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/zhang86036055/subscriptions",
   "organizations_url": "https://api.github.com/users/zhang86036055/orgs",
   "repos_url": "https://api.github.com/users/zhang86036055/repos",
   "events_url": "https://api.github.com/users/zhang86036055/events{/privacy}",
   "received_events_url": "https://api.github.com/users/zhang86036055/received_events",
   "type": "User",
   "site_admin": false,
   "name": "Simon Zhang",
   "company": "Meta",
   "blog": "szhang",
   "location": "Dallas, TX",
   "email": null,
   "hireable": null,
   "bio": "SDE at Meta",
   "twitter_username": null,
   "public_repos": 15,
   "public_gists": 0,
   "followers": 1,
   "following": 2,
   "created_at": "2021-01-16T21:42:42Z",
   "updated_at": "2023-09-14T00:28:15Z"
 }

 ❯ curl https://api.github.com/users/zhang86036055/followers
 [
   {
	 "login": "shenyue0625",
	 "id": 57239328,
	 "node_id": "MDQ6VXNlcjU3MjM5MzI4",
	 "avatar_url": "https://avatars.githubusercontent.com/u/57239328?v=4",
	 "gravatar_id": "",
	 "url": "https://api.github.com/users/shenyue0625",
	 "html_url": "https://github.com/shenyue0625",
	 "followers_url": "https://api.github.com/users/shenyue0625/followers",
	 "following_url": "https://api.github.com/users/shenyue0625/following{/other_user}",
	 "gists_url": "https://api.github.com/users/shenyue0625/gists{/gist_id}",
	 "starred_url": "https://api.github.com/users/shenyue0625/starred{/owner}{/repo}",
	 "subscriptions_url": "https://api.github.com/users/shenyue0625/subscriptions",
	 "organizations_url": "https://api.github.com/users/shenyue0625/orgs",
	 "repos_url": "https://api.github.com/users/shenyue0625/repos",
	 "events_url": "https://api.github.com/users/shenyue0625/events{/privacy}",
	 "received_events_url": "https://api.github.com/users/shenyue0625/received_events",
	 "type": "User",
	 "site_admin": false
   }
 ]
 */

struct Follower: Codable, Hashable {
	var login: String
	var avatarUrl: String

	func hash(into hasher: inout Hasher) {
		hasher.combine(login)
	}
}

struct User: Codable {
	var login: String
	var avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	var publicRepos: Int
	var publicGists: Int
	var htmlUrl: String
	var following: Int
	var followers: Int
	var createdAt: String
}

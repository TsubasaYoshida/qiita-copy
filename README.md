# README

## work-flow

1. Issueを作成する
2. Issueに紐付いたフィーチャーブランチ(feature#{issue-number})を作成する
3. コミットコメントにIssue番号を入れてコミット&プッシュする
4. フィーチャーブランチ→masterのプルリクエストを作成する
5. Issueをクローズするコメントを残して、プルリクエストをマージする

引用元: [github/bitbucketのチケットとプルリクを使って開発ノウハウを確実に残す方法 - Yhei Web Design](https://yhei-web-design.com/blogs/colum/software-know-how/github-ticket-pull-request-know-how/)

## branch-protection

- masterブランチへのプッシュを禁止した(ローカル側)。
    - [[Git] 特定のブランチに対するpushを禁止し、ミスをシステム的に防ぐ - Qiita](https://qiita.com/sensuikan1973/items/e6ab84403338a874b3aa)
- masterブランチを保護した(GitHub側)。
    - [Githubでブランチ保護設定した時の作業メモ - Qiita](https://qiita.com/da-sugi/items/ba3cd83e64c689795c50)

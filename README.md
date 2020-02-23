# Qiita-Copy
*Imitation grows you.*

## URL
- [https://qiita-copy.herokuapp.com](https://qiita-copy.herokuapp.com)

## What's this?
- Qiitaのコピーサービスを作成するトレーニングリポジトリ

## You can use this service to ...
- サインアップ
- サインイン、サインアウト
- 記事投稿、編集、削除
- コメント投稿、編集、削除
- いいね
- 下書き保存
- ユーザー情報変更
- 退会

## In the future...
- フォロー
- アクティベート
- パスワードリセット
- 通知

## This service is made of ...
- Ruby 2.7.0
- Rails 6.0.2.1

## Work-flow
1. Issueを作成する
2. Issueに紐付いたフィーチャーブランチ(feature#{issue-number})を作成する
3. コミットコメントにIssue番号を入れてコミット&プッシュする
4. フィーチャーブランチ→masterのプルリクエストを作成する
5. Issueをクローズするコメントを残して、プルリクエストをマージする

引用元: [github/bitbucketのチケットとプルリクを使って開発ノウハウを確実に残す方法 - Yhei Web Design](https://yhei-web-design.com/blogs/colum/software-know-how/github-ticket-pull-request-know-how/)

## Branch-protection
- masterブランチへのプッシュを禁止した(ローカル側)。
    - [[Git] 特定のブランチに対するpushを禁止し、ミスをシステム的に防ぐ - Qiita](https://qiita.com/sensuikan1973/items/e6ab84403338a874b3aa)
- masterブランチを保護した(GitHub側)。
    - [Githubでブランチ保護設定した時の作業メモ - Qiita](https://qiita.com/da-sugi/items/ba3cd83e64c689795c50)

## Retrospective
### Keep
- 見ていただけるということで、よりよいコードにしようという意識が自然とあった。
よりよい書き方について調べる中でその奥深さに圧倒されながらも、もっとRubyやRailsを好きになった。

### Problem
- どこまでQiitaに寄せるのか明確にしなかったため、「寄せ」にブレが出た。
- どの機能までをスコープとするか曖昧に決めてしまったため、後からこれもあれも追加しなきゃとなって先を見通せなかった。
- テストコードを書かなかった。
書いたコード全てにテストコードが必要なのではないかと思い込んでしまい、余計に手が出なくなった。

### Try
- まず一つでもテストコードを書いてみる。
- どういう時にテストコードを書くことにするのか、明確に決めてみる。
- Sass(BEM)についてコーディング規約をしっかりと意識して書いてみる。

## Author
- [TsubasaYoshida](https://github.com/TsubasaYoshida)

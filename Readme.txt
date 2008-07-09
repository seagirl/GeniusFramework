Genius Framework 1.1.0 for Flex
----------------------------------------

* Genius Frameworkとは

- Flex用のフレームワーク
- ビュー層には The Flex Code-Behind Pattern(*1) を採用 (MXML と AS を分離する)
- コントローラ層には Thread ライブラリ(*2)を採用
- スケルトン作成をシェルコマンドが付属
- BrowserManager と ViewStack を使った状態管理の仕組み（デフォルトはページ単位）
- Macの変速ホイールスクロールをサポート
- 独自ビューコンポーネント (Link, SimpleButton, AdvancedCanvas, AdvancedRadioButton など)
- 自由な拡張が可能

 *1 The Flex Code-Behind Pattern
 http://blog.vivisectingmedia.com/2008/04/the-flex-code-behind-pattern/

 *2 Thread ライブラリ
 http://www.libspark.org/wiki/Thread


* 使い方

コマンドを使うと簡単にプロジェクトのスケルトンを作ることが出来ます。

./genius -p プロジェクト名 -n パッケージ -o 出力先

ex) ./genius -p Sample -n jp.seagirl.sample -o ~/Desktop


* ディレクトリ構成
/app-template  ... geniusコマンドに用いられるテンプレート
/bin           ... コマンド群
/html-template ... Flex Builder用のHTMLテンプレート
/samples       ... サンプル
/src           ... ソースファイル


* Mac の変則ホイールスクロール機能を使うために

Mac の変則ホイールスクロールを使うには、プロジェクトディレクトリの直下に
「html-template」を追加する必要があります。
（Flex Builder が作る html-template を上書きする。）

また、変則ホイールスクロールは ExternalInterface を使っているため、
ローカルでプレビューする際には「Local Trusted」サンドボックスで実行する必要があります。
今、どのサンドボックスで実行されているかどうかは、Genius Framework では
コンソールで確認出来るようになっています。

例）
--------------------------------------------- Fri Jun 13 19:29:00 GMT+0900 2008
This is jp.seagirl.sample 
SandboxType is localTrusted 

「Local Trusted」で実行する方法は下記を参照してください。
http://livedocs.adobe.com/flash/9.0_jp/main/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00000350.html


* ドキュメント

- リファレンス
http://seagirl.jp/genius/docs/




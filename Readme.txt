Genius Framework 2.0.0 for Flex
----------------------------------------

* Genius Frameworkとは

- Flex用のフレームワーク
- MXML と AS の分離をして記述するためのアーキテクチャ
- プロジェクトのスケルトンを作成するコマンド（シェルスクリプト）が付属
- モデル、ビュー、コントローラ、スレッドのスケルトンを生成するコマンド（シェルスクリプト）が付属
- サービス層には Thread を採用
- BrowserManager と ViewStack を使った状態管理の仕組み（デフォルトはページ単位）
- Macのホイールスクロールをサポート（SWFWheel 採用）
- 独自ビューコンポーネント (Link, AdvancedCanvas, AdvancedRadioButton など)
- 自由な拡張が可能

 * Thread ライブラリ
 http://www.libspark.org/wiki/Thread
 
  * SWFWheel ライブラリ
 http://www.libspark.org/wiki/SWFWheel


* 使い方

genius コマンドを使うと簡単にプロジェクトのスケルトンを作ることが出来ます。

./genius -n プロジェクト名 -p パッケージ -o 出力先

ex) ./genius -n Sample -p jp.seagirl.sample -o ~/Desktop

注) Windows では Cygwin などを利用して genius コマンドを実行する必要があります。


* ディレクトリ構成
/app-template  ... geniusコマンドに用いられるテンプレート
/bin           ... コマンド群
/html-template ... Flex Builder用のHTMLテンプレート
/samples       ... サンプル
/src           ... ソースファイル


* セキュリティサンドボックスに関する注意

Mac におけるホイールイベントをサポートするのに ExternalInterface を使っているため、
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




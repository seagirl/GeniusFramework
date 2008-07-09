package Controller::ThreePane;
use strict;
use warnings;
use lib qw(../);
use Class::Date;

sub new {
    my $invocant = shift;
    my $class = ref($invocant) || $invocant;
    my $self = {};
    return bless($self, $class);
}

sub load {
    my ($self, $variables) = @_;
    my $result =
    {
        post =>
        [
            {
                id => 1,
                title => 'AIRアプリの起動時の位置',
                content => '　いきなり脱線しますが、Adobe AIRで作られたアプリケーションは何と呼べば良いのでしょうか。とりあえずAIRアプリと呼ぶことにしましたが、どうもわかりずらいですね。
　というわけで、AIRアプリの起動時の位置について社内で質問を受けたのでまとめておこうと思います。',
                created => '2008-04-01 12:34:45',
                modified => '2008-04-01 12:34:45'
            },
            {
                id => 2,
                title => 'Dateクラスのコンストラクタの引数',
                content => '　Dateクラスのコンストラクタの第一引数（yearOrTimevalue）に渡すことが出来る値のフォーマットについて調べてみました。
　結論から書くと、ある程度のフォーマットならば適当に解釈してくれました。',
                created => '2008-04-05 12:34:45',
                modified => '2008-04-05 12:34:45'
            },
            {
                id => 3,
                title => 'AIRアプリで特定のファイルフォーマットのファイルを開く方法',
                content => '　社内でアルファチャンネル付きのFLVを開くアプリケーションはないかと聞かれ、よく考えたらそういうアプリケーションが見当たらないことに気付きました。
　FLVならばFlashで開けるだろう、ということでAdobe AIRを使って「FLV Player」を社内向けに作ることにしました。
　ローカルアプリなんだから、普通にFLVファイルをダブルクリックして開いた時にこの「FLV Player」で開けないものかな、と思って調べたら出来たのでまとめておきます。',
                created => '2008-04-07 12:34:45',
                modified => '2008-04-07 12:34:45'
            },
            {
                id => 4,
                title => 'AIRアプリでOS側からのドラッグ&ドロップを受け付ける方法',
                content => '　またしてもAIRネタです。ハイペースで情報を詰め込むと忘れやすいので、覚えているうちにネタ毎にまとめてblogに投げておくと、後々自分にとっても役に立ちそうなので書いてしまいます。
　さてさて、今回はMacのFinderやWindowsのExplorerのから直接ファイルをAIRアプリにドラッグ&ドロップして渡すためのAPIの使い方です。',
                created => '2008-04-08 12:34:45',
                modified => '2008-04-08 12:34:45'
            },
            {
                id => 5,
                title => 'E4Xのフィルタ演算子',
                content => '　社内メーリングリストにポストしたら中々好評だったのでblogにまとめてみます。
　E4Xにはフィルタ演算をする演算子として丸括弧があって、それを使うと、簡単に検索やフィルタリングが出来ます。
　詳しくはこの辺りを参考に Core JavaScript 1.5 Guide:Processing XML with E4X
　このこと自体は結構有名なので、知っている人や活用している人も多いかと思いますが、今回はこんな使い方もあるよというのを紹介してみます。',
                created => '2008-04-13 12:34:45',
                modified => '2008-04-13 12:34:45'
            },
        ],
        modified => Class::Date->now()->string()
    };
    
    return $result;
}

sub sync {
    my ($self, $variables) = @_;
    my $result =
    {
        post =>
        [
            {
                id => 1,
                title => 'AIRアプリの起動時の位置（追記）',
                content => '　いきなり脱線しますが、Adobe AIRで作られたアプリケーションは何と呼べば良いのでしょうか。とりあえずAIRアプリと呼ぶことにしましたが、どうもわかりずらいですね。
　というわけで、AIRアプリの起動時の位置について社内で質問を受けたのでまとめておこうと思います。

　（追記）
　書き加えました。(2008/04/04)',
                created => '2008-04-01 12:34:56',
                modified => '2008-04-04 01:23:45'
            },
        ],
        modified => Class::Date->now()->string()
    };
    
    return $result;
}

sub DESTROY {
  my $self = shift;
}

1;

# TsugiDoco

## サイト概要
![スクリーンショット 2020-08-15 15 47 41](https://user-images.githubusercontent.com/63027881/90307153-b7898280-df0e-11ea-9b28-a9b2830b9698.png)
1.ありとあらゆる「行き先」のデータベース であり  
2.「ルート」の共有SNS であり  
3.「次、どこ行こう」の行き先提案サービス　です！  

## URL
https://tsugidoco.work/  
ルート、プレイスの閲覧はログインしなくても見ることができます。  

## 背景
食事や用事を済ませたあと、「このあとどうしようか」と動き出せないことがよくあります。  
「おすすめスポット10選」などの記事は便利だけど、あくまで「今いるところ」を起点にした行き先を知りたい！と常々思っていました。「近くの公園」「小さな雑貨屋」「町の銭湯」、普段ならわざわざ足を運ばないけど今いる場所からならちょっと行ってみようかなと思える場所がきっとあるはず。  
多くの人が見つけた場所を知ることも教えることもできる。その情報をもとにまた新しい自分だけの行き先を見つけることができる。そんな仕組みを実現できるサービスを作ろうと思いました。

## 具体的な利用シーン
【探す】
- 目当てのお店でランチを食べたけど、この後どこに行こう。  
- 今度の飲み会、二軒目に行けるお店も探しておきたいな。  
- デートで東京タワーに行くけど、周辺でデートコースを考えておきたい！  
【共有する】
- 新しくできたカフェを見つけた。  
- 今日の街ブラコースを記録しておこう。  
- お店の情報をもっと知って欲しいから書き足しておこう。  

## 機能一覧
https://docs.google.com/spreadsheets/d/11BxktMnu3jaWmELXdUGlKXVrmQoiVLTQCAmwMqRlrXs/edit?usp=sharing  

## 環境
### フロントエンド
Bootstrap4  
Scss(BEM)  
JavaScript, jQuery,Ajax  
### バックエンド
Ruby 2.5.7  
Rails 5.2.4.3  
### 開発環境
Vagrant 2.2.9  
### 本番環境
MySQL2  
AWS (EC2, RDS for MySQL,Route53)  
Nginx, Puma  
Capistrano  
### その他
Google MapAPI、Geocoding API  
Vision API  
HTTPS接続  


## ER図
https://drive.google.com/file/d/1cNZY019o9EwdUIYHde4c8KzaSYt99uDt/view?usp=sharing

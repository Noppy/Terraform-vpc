# CreateVpcForTerraform
# 概要
terraformでVPCを作成するための汎用モジュール。
- パラメータの指定で、以下の２タイプのVPCが作成可能
  - 2AZタイプ: パブリックサブネット x 2、 プライベートサブネット x 2(パラメータ指定でIGWの有無を指定可能)
  - 3AZタイプ: パブリックサブネット x 3、 プライベートサブネット x 3(パラメータ指定でIGWの有無を指定可能)

作成されるリソースは以下の通り
- VPCの基本構成: 
  - VPC、サブネット、ルートテーブル
  - DHCP Option Set(DNSはAmazonProvidedDNS、NTPはAmazon Time sync Serviceを指定済み。モジュールの引数で指定可能)
  - VPC Flow Logs(S3バケット 出力)
- パブリック接続(モジュール引数で、作成有無指定可能)
  - Internet Gateway
  - NAT Gateway
- VPCエンドポイント
  - ゲートウェイ型のS3およびDynamoDBのみ設定
- SecurityGroup
  - VPCエンドポイント(インターフェース型)用セキュリティーグループ
  - EC2インスタンス用セキュリティーグループ(引数で、SSH接続ルール追加可能)

# モジュールの利用方法
モジュールは以下のように呼び出す。

```hcl
module "vpc" {
  source = "../../modules/vpc"

  vpcname                        = "MainVpc"
  vpc_cidr_block                 = "10.1.3.0/24" // VPCのCIDRを指定
  availability_zone              = "3az"         // "2az" or "3az"
  create_igw                     = true          // IGWを利用しない場合はfalseを指定
  create_nagtw                   = true          // NATGWを使用しない場合はfalseを指定
  sg_ec2_ssh_ingress_source_cidr = ""            // インスタンスへのSSH接続を許可するCIDRを指定。ブランク("")の場合は、SecurityGroupにルールが設定されない。

  vpcflowlogsbucket = "VPC Flow Logsの出力先のS3バケット のARN"
}
```

モジュールのOutputsとして以下が利用可能
- VPC
  - vpc
- サブネット
  - publicsub1
  - publicsub2
  - publicsub3 *2AZ構成の場合はブランク
  - privatesub1
  - privatesub2
  - privatesub3 *2AZ構成の場合はブランク
- ルートテーブル
  - public-rtb
  - private1-rtb
  - private2-rtb
  - private3-rtb
- セキュリティーグループ
  - sg-vpce-sg *VPCエンドポイント(インターフェース型)用のセキュリティーグループ
  - sg-ec2-sg *EC2インスタンス 用のセキュリティーグループ

# ブランチとWorkflowの説明
## ブランチ
### 環境リリース用ブランチ
このリポジトリでは環境デプロイ用に以下のブランチを準備する。それぞれの環境へのデプロイは該当するブランチへのpull reqのマージによりWorkflowが動作しterraformによりデプロイが行われる。
- `production`: 本番環境用ブランチ。更新時は`staging`ブランチからpull reqを申請しマージする。
- `staging`: ステージング環境用ブランチ。更新時は、`development`ブランチからpull reqを申請しマージする。
- `development`(default): 開発環境用ブランチ。
### 開発用ブランチ
コードの開発は、Feature Branching Strategy(フューチャーブランチ戦略)を前提としている。

開発をする場合は、`development`ブランチから任意のブランチをチェックアウトし、開発&ローカルでのテストの後、`development`ブランチへのマージのためのpull reqを申請し`development`ブランチにマージする。

## GitHub Actions(workflow)
ワークフローは以下のトリガーで実行される。
- pull req: pull reqの`Open`, `synchronize`, `reopened`時に実行。この場合は`terraform plan`までの実行で`apply`はされない。
- マージ(push): pull reqをマージした時(push)時に実行。この場合は`terraform apply`まで実行される
## SECRETS
terraformでAWS環境用のProviderで利用するクレデンシャル(アクセスキー、シークレットキー)は、environmentsで管理する。
なおPrivateリポジトリでenvironmentが利用できない場合は、`Secrets`にアクセスキーとシークレットキーを設定する。その場合は、環境毎のクレデンシャルの使い分けはできないことに留意すること。
- environment `production`: production環境用
- environment `staging`: staging環境用
- environment `development`: development環境用

アクセスキー、シークレットキーは、以下の手順で設定する
- AWSにて`AdministratorAccess`権限を付与したIAMユーザーを作成し、アクセスキーとシークレットキーを生成する
- 生成したアクセスキーとシークレットキーは、該当環境のenvironmentにて以下のSECRETを設定する。なおenvironmentが利用できない場合は、Secretsに設定する。
  - `AWS_ACCESS_KEY_ID`: 生成したアクセスキーを設定
  - `AWS_SECRET_ACCESS_KEY`: 生成したシークレットキーを設定


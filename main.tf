## ------------------
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket  = "tastylog-tfstate-bucket-lifetech"
    key     = "tastylog-dev/tfstate"
    region  = "ap-northeast-1"
    profile = "teraform"
  }
}
## ------------------
## provider
## ------------------
provider "aws" {
  profile = "teraform"
  region  = "ap-northeast-1"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}
variable "aws_region" {
  type    = string
  default = "us-north-1"

}



# Copilotの自動補完で使える主なショートカット（VS Codeの場合）

# - `Tab` または `Ctrl` + `Enter` : 提案された補完を受け入れる
# - `Esc` : 補完候補を閉じる
# - `Alt` + `[` / `Alt` + `]` : 複数候補がある場合、次/前の候補に切り替える
# - `Ctrl` + `Space` : 手動で補完候補を表示
# - `Ctrl` + `Shift` + `\\` : Copilotパネルを開く
# - `Ctrl` + `.` : インライン提案をサイクル

# ※Macの場合は `Ctrl` を `Cmd` に読み替えてください

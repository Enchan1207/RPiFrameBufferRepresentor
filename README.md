# fbconv

## Overview

RaspberryPiのフレームバッファ出力を画像ファイルに変換するアプリケーション。

## Installation

```shell
make # to generate executable file
sudo make install
```

## Usage

```
fbconv <input filepath> -w <screen width> -h <screen height> -o <output filepath>
```

`-w`および`-h`は片方いずれか、または両方を指定することができます。  
`-o`を省くと、入力ファイル名の拡張子を`png`に置換して書き出します。

## LICENSE

All files in this repository is published under MIT License.  
In details, see [LICENSE](LICENSE).

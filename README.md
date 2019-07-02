# Ruby on Headless Chrome
- Ruby で Headless Chrome を用いて Webページ のスクリーンショットを撮る
  - `selenium-webdriver` と `capybara` が必須になる

#### 1. Chrome Driver をインストールする
- http://chromedriver.storage.googleapis.com/index.html

##### Mac
- ダウンロードする chromedriver は、マシンにインストールされている Chrome とバージョンが一致していなくてはならない
- フォントのインストールは特にせずとも日本語が表示されているが、他の環境では別途インストールが必要だと思われる

- ChromeDriver 75.0.3770.90 の場合

```bash
$ wget http://chromedriver.storage.googleapis.com/75.0.3770.90/chromedriver_mac64.zip
$ unzip chromedriver_mac64.zip
$ sudo cp /usr/local/bin/chromedriver
$ chromedriver -v
ChromeDriver 75.0.3770.90 (a6dcaf7e3ec6f70a194cc25e8149475c6590e025-refs/branch-heads/3770@{#1003})
```

- ChromeDriver 76.0.3809.25 の場合

```bash
$ wget http://chromedriver.storage.googleapis.com/76.0.3809.25/chromedriver_mac64.zip
$ unzip chromedriver_mac64.zip
$ sudo cp /usr/local/bin/chromedriver
$ chromedriver -v
ChromeDriver 76.0.3809.25 (a0c95f440512e06df1c9c206f2d79cc20be18bb1-refs/branch-heads/3809@{#271})
```

#### 2. selenium-webdriver と capybara をインストールする
```bash
$ gem install selenium-webdriver
$ gem install capybara
```

#### 3. コードを書く

##### 3-1. selenium-webdriver と capybara を `require` する
```ruby
require 'selenium-webdriver'
require 'capybara'
```

##### 3-2. Capybara の設定をする
以下の3つの Capybara の設定を行う。

- `defult_driver`

```ruby
Capybara.configure do |capybara_config|
  capybara_config.default_driver = :selenium_chrome
end
```

- `register_driver`

```ruby
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

- `javascript_driver`

```ruby
Capybara.javascript_driver = :selenium_chrome
```

##### 3-3. Capybara::Session を作る
```ruby
my_session = Capybara::Session.new(:selenium_chrome)
```

##### 3-4. 操作する
- [File: README — Documentation for teamcapybara/capybara (master)](https://www.rubydoc.info/github/teamcapybara/capybara/master)

```ruby
my_session.visit('https://www.google.co.jp/')
my_session.save_screenshot('screenshot.png')
my_session.has_css?('#pageTopButton') #=> true
```

### Tips
- Driver には [apparition](https://github.com/twalpole/apparition) を使う手段もある
- 画面サイズを変更する際には、ヘッドレスの場合は `window_size` を使う
  - `screen_size` では変更されない
- ヘッドレスではスクリーンショットのオプションの `full: true` は無効である
  - [こちらの記事](https://qiita.com/g-fujioka/items/091c400814800f1280ff) のように苦しくやる方法はあるが……

## 参考
- [MacにChromeDriverを入れる - naichi's lab](https://blog.naichilab.com/entry/mac-chromedriver)
- [[Ruby]Selenium::WebDriverでHeadless Chromeを起動したときのChromeのオプション設定 - Qiita](https://qiita.com/eightfoursix/items/6943cad899a571d02798)
- スクレイピング用途ならば素直に [Puppeteer](https://github.com/GoogleChrome/puppeteer) を使ったほうがいい
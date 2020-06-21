require "ferrum"
require 'dotenv'

Dotenv.load

options = {
  window_size: [ 1024, 768 ],
  timeout: 300
}
options[headless] = ENV['headless'].to_s.downcase == "true" if ENV.key?('headless')
@browser = Ferrum::Browser.new(options)

def set_target_self_and_click(path)
  @browser.execute("document.querySelector('#{path}').target = '_self'")
  @browser.at_css(path).click
end


@browser.goto("https://www.himegin.co.jp/security/index.php?id=wyn")
set_target_self_and_click("#contents > div > p.btn-base.btn-default.btn-next.btn-icon-l.w50p.sp-w80p.mA.mt2 > a")

@browser.at_css("[name='BTX0010']").focus.type(ENV['USER_ID'])
@browser.at_css("[name='BPW0020']").focus.type(ENV['PASSWORD'])
@browser.at_css("[name='forward_BSM2010']").click

sleep 10
@browser.screenshot(path: "account.png")
@browser.quit

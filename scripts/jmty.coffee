# Jimoty

client = require('cheerio-httpcli');
http = require('http')
cronJob = require('cron').CronJob
base_url = "http://jmty.jp/tokyo"
search_prefix = "sale"

keywords = [
  "IKEA",
  "チェア",
  "椅子",
  "アンティーク",
  "ランプ",
  "骨董"
]

module.exports = (robot) ->
  robot.jmty = (keyword) ->
    query_url = base_url + "/" + search_prefix + "?keyword=" + keyword

    ids = []
    urls = []
    titles = []
    client.fetch query_url, { keyword: keyword }, (err, $, res, body) ->
      $('ul.list_sale > li > h3 > a').each (idx) ->
        url = $(this).attr('href')
        urls.push(url)
        ids.push(url.substring(url.lastIndexOf('/') + 1, url.length))
        titles.push($(this).text().trim())

      latest_item = robot.brain.get("jmtyLatest-#{keyword}")
      robot.brain.set("jmtyLatest-#{keyword}", ids[0])

      if latest_item?
        latest_idx = 0
        for id, i in ids
          if latest_item == id
            latest_idx = i
            break

        if latest_idx > 0
          robot.send {room: "#jmty"}, """
ジモティーに新しい「#{keyword}」の商品が出品されたわよ！
"""
          for i in [0..latest_idx]
            robot.send {room: "#jmty"}, """
#{titles[i]}
#{urls[i]}
"""

  new cronJob(
    cronTime: "0 */10 * * * *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      for w in keywords
        robot.jmty(w)
  )


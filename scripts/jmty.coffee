# Jimoty

client = require('cheerio-httpcli');
http = require('http')
cronJob = require('cron').CronJob
base_url = "http://jmty.jp/"
search_prefix = "tokyo/sale"
area_prefix = "area_portal"

keywords = [
  "無印",
  "MUJI",
  "IKEA",
  "チェア",
  "椅子",
  "アンティーク",
  "ランプ",
  "骨董",
  "ビーズクッション",
  "Yogibo",
  "スピーカー",
  "エレキベース",
  "アンプ",
  "中目黒",
  "レトロ",
  "SENNHEISER",
  "ゼンハイザー",
  "ヘッドホン",
  "MOMENTUM"
]

area_map = {
  "32717": "中目黒"
}

module.exports = (robot) ->
  robot.jmtyAreaSearch = (id, name) ->
    query_url = base_url + area_prefix + "/" + id
    console.log("Searching for #{name}")
    console.log(query_url)

    ids = []
    urls = []
    titles = []
    client.fetch query_url, {}, (err, $, res, body) ->
      if err?
        console.log("Error: #{err}")
      $('ul.list_sale > li > h3 > a').each (idx) ->
        url = $(this).attr('href')
        urls.push(url)
        ids.push(url.substring(url.lastIndexOf('/') + 1, url.length))
        titles.push($(this).text().trim())

      latest_item = robot.brain.get("jmtyLatest-#{name}")
      robot.brain.set("jmtyLatest-#{name}", ids[0])

      console.log(ids[0..2])
      console.log(urls[0..2])
      console.log(titles[0..2])

      if latest_item?
        latest_idx = 0
        for id, i in ids
          if latest_item == id
            latest_idx = i
            break

        if latest_idx > 0
          console.log("#{latest_idx+1} new items")
          robot.send {room: "#jmty"}, """
ジモティーに新しい「#{name}」の商品が出品されたわよ！
"""

          for i in [0..latest_idx-1]
            robot.send {room: "#jmty"}, """
#{titles[i]}
#{urls[i]}
"""
          robot.send {room: "#jmty"}, """
以上よ！
"""
        else
          console.log("No new items.")
      else
        console.log("Initialized.")

  robot.jmtyKeywordSearch = (keyword) ->
    query_url = base_url + "/" + search_prefix
    console.log("Searching for #{keyword}")
    console.log(query_url)

    ids = []
    urls = []
    titles = []
    prices = []
    client.fetch query_url, { keyword: keyword }, (err, $, res, body) ->
      if err?
        console.log("Error: #{err}")
      $('ul.list_sale > li > h3 > a').each (idx) ->
        url = $(this).attr('href')
        urls.push(url)
        ids.push(url.substring(url.lastIndexOf('/') + 1, url.length))
        titles.push($(this).text().trim())

      $('ul.list_sale > li > p > span > b').each (idx) ->
        prices.push(parseInt(
          $(this).text().trim().replace( /[円,]/g , '')))

      latest_item = robot.brain.get("jmtyLatest-#{keyword}")
      robot.brain.set("jmtyLatest-#{keyword}", ids[0])

      console.log(ids[0..2])
      console.log(urls[0..2])
      console.log(titles[0..2])
      console.log(prices[0..2])

      if latest_item?
        latest_idx = 0
        for id, i in ids
          if latest_item == id
            latest_idx = i
            break

        if latest_idx > 0
          console.log("#{latest_idx+1} new items")
          msg = ""
          msg += """

新しい「#{keyword}」の商品が出品されたわよ！

"""

          for i in [0..latest_idx-1]
            if prices[i] == 0
              msg += """

**！！無料！！**
#{titles[i]}
#{urls[i]}

"""
            else
              msg += """

【#{prices[i]}円】
#{titles[i]}
#{urls[i]}

  """

          msg += """

 以上よ！
"""
          robot.send {room: "#jmty"}, msg
        else
          console.log("No new items.")
      else
        console.log("Initialized.")

  new cronJob(
    cronTime: "0 */5 * * * *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      ###
      for id, name of area_map
        robot.jmtyAreaSearch(id, name)
      ###

      for w in keywords
        robot.jmtyKeywordSearch(w)
  )

  robot.respond /ジモティーチェック/i, (res) ->
    res.reply "Roger."

    for w in keywords
      robot.jmtyKeywordSearch(w)



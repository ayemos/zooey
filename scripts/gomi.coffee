# ゴミ出し用
cronJob = require('cron').CronJob

dayGomiMap =
  "monday": ["燃やすごみ"]
  "tuesday": []
  "second_tuesday": ["燃やさないゴミ(水銀を*含まない*もの)"]
  "fourth_tuesday": ["燃やさないゴミ(水銀を含む製品も可)"]
  "wednesday": []
  "thursday": ["燃やすごみ"]
  "friday": ["古紙・ダンボールごみ"]
  "saturday": ["資源ごみ"]
  "sunday": ["hoge"]

module.exports = (robot) ->
  robot.sayGomi = (gomiType) ->
    robot.send {room: "#general"}, """
!!!!試験運用中(結果を信用しないように)!!!!"
----ゴミ出しのお知らせ----
"""
    robot.send {room: "#general"}, """
今日は『#{gomiType}』の日ね。
"*8*時までに出すのよ？急いで急いで！
"""

  new cronJob(
    cronTime: "0 45 7 * * 0"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.sunday? && dayGomiMap.sunday.length > 0
        robot.sayGomi(dayGomiMap.sunday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 1"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.monday? && dayGomiMap.monday.length > 0
        robot.sayGomi(dayGomiMap.monday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 2"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.tuesday? && dayGomiMap.tuesday.length > 0
        date = new Date
        day = date.getDate()

        # second
        if day >= 8 && day <= 14
          robot.sayGomi(dayGomiMap.second_tuesday)
        # fourth
        else if day >= 22 && day <= 28
          robot.sayGomi(dayGomiMap.fourth_tuesday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 3"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.wednesday? && dayGomiMap.wednesday.length > 0
        robot.sayGomi(dayGomiMap.wednesday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 4"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.thursday? && dayGomiMap.thursday.length > 0
        robot.sayGomi(dayGomiMap.thursday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 5"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.friday? && dayGomiMap.friday.length > 0
        robot.sayGomi(dayGomiMap.friday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 6"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.saturday? && dayGomiMap.saturday.length > 0
        robot.sayGomi(dayGomiMap.saturday)
  )

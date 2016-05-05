# Jimoty

cronJob = require('cron').CronJob

module.exports = (robot) ->


module.exports = (robot) ->
  robot.sayJmty = (category, url) ->
    robot.send {room: "#jmty"}, """
!!!!試験運用中(結果を信用しないように)!!!!"
----ゴミ出しのお知らせ----
"""

  # Sunday
  new cronJob(
    cronTime: "0 0 23 * * 6"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.sunday? && dayGomiMap.sunday.length > 0
        robot.remindGomi(dayGomiMap.sunday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 0"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.sunday? && dayGomiMap.sunday.length > 0
        robot.sayGomi(dayGomiMap.sunday)
  )

  # Monday
  new cronJob(
    cronTime: "0 0 23 * * 0"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.monday? && dayGomiMap.monday.length > 0
        robot.remindGomi(dayGomiMap.monday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 1"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.monday? && dayGomiMap.monday.length > 0
        robot.sayGomi(dayGomiMap.monday)
  )

  # Tuesday
  new cronJob(
    cronTime: "0 0 23 * * 1"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.tuesday? && dayGomiMap.tuesday.length > 0
        date = new Date
        day = date.getDate() + 1

        # second
        if day >= 8 && day <= 14
          robot.remindGomi(dayGomiMap.second_tuesday)
        # fourth
        else if day >= 22 && day <= 28
          robot.remindGomi(dayGomiMap.fourth_tuesday)
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

  # Wednesday
  new cronJob(
    cronTime: "0 0 23 * * 2"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.wednesday? && dayGomiMap.wednesday.length > 0
        robot.remindGomi(dayGomiMap.wednesday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 3"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.wednesday? && dayGomiMap.wednesday.length > 0
        robot.sayGomi(dayGomiMap.wednesday)
  )

  # Thursday
  new cronJob(
    cronTime: "0 0 23 * * 3"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.thursday? && dayGomiMap.thursday.length > 0
        robot.remindGomi(dayGomiMap.thursday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 4"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.thursday? && dayGomiMap.thursday.length > 0
        robot.sayGomi(dayGomiMap.thursday)
  )

  # Friday
  new cronJob(
    cronTime: "0 0 23 * * 4"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.friday? && dayGomiMap.friday.length > 0
        robot.remindGomi(dayGomiMap.friday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 5"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.friday? && dayGomiMap.friday.length > 0
        robot.sayGomi(dayGomiMap.friday)
  )

  # Saturday
  new cronJob(
    cronTime: "0 0 23 * * 5"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.saturday? && dayGomiMap.saturday.length > 0
        robot.remindGomi(dayGomiMap.saturday)
  )

  new cronJob(
    cronTime: "0 45 7 * * 6"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if dayGomiMap.saturday? && dayGomiMap.saturday.length > 0
        robot.sayGomi(dayGomiMap.saturday)
  )

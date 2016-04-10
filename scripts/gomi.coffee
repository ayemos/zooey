cronJob = require('cron').CronJob

monday = (robot) ->
  robot.send
  return

tuesday = (robot) ->
  return

wednesday = (robot) ->
  return

thursday = (robot) ->
  return

friday = (robot) ->
  return

saturday = (robot) ->
  return

sunday = (robot) ->
  return

module.exports = (robot) ->
  cronjob = new cronJob(
    cronTime: "* * * * * *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
#      robot.send {room: "#general"}, "おはようございます！"
      robot.send "おはようございます！"
      sunday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 8 * * 1 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      monday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 0 8 * 2 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      tuesday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 0 8 * 3 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      wednesday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 0 8 * 4 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      thursday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 0 8 * 5 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      friday(robot)
  )

  cronjob = new cronJob(
    cronTime: "0 0 8 * 6 *"
    start:    true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: "#general"}, "おはようございます！"
      saturday(robot)
  )

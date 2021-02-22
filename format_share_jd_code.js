/*
现在只能获取手动提交
基于 lxk0301 大佬的版本基础上做了格式划打印调整

已支持IOS双京东账号, Node.js支持N个京东账号
脚本兼容: QuantumultX, Surge, Loon, 小火箭，JSBox, Node.js
============Quantumultx===============
[task_local]
#获取互助码
0 1 * * * https://gitee.com/qq34347476/quantumult-x/raw/master/format_share_jd_code.js, tag=获取并提交助力码, img-url=https://raw.githubusercontent.com/yogayyy/task/master/huzhucode.png, enabled=true

================Loon==============
[Script]
cron "0 1 0/2 * *" script-path=https://gitee.com/qq34347476/quantumult-x/raw/master/format_share_jd_code.js, tag=获取并提交助力码

===============Surge=================
获取并提交助力码 = type=cron,cronexp="0 1 * * *",wake-system=1,timeout=120,script-path=https://gitee.com/qq34347476/quantumult-x/raw/master/format_share_jd_code.js

============小火箭=========
获取并提交助力码 = type=cron,script-path=https://gitee.com/qq34347476/quantumult-x/raw/master/get_share_jd_code.js, cronexpr="0 35 2 1,10,20 * ?", timeout=200, enable=true
 */
const $ = new Env('获取并格式化助力码 for Linux')
const JD_API_HOST = 'https://api.m.jd.com/client.action'
let cookiesArr = [],
  cookie = '',
  message
const jdCookieNode = $.isNode() ? require('./jdCookie.js') : ''
!(function (n) {
  'use strict'

  function t(n, t) {
    var r = (65535 & n) + (65535 & t)
    return (((n >> 16) + (t >> 16) + (r >> 16)) << 16) | (65535 & r)
  }

  function r(n, t) {
    return (n << t) | (n >>> (32 - t))
  }

  function e(n, e, o, u, c, f) {
    return t(r(t(t(e, n), t(u, f)), c), o)
  }

  function o(n, t, r, o, u, c, f) {
    return e((t & r) | (~t & o), n, t, u, c, f)
  }

  function u(n, t, r, o, u, c, f) {
    return e((t & o) | (r & ~o), n, t, u, c, f)
  }

  function c(n, t, r, o, u, c, f) {
    return e(t ^ r ^ o, n, t, u, c, f)
  }

  function f(n, t, r, o, u, c, f) {
    return e(r ^ (t | ~o), n, t, u, c, f)
  }

  function i(n, r) {
    ;(n[r >> 5] |= 128 << r % 32), (n[14 + (((r + 64) >>> 9) << 4)] = r)
    var e,
      i,
      a,
      d,
      h,
      l = 1732584193,
      g = -271733879,
      v = -1732584194,
      m = 271733878
    for (e = 0; e < n.length; e += 16)
      (i = l),
        (a = g),
        (d = v),
        (h = m),
        (g = f(
          (g = f(
            (g = f(
              (g = f(
                (g = c(
                  (g = c(
                    (g = c(
                      (g = c(
                        (g = u(
                          (g = u(
                            (g = u(
                              (g = u(
                                (g = o(
                                  (g = o(
                                    (g = o(
                                      (g = o(
                                        g,
                                        (v = o(
                                          v,
                                          (m = o(
                                            m,
                                            (l = o(
                                              l,
                                              g,
                                              v,
                                              m,
                                              n[e],
                                              7,
                                              -680876936
                                            )),
                                            g,
                                            v,
                                            n[e + 1],
                                            12,
                                            -389564586
                                          )),
                                          l,
                                          g,
                                          n[e + 2],
                                          17,
                                          606105819
                                        )),
                                        m,
                                        l,
                                        n[e + 3],
                                        22,
                                        -1044525330
                                      )),
                                      (v = o(
                                        v,
                                        (m = o(
                                          m,
                                          (l = o(
                                            l,
                                            g,
                                            v,
                                            m,
                                            n[e + 4],
                                            7,
                                            -176418897
                                          )),
                                          g,
                                          v,
                                          n[e + 5],
                                          12,
                                          1200080426
                                        )),
                                        l,
                                        g,
                                        n[e + 6],
                                        17,
                                        -1473231341
                                      )),
                                      m,
                                      l,
                                      n[e + 7],
                                      22,
                                      -45705983
                                    )),
                                    (v = o(
                                      v,
                                      (m = o(
                                        m,
                                        (l = o(
                                          l,
                                          g,
                                          v,
                                          m,
                                          n[e + 8],
                                          7,
                                          1770035416
                                        )),
                                        g,
                                        v,
                                        n[e + 9],
                                        12,
                                        -1958414417
                                      )),
                                      l,
                                      g,
                                      n[e + 10],
                                      17,
                                      -42063
                                    )),
                                    m,
                                    l,
                                    n[e + 11],
                                    22,
                                    -1990404162
                                  )),
                                  (v = o(
                                    v,
                                    (m = o(
                                      m,
                                      (l = o(
                                        l,
                                        g,
                                        v,
                                        m,
                                        n[e + 12],
                                        7,
                                        1804603682
                                      )),
                                      g,
                                      v,
                                      n[e + 13],
                                      12,
                                      -40341101
                                    )),
                                    l,
                                    g,
                                    n[e + 14],
                                    17,
                                    -1502002290
                                  )),
                                  m,
                                  l,
                                  n[e + 15],
                                  22,
                                  1236535329
                                )),
                                (v = u(
                                  v,
                                  (m = u(
                                    m,
                                    (l = u(
                                      l,
                                      g,
                                      v,
                                      m,
                                      n[e + 1],
                                      5,
                                      -165796510
                                    )),
                                    g,
                                    v,
                                    n[e + 6],
                                    9,
                                    -1069501632
                                  )),
                                  l,
                                  g,
                                  n[e + 11],
                                  14,
                                  643717713
                                )),
                                m,
                                l,
                                n[e],
                                20,
                                -373897302
                              )),
                              (v = u(
                                v,
                                (m = u(
                                  m,
                                  (l = u(l, g, v, m, n[e + 5], 5, -701558691)),
                                  g,
                                  v,
                                  n[e + 10],
                                  9,
                                  38016083
                                )),
                                l,
                                g,
                                n[e + 15],
                                14,
                                -660478335
                              )),
                              m,
                              l,
                              n[e + 4],
                              20,
                              -405537848
                            )),
                            (v = u(
                              v,
                              (m = u(
                                m,
                                (l = u(l, g, v, m, n[e + 9], 5, 568446438)),
                                g,
                                v,
                                n[e + 14],
                                9,
                                -1019803690
                              )),
                              l,
                              g,
                              n[e + 3],
                              14,
                              -187363961
                            )),
                            m,
                            l,
                            n[e + 8],
                            20,
                            1163531501
                          )),
                          (v = u(
                            v,
                            (m = u(
                              m,
                              (l = u(l, g, v, m, n[e + 13], 5, -1444681467)),
                              g,
                              v,
                              n[e + 2],
                              9,
                              -51403784
                            )),
                            l,
                            g,
                            n[e + 7],
                            14,
                            1735328473
                          )),
                          m,
                          l,
                          n[e + 12],
                          20,
                          -1926607734
                        )),
                        (v = c(
                          v,
                          (m = c(
                            m,
                            (l = c(l, g, v, m, n[e + 5], 4, -378558)),
                            g,
                            v,
                            n[e + 8],
                            11,
                            -2022574463
                          )),
                          l,
                          g,
                          n[e + 11],
                          16,
                          1839030562
                        )),
                        m,
                        l,
                        n[e + 14],
                        23,
                        -35309556
                      )),
                      (v = c(
                        v,
                        (m = c(
                          m,
                          (l = c(l, g, v, m, n[e + 1], 4, -1530992060)),
                          g,
                          v,
                          n[e + 4],
                          11,
                          1272893353
                        )),
                        l,
                        g,
                        n[e + 7],
                        16,
                        -155497632
                      )),
                      m,
                      l,
                      n[e + 10],
                      23,
                      -1094730640
                    )),
                    (v = c(
                      v,
                      (m = c(
                        m,
                        (l = c(l, g, v, m, n[e + 13], 4, 681279174)),
                        g,
                        v,
                        n[e],
                        11,
                        -358537222
                      )),
                      l,
                      g,
                      n[e + 3],
                      16,
                      -722521979
                    )),
                    m,
                    l,
                    n[e + 6],
                    23,
                    76029189
                  )),
                  (v = c(
                    v,
                    (m = c(
                      m,
                      (l = c(l, g, v, m, n[e + 9], 4, -640364487)),
                      g,
                      v,
                      n[e + 12],
                      11,
                      -421815835
                    )),
                    l,
                    g,
                    n[e + 15],
                    16,
                    530742520
                  )),
                  m,
                  l,
                  n[e + 2],
                  23,
                  -995338651
                )),
                (v = f(
                  v,
                  (m = f(
                    m,
                    (l = f(l, g, v, m, n[e], 6, -198630844)),
                    g,
                    v,
                    n[e + 7],
                    10,
                    1126891415
                  )),
                  l,
                  g,
                  n[e + 14],
                  15,
                  -1416354905
                )),
                m,
                l,
                n[e + 5],
                21,
                -57434055
              )),
              (v = f(
                v,
                (m = f(
                  m,
                  (l = f(l, g, v, m, n[e + 12], 6, 1700485571)),
                  g,
                  v,
                  n[e + 3],
                  10,
                  -1894986606
                )),
                l,
                g,
                n[e + 10],
                15,
                -1051523
              )),
              m,
              l,
              n[e + 1],
              21,
              -2054922799
            )),
            (v = f(
              v,
              (m = f(
                m,
                (l = f(l, g, v, m, n[e + 8], 6, 1873313359)),
                g,
                v,
                n[e + 15],
                10,
                -30611744
              )),
              l,
              g,
              n[e + 6],
              15,
              -1560198380
            )),
            m,
            l,
            n[e + 13],
            21,
            1309151649
          )),
          (v = f(
            v,
            (m = f(
              m,
              (l = f(l, g, v, m, n[e + 4], 6, -145523070)),
              g,
              v,
              n[e + 11],
              10,
              -1120210379
            )),
            l,
            g,
            n[e + 2],
            15,
            718787259
          )),
          m,
          l,
          n[e + 9],
          21,
          -343485551
        )),
        (l = t(l, i)),
        (g = t(g, a)),
        (v = t(v, d)),
        (m = t(m, h))
    return [l, g, v, m]
  }

  function a(n) {
    var t,
      r = '',
      e = 32 * n.length
    for (t = 0; t < e; t += 8)
      r += String.fromCharCode((n[t >> 5] >>> t % 32) & 255)
    return r
  }

  function d(n) {
    var t,
      r = []
    for (r[(n.length >> 2) - 1] = void 0, t = 0; t < r.length; t += 1) r[t] = 0
    var e = 8 * n.length
    for (t = 0; t < e; t += 8)
      r[t >> 5] |= (255 & n.charCodeAt(t / 8)) << t % 32
    return r
  }

  function h(n) {
    return a(i(d(n), 8 * n.length))
  }

  function l(n, t) {
    var r,
      e,
      o = d(n),
      u = [],
      c = []
    for (
      u[15] = c[15] = void 0, o.length > 16 && (o = i(o, 8 * n.length)), r = 0;
      r < 16;
      r += 1
    )
      (u[r] = 909522486 ^ o[r]), (c[r] = 1549556828 ^ o[r])
    return (e = i(u.concat(d(t)), 512 + 8 * t.length)), a(i(c.concat(e), 640))
  }

  function g(n) {
    var t,
      r,
      e = ''
    for (r = 0; r < n.length; r += 1)
      (t = n.charCodeAt(r)),
        (e +=
          '0123456789abcdef'.charAt((t >>> 4) & 15) +
          '0123456789abcdef'.charAt(15 & t))
    return e
  }

  function v(n) {
    return unescape(encodeURIComponent(n))
  }

  function m(n) {
    return h(v(n))
  }

  function p(n) {
    return g(m(n))
  }

  function s(n, t) {
    return l(v(n), v(t))
  }

  function C(n, t) {
    return g(s(n, t))
  }

  function A(n, t, r) {
    return t ? (r ? s(t, n) : C(t, n)) : r ? m(n) : p(n)
  }

  $.md5 = A
})(this)
if ($.isNode()) {
  Object.keys(jdCookieNode).forEach(item => {
    cookiesArr.push(jdCookieNode[item])
  })
  if (process.env.JD_DEBUG && process.env.JD_DEBUG === 'false')
    console.log = () => {}
} else {
  let cookiesData = $.getdata('CookiesJD') || '[]'
  cookiesData = jsonParse(cookiesData)
  cookiesArr = cookiesData.map(item => item.cookie)
  cookiesArr.reverse()
  cookiesArr.push(...[$.getdata('CookieJD2'), $.getdata('CookieJD')])
  cookiesArr.reverse()
  cookiesArr = cookiesArr.filter(
    item => item !== '' && item !== null && item !== undefined
  )
}
!(async () => {
  if (!cookiesArr[0]) {
    $.msg(
      $.name,
      '【提示】请先获取京东账号一cookie\n直接使用NobyDa的京东签到获取',
      'https://bean.m.jd.com/bean/signIndex.action',
      { 'open-url': 'https://bean.m.jd.com/bean/signIndex.action' }
    )
    return
  }
  for (let i = 0; i < cookiesArr.length; i++) {
    if (cookiesArr[i]) {
      cookie = cookiesArr[i]
      $.UserName = decodeURIComponent(
        cookie.match(/pt_pin=(.+?);/) && cookie.match(/pt_pin=(.+?);/)[1]
      )
      $.index = i + 1
      $.isLogin = true
      $.nickName = ''
      message = ''
      await TotalBean()
      if (!$.isLogin) {
        continue
      }
      await getShareCodeAndAdd()
    }
  }
  showFormatMsg()
})()
  .catch(e => {
    $.log('', `❌ ${$.name}, 失败! 原因: ${e}!`, '')
  })
  .finally(() => {
    $.done()
  })
// 获取东东农场 token
function getJdFactory() {
  return new Promise(resolve => {
    $.post(
      taskPostUrl('jdfactory_getTaskDetail', {}, 'jdfactory_getTaskDetail'),
      async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${JSON.stringify(err)}`)
            console.log(`$东东工厂 API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              if (data.data.bizCode === 0) {
                $.taskVos = data.data.result.taskVos //任务列表
                $.taskVos.map(item => {
                  if (item.taskType === 14) {
                    const taskToken = item.assistTaskDetailVo.taskToken
                    console.log(
                      `【账号${$.index}（${
                        $.nickName || $.UserName
                      }）东东工厂】${taskToken}`
                    )
                    let token = taskToken
                    submit_ddfactory_code.push(token)
                  }
                })
              }
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve()
        }
      }
    )
  })
}

function getJxFactory() {
  const JX_API_HOST = 'https://m.jingxi.com'

  function JXGC_taskurl(functionId, body = '') {
    return {
      url: `${JX_API_HOST}/dreamfactory/${functionId}?zone=dream_factory&${body}&sceneval=2&g_login_type=1&_time=${Date.now()}&_=${Date.now()}`,
      headers: {
        Cookie: cookie,
        Host: 'm.jingxi.com',
        Accept: '*/*',
        Connection: 'keep-alive',
        'User-Agent':
          'jdpingou;iPhone;3.14.4;14.0;ae75259f6ca8378672006fc41079cd8c90c53be8;network/wifi;model/iPhone10,2;appBuild/100351;ADID/00000000-0000-0000-0000-000000000000;supportApplePay/1;hasUPPay/0;pushNoticeIsOpen/1;hasOCPay/0;supportBestPay/0;session/62;pap/JA2015_311210;brand/apple;supportJDSHWK/1;Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
        'Accept-Language': 'zh-cn',
        Referer: 'https://wqsd.jd.com/pingou/dream_factory/index.html',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    }
  }

  return new Promise(resolve => {
    $.get(
      JXGC_taskurl(
        'userinfo/GetUserInfo',
        `pin=&sharePin=&shareType=&materialTuanPin=&materialTuanId=`
      ),
      async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${JSON.stringify(err)}`)
            console.log(`京喜工厂 API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              if (data['ret'] === 0) {
                data = data['data']
                $.unActive = true //标记是否开启了京喜活动或者选购了商品进行生产
                $.encryptPin = ''
                $.shelvesList = []
                if (data.factoryList && data.productionList) {
                  const production = data.productionList[0]
                  const factory = data.factoryList[0]
                  const productionStage = data.productionStage
                  $.factoryId = factory.factoryId //工厂ID
                  $.productionId = production.productionId //商品ID
                  $.commodityDimId = production.commodityDimId
                  $.encryptPin = data.user.encryptPin
                  // subTitle = data.user.pin;
                  console.log(
                    `【账号${$.index}（${$.nickName || $.UserName}）京喜工厂】${
                      data.user.encryptPin
                    }`
                  )
                  let token = data.user.encryptPin
                  submit_jxfactory_code.push(token)
                }
              } else {
                $.unActive = false //标记是否开启了京喜活动或者选购了商品进行生产
                if (!data.factoryList) {
                  console.log(
                    `【提示】京东账号${$.index}[${$.nickName}]京喜工厂活动未开始请手动去京东APP->游戏与互动->查看更多->京喜工厂 开启活动`
                  )
                } else if (data.factoryList && !data.productionList) {
                  console.log(
                    `【提示】京东账号${$.index}[${$.nickName}]京喜工厂未选购商品请手动去京东APP->游戏与互动->查看更多->京喜工厂 选购`
                  )
                }
              }
            } else {
              console.log(`GetUserInfo异常：${JSON.stringify(data)}`)
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve()
        }
      }
    )
  })
}

function getJxNc() {
  const JXNC_API_HOST = 'https://wq.jd.com/'

  function JXNC_taskurl(function_path, body) {
    return {
      url: `${JXNC_API_HOST}cubeactive/farm/${function_path}?${body}&farm_jstoken=&phoneid=&timestamp=&sceneval=2&g_login_type=1&_=${Date.now()}&g_ty=ls`,
      headers: {
        Cookie: cookie,
        Accept: `*/*`,
        Connection: `keep-alive`,
        Referer: `https://st.jingxi.com/pingou/dream_factory/index.html`,
        'Accept-Encoding': `gzip, deflate, br`,
        Host: `wq.jd.com`,
        'Accept-Language': `zh-cn`,
      },
    }
  }

  return new Promise(resolve => {
    $.get(JXNC_taskurl('query', `type=1`), async (err, resp, data) => {
      try {
        if (err) {
          console.log(`${JSON.stringify(err)}`)
          console.log(`京喜农场 API请求失败，请检查网路重试`)
        } else {
          data = data.match(/try\{Query\(([\s\S]*)\)\;\}catch\(e\)\{\}/)[1]
          if (safeGet(data)) {
            data = JSON.parse(data)
            if (data['ret'] === 0) {
              console.log(
                `【账号${$.index}（${
                  $.nickName || $.UserName
                }）京喜农场助力码】${data.smp}`
              )

              if (data.active) {
                console.log(
                  `【账号${$.index}（${
                    $.nickName || $.UserName
                  }）京喜农场active】${data.active}`
                )

                const rst = {
                  smp: data.smp,
                  active: data.active,
                  joinnum:data.joinnum
                }
                jdnc.push(JSON.stringify(rst))

              } else {
                console.log(
                  `【账号${$.index}（${
                    $.nickName || $.UserName
                  }）京喜农场】未选择种子，请先去京喜农场选择种子`
                )
              }
            }
          } else {
            console.log(`京喜农场返回值解析异常：${JSON.stringify(data)}`)
          }
        }
      } catch (e) {
        $.logErr(e, resp)
      } finally {
        resolve()
      }
    })
  })
}

function getJdPet() {
  const JDPet_API_HOST = 'https://api.m.jd.com/client.action'

  function jdPet_Url(function_id, body = {}) {
    body['version'] = 2
    body['channel'] = 'app'
    return {
      url: `${JDPet_API_HOST}?functionId=${function_id}`,
      body: `body=${escape(
        JSON.stringify(body)
      )}&appid=wh5&loginWQBiz=pet-town&clientVersion=9.0.4`,
      headers: {
        Cookie: cookie,
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0'
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
        Host: 'api.m.jd.com',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    }
  }
  return new Promise(resolve => {
    $.post(jdPet_Url('initPetTown'), async (err, resp, data) => {
      try {
        if (err) {
          console.log('东东萌宠: API查询请求失败 ‼️‼️')
          console.log(JSON.stringify(err))
          $.logErr(err)
        } else {
          data = JSON.parse(data)

          const initPetTownRes = data

          message = `【京东账号${$.index}】${$.nickName}`
          if (
            initPetTownRes.code === '0' &&
            initPetTownRes.resultCode === '0' &&
            initPetTownRes.message === 'success'
          ) {
            $.petInfo = initPetTownRes.result
            if ($.petInfo.userStatus === 0) {
              /*console.log(
                `【提示】京东账号${$.index}${$.nickName}萌宠活动未开启请手动去京东APP开启活动入口：我的->游戏与互动->查看更多开启`
              );*/
              return
            }

            console.log(
              `【账号${$.index}（${$.nickName || $.UserName}）京东萌宠】${
                $.petInfo.shareCode
              }`
            )
            let token = $.petInfo.shareCode
            submit_pet_code.push(token)
          } else if (initPetTownRes.code === '0') {
            console.log(`初始化萌宠失败:  ${initPetTownRes.message}`)
          } else {
            console.log('shit')
          }
        }
      } catch (e) {
        $.logErr(e, resp)
      } finally {
        resolve(data)
      }
    })
  })
}

async function getJdZZ() {
  const JDZZ_API_HOST = 'https://api.m.jd.com/client.action'

  function getUserInfo() {
    return new Promise(resolve => {
      $.get(taskZZUrl('interactIndex'), async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${JSON.stringify(err)}`)
            console.log(`${$.name} API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              if (data.data.shareTaskRes) {
                console.log(
                  `【账号${$.index}（${$.nickName || $.UserName}）京东赚赚】${
                    data.data.shareTaskRes.itemId
                  }`
                )
                let token = data.data.shareTaskRes.itemId
                jdzz.push(token)
              } else {
                console.log(
                  `【账号${$.index}（${
                    $.nickName || $.UserName
                  }）京东赚赚】已满5人助力或助力功能已下线,故暂时无好友助力码`
                )
              }
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve(data)
        }
      })
    })
  }

  function taskZZUrl(functionId, body = {}) {
    return {
      url: `${JDZZ_API_HOST}?functionId=${functionId}&body=${escape(
        JSON.stringify(body)
      )}&client=wh5&clientVersion=9.1.0`,
      headers: {
        Cookie: cookie,
        Host: 'api.m.jd.com',
        Connection: 'keep-alive',
        'Content-Type': 'application/json',
        Referer: 'http://wq.jd.com/wxapp/pages/hd-interaction/index/index',
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : require('./USER_AGENTS').USER_AGENT
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
        'Accept-Language': 'zh-cn',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    }
  }

  await getUserInfo()
}

async function getPlantBean() {
  const JDplant_API_HOST = 'https://api.m.jd.com/client.action'

  async function plantBeanIndex() {
    $.plantBeanIndexResult = await plant_request('plantBeanIndex') //plantBeanIndexBody
  }

  function plant_request(function_id, body = {}) {
    return new Promise(async resolve => {
      $.post(plant_taskUrl(function_id, body), (err, resp, data) => {
        try {
          if (err) {
            console.log('种豆得豆: API查询请求失败 ‼️‼️')
            console.log(`function_id:${function_id}`)
            $.logErr(err)
          } else {
            data = JSON.parse(data)
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve(data)
        }
      })
    })
  }

  function plant_taskUrl(function_id, body) {
    body['version'] = '9.0.0.1'
    body['monitor_source'] = 'plant_app_plant_index'
    body['monitor_refer'] = ''
    return {
      url: JDplant_API_HOST,
      body: `functionId=${function_id}&body=${escape(
        JSON.stringify(body)
      )}&appid=ld&client=apple&area=5_274_49707_49973&build=167283&clientVersion=9.1.0`,
      headers: {
        Cookie: cookie,
        Host: 'api.m.jd.com',
        Accept: '*/*',
        Connection: 'keep-alive',
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0'
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
        'Accept-Language': 'zh-Hans-CN;q=1,en-CN;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    }
  }

  function getParam(url, name) {
    const reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
    const r = url.match(reg)
    if (r != null) return unescape(r[2])
    return null
  }

  async function jdPlantBean() {
    await plantBeanIndex()
    // console.log(plantBeanIndexResult.data.taskList);
    if ($.plantBeanIndexResult.code === '0') {
      const shareUrl = $.plantBeanIndexResult.data.jwordShareInfo.shareUrl
      $.myPlantUuid = getParam(shareUrl, 'plantUuid')
      console.log(
        `【账号${$.index}（${$.nickName || $.UserName}）种豆得豆】${
          $.myPlantUuid
        }`
      )
      let token = $.myPlantUuid
      submit_bean_code.push(token)
    } else {
      console.log(
        `种豆得豆-初始失败:  ${JSON.stringify($.plantBeanIndexResult)}`
      )
    }
  }

  await jdPlantBean()
}
async function getJDFruit() {
  async function initForFarm() {
    return new Promise(resolve => {
      const option = {
        url: `${JD_API_HOST}?functionId=initForFarm`,
        body: `body=${escape(
          JSON.stringify({ version: 4 })
        )}&appid=wh5&clientVersion=9.1.0`,
        headers: {
          accept: '*/*',
          'accept-encoding': 'gzip, deflate, br',
          'accept-language': 'zh-CN,zh;q=0.9',
          'cache-control': 'no-cache',
          cookie: cookie,
          origin: 'https://home.m.jd.com',
          pragma: 'no-cache',
          referer: 'https://home.m.jd.com/myJd/newhome.action',
          'sec-fetch-dest': 'empty',
          'sec-fetch-mode': 'cors',
          'sec-fetch-site': 'same-site',
          'User-Agent': $.isNode()
            ? process.env.JD_USER_AGENT
              ? process.env.JD_USER_AGENT
              : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0'
            : $.getdata('JDUA')
            ? $.getdata('JDUA')
            : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      }
      $.post(option, (err, resp, data) => {
        try {
          if (err) {
            console.log('东东农场: API查询请求失败 ‼️‼️')
            console.log(JSON.stringify(err))
            $.logErr(err)
          } else {
            if (safeGet(data)) {
              $.farmInfo = JSON.parse(data)
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve()
        }
      })
    })
  }

  async function jdFruit() {
    await initForFarm()
    if ($.farmInfo.farmUserPro) {
      console.log(
        `【账号${$.index}（${$.nickName || $.UserName}）京东农场】${
          $.farmInfo.farmUserPro.shareCode
        }`
      )
      let token = $.farmInfo.farmUserPro.shareCode
      submit_farm_code.push(token)
    } else {
      /*console.log(
        `初始化农场数据异常, 请登录京东 app查看农场0元水果功能是否正常,农场初始化数据: ${JSON.stringify(
          $.farmInfo
        )}`
      );*/
    }
  }

  await jdFruit()
}
async function getJoy() {
  function taskUrl(functionId, body = '') {
    let t = Date.now().toString().substr(0, 10)
    let e = body || ''
    e = $.md5('aDvScBv$gGQvrXfva8dG!ZC@DA70Y%lX' + e + t)
    e = e + Number(t).toString(16)
    return {
      url: `${JD_API_HOST}?uts=${e}&appid=crazy_joy&functionId=${functionId}&body=${escape(
        body
      )}&t=${t}`,
      headers: {
        Cookie: cookie,
        Host: 'api.m.jd.com',
        Accept: '*/*',
        Connection: 'keep-alive',
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : require('./USER_AGENTS').USER_AGENT
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
        'Accept-Language': 'zh-cn',
        Referer: 'https://crazy-joy.jd.com/',
        origin: 'https://crazy-joy.jd.com',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    }
  }
  let body = { paramData: {} }
  return new Promise(async resolve => {
    $.get(
      taskUrl('crazyJoy_user_gameState', JSON.stringify(body)),
      async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${JSON.stringify(err)}`)
            console.log(`${$.name} API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              if (data.success && data.data && data.data.userInviteCode) {
                console.log(
                  `【账号${$.index}（${$.nickName || $.UserName}）crazyJoy】${
                    data.data.userInviteCode
                  }`
                )
                let token = data.data.userInviteCode
                jdcrazyjoy.push(token)
              }
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve()
        }
      }
    )
  })
}
// 年兽
async function getJdNS() {
  function getUserInfo(body = {}) {
    return new Promise(resolve => {
      $.post(
        taskPostUrl('nian_getTaskDetail', body, 'nian_getTaskDetail'),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${JSON.stringify(err)}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.data.bizCode === 0) {
                  if (JSON.stringify(body) === '{}') {
                    let token = data.data.result.inviteId
                    console.log(
                      `【账号${$.index}（${
                        $.nickName || $.UserName
                      }）京东年兽】${token}`
                    )
                    jdnian.push(token)
                  }
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }

  await getUserInfo()
}
// 京东年货
async function getJdNH() {
  const ACT_ID = 'dzvm210168869301'
  let shareUuid = 'd8e13cf24701413d8776a7d726309626'

  function getIsvToken() {
    let config = {
      url: 'https://api.m.jd.com/client.action?functionId=genToken',
      body:
        'body=%7B%22to%22%3A%22https%3A%5C%2F%5C%2Flzdz-isv.isvjcloud.com%5C%2Fdingzhi%5C%2Fvm%5C%2Ftemplate%5C%2Factivity%5C%2F940531%3FactivityId%3Ddzvm210168869301%22%2C%22action%22%3A%22to%22%7D&build=167490&client=apple&clientVersion=9.3.2&openudid=53f4d9c70c1c81f1c8769d2fe2fef0190a3f60d2&sign=11c092269dfa11a21fec29b3a844c752&st=1610417332242&sv=112',
      headers: {
        Host: 'api.m.jd.com',
        accept: '*/*',
        'user-agent': 'JD4iPhone/167490 (iPhone; iOS 14.2; Scale/3.00)',
        'accept-language':
          'zh-Hans-JP;q=1, en-JP;q=0.9, zh-Hant-TW;q=0.8, ja-JP;q=0.7, en-US;q=0.6',
        'content-type': 'application/x-www-form-urlencoded',
        Cookie: cookie,
      },
    }
    return new Promise(resolve => {
      $.post(config, async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${err}`)
            console.log(`${$.name} API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              $.isvToken = data.tokenKey
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve(data)
        }
      })
    })
  }
  function getIsvToken2() {
    let config = {
      url: 'https://api.m.jd.com/client.action?functionId=isvObfuscator',
      body:
        'body=%7B%22url%22%3A%22https%3A%5C%2F%5C%2Flzdz-isv.isvjcloud.com%22%2C%22id%22%3A%22%22%7D&build=167490&client=apple&clientVersion=9.3.2&openudid=53f4d9c70c1c81f1c8769d2fe2fef0190a3f60d2&sign=a65279303b19bf51c17e7dbfdea85dd3&st=1610417332632&sv=112',
      headers: {
        Host: 'api.m.jd.com',
        accept: '*/*',
        'user-agent': 'JD4iPhone/167490 (iPhone; iOS 14.2; Scale/3.00)',
        'accept-language':
          'zh-Hans-JP;q=1, en-JP;q=0.9, zh-Hant-TW;q=0.8, ja-JP;q=0.7, en-US;q=0.6',
        'content-type': 'application/x-www-form-urlencoded',
        Cookie: cookie,
      },
    }
    return new Promise(resolve => {
      $.post(config, async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${err}`)
            console.log(`${$.name} API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              $.token2 = data.token
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve(data)
        }
      })
    })
  }
  // 获得游戏的Cookie
  function getActCk() {
    return new Promise(resolve => {
      $.get(
        taskUrl('dingzhi/vm/template/activity/940531', `activityId=${ACT_ID}`),
        (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              cookie = `${cookie};`
              if ($.isNode())
                for (let ck of resp['headers']['set-cookie']) {
                  cookie = `${cookie} ${ck.split(';')[0]};`
                }
              else {
                for (let ck of resp['headers']['Set-Cookie'].split(',')) {
                  cookie = `${cookie} ${ck.split(';')[0]};`
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }
  // 获得游戏信息
  function getActInfo() {
    return new Promise(resolve => {
      $.post(
        taskPostUrl('dz/common/getSimpleActInfoVo', `activityId=${ACT_ID}`),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.result) {
                  $.shopId = data.data.shopId
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }

  function taskUrl(function_id, body) {
    return {
      url: `https://lzdz-isv.isvjcloud.com/${function_id}?${body}`,
      headers: {
        Host: 'lzdz-isv.isvjcloud.com',
        Accept: 'application/x.jd-school-island.v1+json',
        Source: '02',
        'Accept-Language': 'zh-cn',
        'Content-Type': 'application/json;charset=utf-8',
        Origin: 'https://lzdz-isv.isvjcloud.com',
        'User-Agent': 'JD4iPhone/167490 (iPhone; iOS 14.2; Scale/3.00)',
        Referer: `https://lzdz-isv.isvjcloud.com/dingzhi/book/develop/activity?activityId=${ACT_ID}`,
        Cookie: `${cookie} IsvToken=${$.isvToken};`,
      },
    }
  }
  function taskPostUrl(function_id, body) {
    return {
      url: `https://lzdz-isv.isvjcloud.com/${function_id}`,
      body: body,
      headers: {
        Host: 'lzdz-isv.isvjcloud.com',
        Accept: 'application/json',
        'Accept-Language': 'zh-cn',
        'Content-Type': 'application/x-www-form-urlencoded',
        Origin: 'https://lzdz-isv.isvjcloud.com',
        'User-Agent': 'JD4iPhone/167490 (iPhone; iOS 14.2; Scale/3.00)',
        Referer: `https://lzdz-isv.isvjcloud.com/dingzhi/book/develop/activity?activityId=${ACT_ID}`,
        Cookie: `${cookie} isvToken=${$.isvToken};`,
      },
    }
  }

  function getActInfo() {
    return new Promise(resolve => {
      $.post(
        taskPostUrl('dz/common/getSimpleActInfoVo', `activityId=${ACT_ID}`),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.result) {
                  $.shopId = data.data.shopId
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }

  function getMyPing() {
    return new Promise(resolve => {
      $.post(
        taskPostUrl(
          'customer/getMyPing',
          `userId=${$.shopId}&token=${$.token2}&fromType=APP`
        ),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.result) {
                  $.pin = data.data.secretPin
                  cookie = `${cookie} AUTH_C_USER=${$.pin}`
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }

  function getUserInfo() {
    return new Promise(resolve => {
      let body = `pin=${encodeURIComponent($.pin)}`
      $.post(
        taskPostUrl('wxActionCommon/getUserInfo', body),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.data) {
                  $.userId = data.data.id
                  $.pinImg = data.data.yunMidImageUrl
                  $.nick = data.data.nickname
                } else {
                  console.log(data)
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }

  function getActContent(info = false, shareUuid = '') {
    return new Promise(resolve => {
      $.post(
        taskPostUrl(
          'dingzhi/vm/template/activityContent',
          `activityId=${ACT_ID}&pin=${encodeURIComponent($.pin)}&pinImg=${
            $.pinImg
          }&nick=${$.nick}&cjyxPin=&cjhyPin=&shareUuid=${shareUuid}`
        ),
        async (err, resp, data) => {
          try {
            if (err) {
              console.log(`${err}`)
              console.log(`${$.name} API请求失败，请检查网路重试`)
            } else {
              if (safeGet(data)) {
                data = JSON.parse(data)
                if (data.data) {
                  $.actorUuid = data.data.actorUuid

                  if (!info) {
                    console.log(`您的好友助力码为${$.actorUuid}`)
                    let token = $.actorUuid
                    console.log(
                      `【账号${$.index}（${
                        $.nickName || $.UserName
                      }）京东年货节】${token}`
                    )
                    jdnh.push(token)
                  }
                }
              }
            }
          } catch (e) {
            $.logErr(e, resp)
          } finally {
            resolve(data)
          }
        }
      )
    })
  }
  await getIsvToken()
  await getIsvToken2()
  await getActCk()
  await getActInfo()
  await getMyPing()
  await getUserInfo()
  await getActContent(false, shareUuid)
}
// jd签到领现金
async function getJDCase() {
  const JD_API_HOST = 'https://api.m.jd.com/client.action'

  function getUserInfo() {
    return new Promise(resolve => {
      $.get(taskUrl('cash_mob_home'), async (err, resp, data) => {
        try {
          if (err) {
            console.log(`${JSON.stringify(err)}`)
            console.log(`${$.name} API请求失败，请检查网路重试`)
          } else {
            if (safeGet(data)) {
              data = JSON.parse(data)
              if (data.code === 0 && data.data.result) {
                console.log(
                  `【账号${$.index}（${
                    $.nickName || $.UserName
                  }）京东签到领现金】${data.data.result.inviteCode}`
                )
                jdcash.push(data.data.result.inviteCode)
              }
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve(data)
        }
      })
    })
  }

  function taskUrl(functionId, body = {}) {
    return {
      url: `${JD_API_HOST}?functionId=${functionId}&body=${escape(
        JSON.stringify(body)
      )}&appid=CashRewardMiniH5Env&appid=9.1.0`,
      headers: {
        Cookie: cookie,
        Host: 'api.m.jd.com',
        Connection: 'keep-alive',
        'Content-Type': 'application/json',
        Referer: 'http://wq.jd.com/wxapp/pages/hd-interaction/index/index',
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : require('./USER_AGENTS').USER_AGENT
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
        'Accept-Language': 'zh-cn',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    }
  }

  await getUserInfo()
}
//闪购盲盒
async function getSgmh(timeout = 0) {
  return new Promise(resolve => {
    setTimeout(() => {
      let url = {
        url: `https://api.m.jd.com/client.action`,
        headers: {
          Origin: `https://h5.m.jd.com`,
          Cookie: cookie,
          Connection: `keep-alive`,
          Accept: `application/json, text/plain, */*`,
          Referer: `https://h5.m.jd.com/babelDiy/Zeus/2WBcKYkn8viyxv7MoKKgfzmu7Dss/index.html`,
          Host: `api.m.jd.com`,
          'Accept-Encoding': `gzip, deflate, br`,
          'Accept-Language': `zh-cn`,
        },
        body: `functionId=interact_template_getHomeData&body={"appId":"1EFRRxA","taskToken":""}&client=wh5&clientVersion=1.0.0`,
      }

      $.post(url, async (err, resp, data) => {
        try {
          if (safeGet(data)) {
            data = JSON.parse(data)
            if (data.data.bizCode === 0) {
              for (let i = 0; i < data.data.result.taskVos.length; i++) {
                if (data.data.result.taskVos[i].taskName === '邀人助力任务') {
                  console.log(
                    `【账号${$.index}（${$.nickName || $.UserName}）闪购盲盒】${
                      data.data.result.taskVos[i].assistTaskDetailVo.taskToken
                    }`
                  )
                  jdSgmh.push(
                    data.data.result.taskVos[i].assistTaskDetailVo.taskToken
                  )
                }
              }
            }
          }
        } catch (e) {
          $.logErr(e, resp)
        } finally {
          resolve()
        }
      })
    }, timeout)
  })
}

// @Turing Lab Bot
let submit_bean_code = [] // 种豆得豆
let submit_farm_code = [] // 东东农场互助码
let submit_pet_code = [] // 东东萌宠
let submit_jxfactory_code = [] // 京喜工厂互助码
let submit_ddfactory_code = [] // 东东工厂互助码

// Commit Code Bot
let jdcash = [] // 京东 签到领现金
let jdcrazyjoy = [] // crazy joy
// let jdnh = [] // JD年货
let jdzz = [] // JD赚赚
// let jdnian = [] // JD炸年兽

let jdSgmh = [] // 闪购盲盒

let jdnc = [] // 京喜农场

function formatForJDFreeFuck(
  arr = [],
  name = '',
  itemName = '',
  forOtherName = ''
) {
  console.log(`# ${name}`)
  const nameArr = []
  for (let i = 0; i < arr.length; i++) {
    const item = arr[i]
    console.log(`${itemName}${i + 1}='${item}'`)
    const name = '${' + itemName + (i + 1) + '}'
    nameArr.push(name)
  }

  // 以 种豆得豆 个数 为准 循环 生成 other互助  补齐 没有 互助码的号 的互助 名额
  for (let m = 0; m < submit_bean_code.length; m++) {
    // for (let m = 0; m < nameArr.length; m++) {
    // const item = nameArr[m]
    // console.log(
    //   `${forOtherName}${m + 1}='${nameArr
    //     .filter(cell => cell !== item)
    //     .join('@')}'`
    // )
    console.log(`${forOtherName}${m + 1}='${nameArr.join('@')}'`)
  }
}

function getRandomArrayElements(arr, count = 4) {
  if (arr.length === 0) {
    return arr
  } else {
    let shuffled = arr.slice(0),
      i = arr.length,
      min = i - count,
      temp,
      index
    while (i-- > min) {
      index = Math.floor((i + 1) * Math.random())
      temp = shuffled[index]
      shuffled[index] = shuffled[i]
      shuffled[i] = temp
    }
    const res = [arr[0], ...shuffled.slice(min)]
    return [...new Set(res)]
  }
}

function showFormatMsg() {
  console.log(
    `\n========== 【格式化互助码只留随机4-5个(一定有第一个)】 ==========`
  )
  console.log(`\n提交机器人 @Turing Lab Bot\n`)
  console.log(
    `/submit_activity_codes bean ${getRandomArrayElements(
      submit_bean_code
    ).join('&')}\n`
  )
  console.log(
    `/submit_activity_codes farm ${getRandomArrayElements(
      submit_farm_code
    ).join('&')}\n`
  )
  console.log(
    `/submit_activity_codes pet ${getRandomArrayElements(submit_pet_code).join(
      '&'
    )}\n`
  )
  console.log(
    `/submit_activity_codes jxfactory ${getRandomArrayElements(
      submit_jxfactory_code
    ).join('&')}\n`
  )
  console.log(
    `/submit_activity_codes ddfactory ${getRandomArrayElements(
      submit_ddfactory_code
    ).join('&')}\n`
  )
  // 临时活动
  console.log(
    `/submit_activity_codes sgmh ${getRandomArrayElements(jdSgmh).join('&')}\n`
  )

  console.log(`\n提交机器人 @Commit Code Bot\n`)
  console.log(`/jdcash ${getRandomArrayElements(jdcash).join('&')}\n`)
  console.log(`/jdcrazyjoy ${getRandomArrayElements(jdcrazyjoy).join('&')}\n`)
  // console.log(`/jdnh ${jdnh.join('&')}\n`)
  console.log(`/jdzz ${getRandomArrayElements(jdzz).join('&')}\n`)
  // console.log(`/jdnian ${jdnian.join('&')}\n`)

  console.log(`\n========== 【格式化互助码for docker ==========`)
  formatForJDFreeFuck(submit_bean_code, '种豆得豆', 'MyBean', 'ForOtherBean')
  formatForJDFreeFuck(submit_farm_code, '东东农场', 'MyFruit', 'ForOtherFruit')
  formatForJDFreeFuck(submit_pet_code, '东东萌宠', 'MyPet', 'ForOtherPet')
  formatForJDFreeFuck(jdnc, '京喜农场', 'MyJxnc', 'ForOtherJxnc')
  formatForJDFreeFuck(
    submit_jxfactory_code,
    '京喜工厂',
    'MyDreamFactory',
    'ForOtherDreamFactory'
  )
  formatForJDFreeFuck(
    submit_ddfactory_code,
    '东东工厂',
    'MyJdFactory',
    'ForOtherJdFactory'
  )
  formatForJDFreeFuck(jdcash, '签到领现金', 'MyCash', 'ForOtherCash')
  formatForJDFreeFuck(jdcrazyjoy, 'crazy joy', 'MyJoy', 'ForOtherJoy')
  formatForJDFreeFuck(jdSgmh, '闪购盲盒', 'MySgmh', 'ForOtherSgmh')
}

async function getShareCodeAndAdd() {
  console.log(`======账号${$.index}开始======`)
  await getJdFactory() // 东东工厂
  await getJxFactory() // 京喜工厂
  await getJxNc() // 京喜农场
  await getJdPet() // 东东萌宠
  await getPlantBean() // 种豆得豆
  await getJDFruit() // 京东农场
  await getJdZZ() // 京东赚赚
  await getJoy() // CrazyJoy
  // await getJdNS() // 年兽
  // await getJdNH() // 京东年货
  await getJDCase() // 京东签到领现金
  await getSgmh() // 闪购盲盒
  console.log(`======账号${$.index}结束======\n`)
}

function safeGet(data) {
  try {
    if (typeof JSON.parse(data) == 'object') {
      return true
    }
  } catch (e) {
    console.log(e)
    console.log(`京东服务器访问数据为空，请检查自身设备网络情况`)
    return false
  }
}
function TotalBean() {
  return new Promise(async resolve => {
    const options = {
      url: `https://wq.jd.com/user/info/QueryJDUserInfo?sceneval=2`,
      headers: {
        Accept: 'application/json,text/plain, */*',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-cn',
        Connection: 'keep-alive',
        Cookie: cookie,
        Referer: 'https://wqs.jd.com/my/jingdou/my.shtml?sceneval=2',
        'User-Agent': $.isNode()
          ? process.env.JD_USER_AGENT
            ? process.env.JD_USER_AGENT
            : require('./USER_AGENTS').USER_AGENT
          : $.getdata('JDUA')
          ? $.getdata('JDUA')
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
      },
    }
    $.post(options, (err, resp, data) => {
      try {
        if (err) {
          console.log(`${JSON.stringify(err)}`)
          console.log(`${$.name} API请求失败，请检查网路重试`)
        } else {
          if (data) {
            data = JSON.parse(data)
            if (data['retcode'] === 13) {
              $.isLogin = false //cookie过期
              return
            }
            $.nickName = data['base'].nickname
          } else {
            console.log(`京东服务器返回空数据`)
          }
        }
      } catch (e) {
        $.logErr(e, resp)
      } finally {
        resolve()
      }
    })
  })
}
function taskPostUrl(function_id, body = {}, function_id2) {
  let url = `${JD_API_HOST}`
  if (function_id2) {
    url += `?functionId=${function_id2}`
  }
  return {
    url,
    body: `functionId=${function_id}&body=${escape(
      JSON.stringify(body)
    )}&client=wh5&clientVersion=9.1.0`,
    headers: {
      Cookie: cookie,
      origin: 'https://h5.m.jd.com',
      referer: 'https://h5.m.jd.com/',
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent': $.isNode()
        ? process.env.JD_USER_AGENT
          ? process.env.JD_USER_AGENT
          : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0'
        : $.getdata('JDUA')
        ? $.getdata('JDUA')
        : 'jdapp;iPhone;9.2.2;14.2;%E4%BA%AC%E4%B8%9C/9.2.2 CFNetwork/1206 Darwin/20.1.0',
    },
  }
}
function jsonParse(str) {
  if (typeof str == 'string') {
    try {
      return JSON.parse(str)
    } catch (e) {
      console.log(e)
      $.msg($.name, '', '不要在BoxJS手动复制粘贴修改cookie')
      return []
    }
  }
}
// prettier-ignore
function Env(t,e){class s{constructor(t){this.env=t}send(t,e="GET"){t="string"==typeof t?{url:t}:t;let s=this.get;return"POST"===e&&(s=this.post),new Promise((e,i)=>{s.call(this,t,(t,s,r)=>{t?i(t):e(s)})})}get(t){return this.send.call(this.env,t)}post(t){return this.send.call(this.env,t,"POST")}}return new class{constructor(t,e){this.name=t,this.http=new s(this),this.data=null,this.dataFile="box.dat",this.logs=[],this.isMute=!1,this.isNeedRewrite=!1,this.logSeparator="\n",this.startTime=(new Date).getTime(),Object.assign(this,e),this.log("",`\ud83d\udd14${this.name}, \u5f00\u59cb!`)}isNode(){return"undefined"!=typeof module&&!!module.exports}isQuanX(){return"undefined"!=typeof $task}isSurge(){return"undefined"!=typeof $httpClient&&"undefined"==typeof $loon}isLoon(){return"undefined"!=typeof $loon}toObj(t,e=null){try{return JSON.parse(t)}catch{return e}}toStr(t,e=null){try{return JSON.stringify(t)}catch{return e}}getjson(t,e){let s=e;const i=this.getdata(t);if(i)try{s=JSON.parse(this.getdata(t))}catch{}return s}setjson(t,e){try{return this.setdata(JSON.stringify(t),e)}catch{return!1}}getScript(t){return new Promise(e=>{this.get({url:t},(t,s,i)=>e(i))})}runScript(t,e){return new Promise(s=>{let i=this.getdata("@chavy_boxjs_userCfgs.httpapi");i=i?i.replace(/\n/g,"").trim():i;let r=this.getdata("@chavy_boxjs_userCfgs.httpapi_timeout");r=r?1*r:20,r=e&&e.timeout?e.timeout:r;const[o,h]=i.split("@"),a={url:`http://${h}/v1/scripting/evaluate`,body:{script_text:t,mock_type:"cron",timeout:r},headers:{"X-Key":o,Accept:"*/*"}};this.post(a,(t,e,i)=>s(i))}).catch(t=>this.logErr(t))}loaddata(){if(!this.isNode())return{};{this.fs=this.fs?this.fs:require("fs"),this.path=this.path?this.path:require("path");const t=this.path.resolve(this.dataFile),e=this.path.resolve(process.cwd(),this.dataFile),s=this.fs.existsSync(t),i=!s&&this.fs.existsSync(e);if(!s&&!i)return{};{const i=s?t:e;try{return JSON.parse(this.fs.readFileSync(i))}catch(t){return{}}}}}writedata(){if(this.isNode()){this.fs=this.fs?this.fs:require("fs"),this.path=this.path?this.path:require("path");const t=this.path.resolve(this.dataFile),e=this.path.resolve(process.cwd(),this.dataFile),s=this.fs.existsSync(t),i=!s&&this.fs.existsSync(e),r=JSON.stringify(this.data);s?this.fs.writeFileSync(t,r):i?this.fs.writeFileSync(e,r):this.fs.writeFileSync(t,r)}}lodash_get(t,e,s){const i=e.replace(/\[(\d+)\]/g,".$1").split(".");let r=t;for(const t of i)if(r=Object(r)[t],void 0===r)return s;return r}lodash_set(t,e,s){return Object(t)!==t?t:(Array.isArray(e)||(e=e.toString().match(/[^.[\]]+/g)||[]),e.slice(0,-1).reduce((t,s,i)=>Object(t[s])===t[s]?t[s]:t[s]=Math.abs(e[i+1])>>0==+e[i+1]?[]:{},t)[e[e.length-1]]=s,t)}getdata(t){let e=this.getval(t);if(/^@/.test(t)){const[,s,i]=/^@(.*?)\.(.*?)$/.exec(t),r=s?this.getval(s):"";if(r)try{const t=JSON.parse(r);e=t?this.lodash_get(t,i,""):e}catch(t){e=""}}return e}setdata(t,e){let s=!1;if(/^@/.test(e)){const[,i,r]=/^@(.*?)\.(.*?)$/.exec(e),o=this.getval(i),h=i?"null"===o?null:o||"{}":"{}";try{const e=JSON.parse(h);this.lodash_set(e,r,t),s=this.setval(JSON.stringify(e),i)}catch(e){const o={};this.lodash_set(o,r,t),s=this.setval(JSON.stringify(o),i)}}else s=this.setval(t,e);return s}getval(t){return this.isSurge()||this.isLoon()?$persistentStore.read(t):this.isQuanX()?$prefs.valueForKey(t):this.isNode()?(this.data=this.loaddata(),this.data[t]):this.data&&this.data[t]||null}setval(t,e){return this.isSurge()||this.isLoon()?$persistentStore.write(t,e):this.isQuanX()?$prefs.setValueForKey(t,e):this.isNode()?(this.data=this.loaddata(),this.data[e]=t,this.writedata(),!0):this.data&&this.data[e]||null}initGotEnv(t){this.got=this.got?this.got:require("got"),this.cktough=this.cktough?this.cktough:require("tough-cookie"),this.ckjar=this.ckjar?this.ckjar:new this.cktough.CookieJar,t&&(t.headers=t.headers?t.headers:{},void 0===t.headers.Cookie&&void 0===t.cookieJar&&(t.cookieJar=this.ckjar))}get(t,e=(()=>{})){t.headers&&(delete t.headers["Content-Type"],delete t.headers["Content-Length"]),this.isSurge()||this.isLoon()?(this.isSurge()&&this.isNeedRewrite&&(t.headers=t.headers||{},Object.assign(t.headers,{"X-Surge-Skip-Scripting":!1})),$httpClient.get(t,(t,s,i)=>{!t&&s&&(s.body=i,s.statusCode=s.status),e(t,s,i)})):this.isQuanX()?(this.isNeedRewrite&&(t.opts=t.opts||{},Object.assign(t.opts,{hints:!1})),$task.fetch(t).then(t=>{const{statusCode:s,statusCode:i,headers:r,body:o}=t;e(null,{status:s,statusCode:i,headers:r,body:o},o)},t=>e(t))):this.isNode()&&(this.initGotEnv(t),this.got(t).on("redirect",(t,e)=>{try{if(t.headers["set-cookie"]){const s=t.headers["set-cookie"].map(this.cktough.Cookie.parse).toString();this.ckjar.setCookieSync(s,null),e.cookieJar=this.ckjar}}catch(t){this.logErr(t)}}).then(t=>{const{statusCode:s,statusCode:i,headers:r,body:o}=t;e(null,{status:s,statusCode:i,headers:r,body:o},o)},t=>{const{message:s,response:i}=t;e(s,i,i&&i.body)}))}post(t,e=(()=>{})){if(t.body&&t.headers&&!t.headers["Content-Type"]&&(t.headers["Content-Type"]="application/x-www-form-urlencoded"),t.headers&&delete t.headers["Content-Length"],this.isSurge()||this.isLoon())this.isSurge()&&this.isNeedRewrite&&(t.headers=t.headers||{},Object.assign(t.headers,{"X-Surge-Skip-Scripting":!1})),$httpClient.post(t,(t,s,i)=>{!t&&s&&(s.body=i,s.statusCode=s.status),e(t,s,i)});else if(this.isQuanX())t.method="POST",this.isNeedRewrite&&(t.opts=t.opts||{},Object.assign(t.opts,{hints:!1})),$task.fetch(t).then(t=>{const{statusCode:s,statusCode:i,headers:r,body:o}=t;e(null,{status:s,statusCode:i,headers:r,body:o},o)},t=>e(t));else if(this.isNode()){this.initGotEnv(t);const{url:s,...i}=t;this.got.post(s,i).then(t=>{const{statusCode:s,statusCode:i,headers:r,body:o}=t;e(null,{status:s,statusCode:i,headers:r,body:o},o)},t=>{const{message:s,response:i}=t;e(s,i,i&&i.body)})}}time(t){let e={"M+":(new Date).getMonth()+1,"d+":(new Date).getDate(),"H+":(new Date).getHours(),"m+":(new Date).getMinutes(),"s+":(new Date).getSeconds(),"q+":Math.floor(((new Date).getMonth()+3)/3),S:(new Date).getMilliseconds()};/(y+)/.test(t)&&(t=t.replace(RegExp.$1,((new Date).getFullYear()+"").substr(4-RegExp.$1.length)));for(let s in e)new RegExp("("+s+")").test(t)&&(t=t.replace(RegExp.$1,1==RegExp.$1.length?e[s]:("00"+e[s]).substr((""+e[s]).length)));return t}msg(e=t,s="",i="",r){const o=t=>{if(!t)return t;if("string"==typeof t)return this.isLoon()?t:this.isQuanX()?{"open-url":t}:this.isSurge()?{url:t}:void 0;if("object"==typeof t){if(this.isLoon()){let e=t.openUrl||t.url||t["open-url"],s=t.mediaUrl||t["media-url"];return{openUrl:e,mediaUrl:s}}if(this.isQuanX()){let e=t["open-url"]||t.url||t.openUrl,s=t["media-url"]||t.mediaUrl;return{"open-url":e,"media-url":s}}if(this.isSurge()){let e=t.url||t.openUrl||t["open-url"];return{url:e}}}};this.isMute||(this.isSurge()||this.isLoon()?$notification.post(e,s,i,o(r)):this.isQuanX()&&$notify(e,s,i,o(r)));let h=["","==============\ud83d\udce3\u7cfb\u7edf\u901a\u77e5\ud83d\udce3=============="];h.push(e),s&&h.push(s),i&&h.push(i),console.log(h.join("\n")),this.logs=this.logs.concat(h)}log(...t){t.length>0&&(this.logs=[...this.logs,...t]),console.log(t.join(this.logSeparator))}logErr(t,e){const s=!this.isSurge()&&!this.isQuanX()&&!this.isLoon();s?this.log("",`\u2757\ufe0f${this.name}, \u9519\u8bef!`,t.stack):this.log("",`\u2757\ufe0f${this.name}, \u9519\u8bef!`,t)}wait(t){return new Promise(e=>setTimeout(e,t))}done(t={}){const e=(new Date).getTime(),s=(e-this.startTime)/1e3;this.log("",`\ud83d\udd14${this.name}, \u7ed3\u675f! \ud83d\udd5b ${s} \u79d2`),this.log(),(this.isSurge()||this.isQuanX()||this.isLoon())&&$done(t)}}(t,e)}

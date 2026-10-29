# What runs today at Porkbun, imported into this stack's state (AGENTS.md « Import before change »).
# `<domain>:<record id>`; the ids are not secrets. `tofu plan` imports them in the plan only.
import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "krizaka.com:551816370"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["blog-cname"]
  id = "krizaka.com:594888777"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["java-cname"]
  id = "krizaka.com:594387015"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["lab-cname"]
  id = "krizaka.com:598946764"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["ts-cname"]
  id = "krizaka.com:597127514"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["ui-cname"]
  id = "krizaka.com:594397942"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["www-cname"]
  id = "krizaka.com:591607191"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "krizaka.com:597087325"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "krizaka.com:597087330"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "krizaka.com:597087336"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "krizaka.com:596353040"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "krizaka.com:592336665"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-3"]
  id = "krizaka.com:596355405"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["gh-krizaka-o-txt"]
  id = "krizaka.com:596356986"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "krizaka.com:597248720"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "krizaka.com:597248718"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "krizaka.com:551816361"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "krizaka.com:551816360"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "krizaka.com:551816358"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "krizaka.com:551816359"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "orazaka.com:596640594"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["admin-cname"]
  id = "orazaka.com:594366214"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["broker-dev-a"]
  id = "orazaka.com:594427139"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["dev-cname"]
  id = "orazaka.com:594318496"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["www-cname"]
  id = "orazaka.com:596640589"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "orazaka.com:591862596"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "orazaka.com:591862597"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "orazaka.com:591862598"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "orazaka.com:596353048"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "orazaka.com:596355414"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "orazaka.com:591862772"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "orazaka.com:591862787"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "orazaka.com:591862595"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "orazaka.com:591862594"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "orazaka.com:591862592"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "orazaka.com:591862593"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-alias"]
  id = "orochia.com:596647457"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["admin-cname"]
  id = "orochia.com:594362208"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["dev-cname"]
  id = "orochia.com:591923334"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["www-cname"]
  id = "orochia.com:596647442"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "orochia.com:591446823"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "orochia.com:591446824"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "orochia.com:591446825"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "orochia.com:596353058"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["resend--domainkey-mg-txt"]
  id = "orochia.com:591935413"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["rsend-mg-cname"]
  id = "orochia.com:591935117"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["send-mg-cname"]
  id = "orochia.com:591934846"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "orochia.com:596355418"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "orochia.com:591446972"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "orochia.com:591446977"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "orochia.com:591446822"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "orochia.com:591446821"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "orochia.com:591446819"
}

import {
  to = module.dns_porkbun["orochia.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "orochia.com:591446820"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "yomizaka.com:596621902"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["admin-cname"]
  id = "yomizaka.com:594527374"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["dev-cname"]
  id = "yomizaka.com:594500509"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["www-cname"]
  id = "yomizaka.com:596621889"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "yomizaka.com:594465256"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "yomizaka.com:594465257"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "yomizaka.com:594465258"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "yomizaka.com:596353082"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "yomizaka.com:596355459"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "yomizaka.com:594465379"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "yomizaka.com:594465376"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "yomizaka.com:594465255"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "yomizaka.com:594465254"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "yomizaka.com:594465252"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "yomizaka.com:594465253"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-alias"]
  id = "akinaza.com:596619430"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["wildcard-cname"]
  id = "akinaza.com:597052805"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["admin-cname"]
  id = "akinaza.com:594810894"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["dev-cname"]
  id = "akinaza.com:594800325"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["www-cname"]
  id = "akinaza.com:596619424"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "akinaza.com:594550444"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "akinaza.com:594550445"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-txt"]
  id = "akinaza.com:594550446"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "akinaza.com:597052812"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "akinaza.com:594553095"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-3"]
  id = "akinaza.com:594553104"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "akinaza.com:594550443"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "akinaza.com:594550442"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "akinaza.com:594550440"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "akinaza.com:594550441"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-alias"]
  id = "yororis.com:596610816"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["dev-cname"]
  id = "yororis.com:594315274"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["qa-cname"]
  id = "yororis.com:595488975"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["www-cname"]
  id = "yororis.com:596610806"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "yororis.com:593348763"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "yororis.com:593348765"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "yororis.com:593348766"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "yororis.com:596353069"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "yororis.com:596355428"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "yororis.com:593350301"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "yororis.com:593350282"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "yororis.com:593348762"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "yororis.com:593348761"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "yororis.com:593348759"
}

import {
  to = module.dns_porkbun["yororis.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "yororis.com:593348760"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-alias"]
  id = "yasakia.com:596633663"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["admin-cname"]
  id = "yasakia.com:594588899"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["dev-cname"]
  id = "yasakia.com:594351393"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["www-cname"]
  id = "yasakia.com:596633654"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "yasakia.com:593228019"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "yasakia.com:593228021"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "yasakia.com:593228022"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "yasakia.com:596353066"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "yasakia.com:596355423"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "yasakia.com:593230437"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "yasakia.com:593230419"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "yasakia.com:593228018"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "yasakia.com:593228017"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "yasakia.com:593228015"
}

import {
  to = module.dns_porkbun["yasakia.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "yasakia.com:593228016"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "kachizaka.com:596614498"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["admin-cname"]
  id = "kachizaka.com:594810889"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["dev-cname"]
  id = "kachizaka.com:594800318"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["www-cname"]
  id = "kachizaka.com:596614489"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "kachizaka.com:594550405"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "kachizaka.com:594550406"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-txt"]
  id = "kachizaka.com:594550407"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "kachizaka.com:594550893"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "kachizaka.com:594550890"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "kachizaka.com:594550404"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "kachizaka.com:594550403"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "kachizaka.com:594550401"
}

import {
  to = module.dns_porkbun["kachizaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "kachizaka.com:594550402"
}

